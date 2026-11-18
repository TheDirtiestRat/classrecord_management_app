import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/services/grade_computation_service.dart';
import '../../academic_management/providers/academic_management_providers.dart';
import '../../students/providers/students_providers.dart';
import '../providers/grade_sheet_providers.dart';

class GradeSheetsPage extends ConsumerStatefulWidget {
  const GradeSheetsPage({super.key});

  @override
  ConsumerState<GradeSheetsPage> createState() => _GradeSheetsPageState();
}

class _GradeSheetsPageState extends ConsumerState<GradeSheetsPage> {
  int? subjectId;
  int periodIndex = 0;

  @override
  Widget build(BuildContext context) {
    final subjectsAsync = ref.watch(subjectsProvider);
    final periodsAsync = ref.watch(gradingPeriodsProvider);

    return Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Grade Sheets',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
              ),
              subjectsAsync.when(
                loading: () => const SizedBox(width: 320),
                error: (error, stack) => const Text('Unable to load subjects'),
                data: (subjects) {
                  if (subjects.isEmpty) {
                    return const Text(
                      'Create a subject first',
                      style: TextStyle(color: AppColors.textSecondary),
                    );
                  }
                  if (subjectId == null ||
                      !subjects.any((item) => item.id == subjectId)) {
                    subjectId = subjects.first.id;
                  }
                  return SizedBox(
                    width: 320,
                    child: DropdownButtonFormField<int>(
                      initialValue: subjectId,
                      decoration: const InputDecoration(labelText: 'Subject'),
                      items: subjects
                          .map(
                            (subject) => DropdownMenuItem(
                              value: subject.id,
                              child: Text(
                                '${subject.code} - ${subject.name}',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => subjectId = value);
                        }
                      },
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          periodsAsync.when(
            loading: () => const LinearProgressIndicator(),
            error: (error, stack) => Text('Unable to load periods: $error'),
            data: (periods) {
              if (periods.isEmpty || subjectId == null) {
                return const Expanded(
                  child: Center(
                    child: Text(
                      'Select a subject to open a grade sheet',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                );
              }
              if (periodIndex >= periods.length) periodIndex = 0;
              final query = GradeSheetQuery(
                subjectId: subjectId!,
                gradingPeriodId: periods[periodIndex].id,
              );
              return Expanded(
                child: Column(
                  children: [
                    Card(
                      margin: EdgeInsets.zero,
                      child: Row(
                        children: [
                          for (var index = 0; index < periods.length; index++)
                            Expanded(
                              child: InkWell(
                                onTap: () =>
                                    setState(() => periodIndex = index),
                                child: Container(
                                  height: 48,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: index == periodIndex
                                        ? AppColors.primary
                                        : AppColors.white,
                                    border: const Border(
                                      right: BorderSide(
                                        color: AppColors.border,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    periods[index].name,
                                    style: TextStyle(
                                      color: index == periodIndex
                                          ? AppColors.white
                                          : AppColors.text,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(child: GradeSheetGrid(query: query)),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class GradeSheetGrid extends ConsumerWidget {
  const GradeSheetGrid({required this.query, super.key});

  final GradeSheetQuery query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentsAsync = ref.watch(enrolledStudentsProvider(query.subjectId));
    final assessmentsAsync = ref.watch(gradeSheetAssessmentsProvider(query));
    final attendanceAsync = ref.watch(gradeSheetAttendanceProvider(query));
    final independentAsync = ref.watch(gradeSheetIndependentProvider(query));

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: studentsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Text('Unable to load students: $error'),
          data: (students) {
            if (students.isEmpty) {
              return const Center(
                child: Text(
                  'No students enrolled in this subject',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              );
            }
            return assessmentsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) =>
                  Text('Unable to load assessments: $error'),
              data: (assessments) => attendanceAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) =>
                    Text('Unable to load attendance: $error'),
                data: (attendance) => independentAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) =>
                      Text('Unable to load independent learning: $error'),
                  data: (independent) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => addAssessment(context, ref, query),
                            icon: const Icon(Icons.add, size: 18),
                            label: const Text('Assessment'),
                          ),
                          OutlinedButton.icon(
                            onPressed: () => addAttendance(context, ref, query),
                            icon: const Icon(Icons.event_available, size: 18),
                            label: const Text('Attendance Session'),
                          ),
                          OutlinedButton.icon(
                            onPressed: () =>
                                addIndependent(context, ref, query),
                            icon: const Icon(
                              Icons.auto_stories_outlined,
                              size: 18,
                            ),
                            label: const Text('Independent Learning'),
                          ),
                          OutlinedButton.icon(
                            onPressed: () =>
                                configureWeights(context, ref, query),
                            icon: const Icon(Icons.tune, size: 18),
                            label: const Text('Grading Weights'),
                          ),
                          ElevatedButton.icon(
                            onPressed: () => computeGrades(context, ref, query),
                            icon: const Icon(
                              Icons.calculate_outlined,
                              size: 18,
                            ),
                            label: const Text('Compute Grades'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SingleChildScrollView(
                            child: DataTable(
                              columns: [
                                const DataColumn(label: Text('Student')),
                                for (final assessment in assessments)
                                  DataColumn(
                                    label: SizedBox(
                                      width: 150,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            assessment.name,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            '${assessment.type} /${assessment.totalPossibleScore}',
                                            style: const TextStyle(
                                              fontSize: 11,
                                              color: AppColors.textSecondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                for (final session in attendance)
                                  DataColumn(
                                    label: SizedBox(
                                      width: 90,
                                      child: Text(
                                        session.sessionDate,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                for (final record in independent)
                                  DataColumn(
                                    label: SizedBox(
                                      width: 150,
                                      child: Text(
                                        record.activityName,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                              ],
                              rows: students
                                  .map(
                                    (student) => DataRow(
                                      cells: [
                                        DataCell(
                                          SizedBox(
                                            width: 210,
                                            child: Text(
                                              '${student.lastName}, ${student.firstName}',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        for (final assessment in assessments)
                                          DataCell(
                                            SizedBox(
                                              width: 120,
                                              child: TextField(
                                                key: ValueKey(
                                                  'assessment-${assessment.id}-${student.id}',
                                                ),
                                                keyboardType:
                                                    const TextInputType.numberWithOptions(
                                                      decimal: true,
                                                    ),
                                                decoration:
                                                    const InputDecoration(
                                                      isDense: true,
                                                      hintText: 'Missing',
                                                    ),
                                                onChanged: (value) async {
                                                  double? score;
                                                  if (value.trim().isNotEmpty) {
                                                    score = double.tryParse(
                                                      value,
                                                    );
                                                  }
                                                  if ((score == null &&
                                                          value
                                                              .trim()
                                                              .isNotEmpty) ||
                                                      (score != null &&
                                                          (score < 0 ||
                                                              score >
                                                                  assessment
                                                                      .totalPossibleScore))) {
                                                    return;
                                                  }
                                                  final database = await ref
                                                      .read(
                                                        appDatabaseProvider
                                                            .future,
                                                      );
                                                  await database
                                                      .saveAssessmentScore(
                                                        assessmentId:
                                                            assessment.id,
                                                        studentId: student.id,
                                                        score: score,
                                                      );
                                                },
                                              ),
                                            ),
                                          ),
                                        for (final session in attendance)
                                          DataCell(
                                            SizedBox(
                                              width: 76,
                                              child:
                                                  DropdownButtonFormField<
                                                    String
                                                  >(
                                                    isDense: true,
                                                    decoration:
                                                        const InputDecoration(
                                                          hintText: '-',
                                                        ),
                                                    items: const [
                                                      DropdownMenuItem(
                                                        value: 'P',
                                                        child: Text('P'),
                                                      ),
                                                      DropdownMenuItem(
                                                        value: 'L',
                                                        child: Text('L'),
                                                      ),
                                                      DropdownMenuItem(
                                                        value: 'A',
                                                        child: Text('A'),
                                                      ),
                                                      DropdownMenuItem(
                                                        value: 'E',
                                                        child: Text('E'),
                                                      ),
                                                    ],
                                                    onChanged: (code) async {
                                                      if (code == null) return;
                                                      final database = await ref
                                                          .read(
                                                            appDatabaseProvider
                                                                .future,
                                                          );
                                                      await database
                                                          .saveAttendanceCode(
                                                            attendanceSessionId:
                                                                session.id,
                                                            studentId:
                                                                student.id,
                                                            code: code,
                                                          );
                                                    },
                                                  ),
                                            ),
                                          ),
                                        for (final record in independent)
                                          DataCell(
                                            SizedBox(
                                              width: 120,
                                              child: TextField(
                                                keyboardType:
                                                    const TextInputType.numberWithOptions(
                                                      decimal: true,
                                                    ),
                                                decoration:
                                                    const InputDecoration(
                                                      isDense: true,
                                                      hintText: 'Missing',
                                                    ),
                                                onChanged: (value) async {
                                                  double? score;
                                                  if (value.trim().isNotEmpty) {
                                                    score = double.tryParse(
                                                      value,
                                                    );
                                                  }
                                                  if ((score == null &&
                                                          value
                                                              .trim()
                                                              .isNotEmpty) ||
                                                      (score != null &&
                                                          (score < 0 ||
                                                              score >
                                                                  record
                                                                      .totalPossibleScore))) {
                                                    return;
                                                  }
                                                  final database = await ref
                                                      .read(
                                                        appDatabaseProvider
                                                            .future,
                                                      );
                                                  await database
                                                      .saveIndependentLearningScore(
                                                        recordId: record.id,
                                                        studentId: student.id,
                                                        score: score,
                                                      );
                                                },
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Future<void> addAssessment(
  BuildContext context,
  WidgetRef ref,
  GradeSheetQuery query,
) async {
  final name = TextEditingController();
  final max = TextEditingController(text: '100');
  var type = 'Quiz';
  final saved = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => StatefulBuilder(
      builder: (dialogContext, setState) => AlertDialog(
        title: const Text('Add Assessment'),
        content: SizedBox(
          width: 460,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: type,
                decoration: const InputDecoration(labelText: 'Type'),
                items: const [
                  DropdownMenuItem(value: 'Quiz', child: Text('Quiz')),
                  DropdownMenuItem(value: 'Seatwork', child: Text('Seatwork')),
                  DropdownMenuItem(
                    value: 'Assignment',
                    child: Text('Assignment'),
                  ),
                  DropdownMenuItem(value: 'Activity', child: Text('Activity')),
                  DropdownMenuItem(value: 'Project', child: Text('Project')),
                  DropdownMenuItem(
                    value: 'Major Exam',
                    child: Text('Major Exam'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) setState(() => type = value);
                },
              ),
              const SizedBox(height: 12),
              TextField(
                controller: max,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Total Possible Score',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Add'),
          ),
        ],
      ),
    ),
  );
  if (saved == true &&
      name.text.trim().isNotEmpty &&
      (double.tryParse(max.text.trim()) ?? 0) > 0 &&
      context.mounted) {
    final database = await ref.read(appDatabaseProvider.future);
    await database.createAssessment(
      subjectId: query.subjectId,
      gradingPeriodId: query.gradingPeriodId,
      name: name.text.trim(),
      type: type,
      totalPossibleScore: double.parse(max.text.trim()),
    );
    ref.invalidate(gradeSheetAssessmentsProvider(query));
  }
  name.dispose();
  max.dispose();
}

Future<void> addAttendance(
  BuildContext context,
  WidgetRef ref,
  GradeSheetQuery query,
) async {
  final date = TextEditingController(
    text: DateTime.now().toIso8601String().substring(0, 10),
  );
  final saved = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Add Attendance Session'),
      content: TextField(
        controller: date,
        decoration: const InputDecoration(
          labelText: 'Date',
          hintText: 'YYYY-MM-DD',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(dialogContext, true),
          child: const Text('Add'),
        ),
      ],
    ),
  );
  if (saved == true && date.text.trim().isNotEmpty && context.mounted) {
    final database = await ref.read(appDatabaseProvider.future);
    await database.createAttendanceSession(
      subjectId: query.subjectId,
      gradingPeriodId: query.gradingPeriodId,
      sessionDate: date.text.trim(),
    );
    ref.invalidate(gradeSheetAttendanceProvider(query));
  }
  date.dispose();
}

Future<void> addIndependent(
  BuildContext context,
  WidgetRef ref,
  GradeSheetQuery query,
) async {
  final name = TextEditingController();
  final description = TextEditingController();
  final max = TextEditingController(text: '100');
  final saved = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Add Independent Learning'),
      content: SizedBox(
        width: 460,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(labelText: 'Activity Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: description,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: max,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Total Possible Score',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(dialogContext, true),
          child: const Text('Add'),
        ),
      ],
    ),
  );
  if (saved == true &&
      name.text.trim().isNotEmpty &&
      (double.tryParse(max.text.trim()) ?? 0) > 0 &&
      context.mounted) {
    final database = await ref.read(appDatabaseProvider.future);
    await database.createIndependentLearningRecord(
      subjectId: query.subjectId,
      gradingPeriodId: query.gradingPeriodId,
      activityName: name.text.trim(),
      description: description.text.trim(),
      totalPossibleScore: double.parse(max.text.trim()),
    );
    ref.invalidate(gradeSheetIndependentProvider(query));
  }
  name.dispose();
  description.dispose();
  max.dispose();
}

Future<void> configureWeights(
  BuildContext context,
  WidgetRef ref,
  GradeSheetQuery query,
) async {
  final database = await ref.read(appDatabaseProvider.future);
  final config = await database.getActiveGradingConfiguration(query.subjectId);
  if (!context.mounted) return;
  final quiz = TextEditingController(
    text: (config?.quizWeight ?? 20).toStringAsFixed(0),
  );
  final attendance = TextEditingController(
    text: (config?.attendanceWeight ?? 10).toStringAsFixed(0),
  );
  final work = TextEditingController(
    text: (config?.workWeight ?? 20).toStringAsFixed(0),
  );
  final exam = TextEditingController(
    text: (config?.majorExamWeight ?? 40).toStringAsFixed(0),
  );
  final independent = TextEditingController(
    text: (config?.independentLearningWeight ?? 10).toStringAsFixed(0),
  );
  final saved = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Grading Weights'),
      content: SizedBox(
        width: 420,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: quiz,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quizzes %'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: attendance,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Attendance %'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: work,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Seatwork / Work / Activities / Projects %',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: exam,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Major Exams %'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: independent,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Independent Learning %',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(dialogContext, true),
          child: const Text('Save'),
        ),
      ],
    ),
  );
  if (saved == true && context.mounted) {
    final weights = GradeWeights(
      quizzes: double.tryParse(quiz.text.trim()) ?? -1,
      attendance: double.tryParse(attendance.text.trim()) ?? -1,
      work: double.tryParse(work.text.trim()) ?? -1,
      majorExams: double.tryParse(exam.text.trim()) ?? -1,
      independentLearning: double.tryParse(independent.text.trim()) ?? -1,
    );
    if (weights.isValid && context.mounted) {
      await database.saveGradingConfiguration(
        subjectId: query.subjectId,
        quizWeight: weights.quizzes,
        attendanceWeight: weights.attendance,
        workWeight: weights.work,
        majorExamWeight: weights.majorExams,
        independentLearningWeight: weights.independentLearning,
        decimalPlaces: config?.decimalPlaces ?? 2,
      );
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Grading weights saved.')));
    } else if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Grading weights must total exactly 100%.'),
        ),
      );
    }
  }
  quiz.dispose();
  attendance.dispose();
  work.dispose();
  exam.dispose();
  independent.dispose();
}

Future<void> computeGrades(
  BuildContext context,
  WidgetRef ref,
  GradeSheetQuery query,
) async {
  final database = await ref.read(appDatabaseProvider.future);
  final students = await database.getEnrolledStudents(query.subjectId);
  final assessments = await database.getAssessments(
    subjectId: query.subjectId,
    gradingPeriodId: query.gradingPeriodId,
  );
  final attendanceSessions = await database.getAttendanceSessions(
    subjectId: query.subjectId,
    gradingPeriodId: query.gradingPeriodId,
  );
  final independentRecords = await database.getIndependentLearningRecords(
    subjectId: query.subjectId,
    gradingPeriodId: query.gradingPeriodId,
  );
  final config = await database.getActiveGradingConfiguration(query.subjectId);
  final weights = GradeWeights(
    quizzes: config?.quizWeight ?? 20,
    attendance: config?.attendanceWeight ?? 10,
    work: config?.workWeight ?? 20,
    majorExams: config?.majorExamWeight ?? 40,
    independentLearning: config?.independentLearningWeight ?? 10,
  );
  const attendanceValues = AttendanceValues();
  const computation = GradeComputationService();
  final entries = <({int studentId, int rank, double grade})>[];

  for (final student in students) {
    final quizzes = <GradeComponentInput>[];
    final work = <GradeComponentInput>[];
    final exams = <GradeComponentInput>[];
    for (final assessment in assessments) {
      final scores = await database.getAssessmentScores(assessment.id);
      final match = scores.where((score) => score.studentId == student.id);
      if (match.isEmpty || match.first.score == null) continue;
      final input = GradeComponentInput(
        earned: match.first.score!,
        possible: assessment.totalPossibleScore,
      );
      final type = assessment.type.toLowerCase();
      if (type.contains('exam')) {
        exams.add(input);
      } else if (type.contains('quiz')) {
        quizzes.add(input);
      } else {
        work.add(input);
      }
    }

    final attendance = <GradeComponentInput>[];
    for (final session in attendanceSessions) {
      final records = await database.getStudentAttendance(session.id);
      final match = records.where((record) => record.studentId == student.id);
      final value = match.isEmpty
          ? double.nan
          : attendanceValues.valueFor(match.first.code);
      if (!value.isNaN) {
        attendance.add(GradeComponentInput(earned: value, possible: 100));
      }
    }

    final independent = <GradeComponentInput>[];
    for (final record in independentRecords) {
      final scores = await database.getIndependentLearningScores(record.id);
      final match = scores.where((score) => score.studentId == student.id);
      if (match.isNotEmpty && match.first.score != null) {
        independent.add(
          GradeComponentInput(
            earned: match.first.score!,
            possible: record.totalPossibleScore,
          ),
        );
      }
    }

    final grade = computation.computeTermGrade(
      weights: weights,
      quizzes: quizzes,
      attendance: attendance,
      work: work,
      majorExams: exams,
      independentLearning: independent,
      decimalPlaces: config?.decimalPlaces ?? 2,
    );
    await database.saveTermGrade(
      subjectId: query.subjectId,
      studentId: student.id,
      gradingPeriodId: query.gradingPeriodId,
      grade: grade,
    );
    if (grade != null) {
      entries.add((studentId: student.id, rank: 0, grade: grade));
    }
  }

  final rankingInput = entries
      .map(
        (entry) => GradeRankingEntry(
          studentId: entry.studentId,
          studentName: '',
          grade: entry.grade,
        ),
      )
      .toList();
  final ranked = GradeComputationService.rankEntries(rankingInput);
  await database.replaceRankings(
    subjectId: query.subjectId,
    gradingPeriodId: query.gradingPeriodId,
    rankings: ranked
        .map(
          (entry) => (
            studentId: entry.studentId,
            rank: entry.rank!,
            grade: entry.grade,
          ),
        )
        .toList(),
  );
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Grades computed for ${entries.length} complete student records.',
        ),
      ),
    );
  }
}
