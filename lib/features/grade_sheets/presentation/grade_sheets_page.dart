import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/services/grade_computation_service.dart';
import '../../../core/services/term_grade_calculation_service.dart';
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
          LayoutBuilder(
            builder: (context, constraints) {
              final subjectSelector = subjectsAsync.when(
                loading: () => const SizedBox(
                  height: 56,
                  child: Center(child: CircularProgressIndicator()),
                ),
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
                  return DropdownButtonFormField<int>(
                    initialValue: subjectId,
                    isExpanded: true,
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
                  );
                },
              );
              const title = Text(
                'Grade Sheets',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              );
              if (constraints.maxWidth < 720) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    title,
                    const SizedBox(height: 12),
                    subjectSelector,
                  ],
                );
              }
              return Row(
                children: [
                  Expanded(child: title),
                  SizedBox(width: 320, child: subjectSelector),
                ],
              );
            },
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
              return Expanded(
                child: DefaultTabController(
                  length: periods.length,
                  initialIndex: periodIndex,
                  child: Column(
                    children: [
                      Card(
                        margin: EdgeInsets.zero,
                        clipBehavior: Clip.antiAlias,
                        child: TabBar(
                          isScrollable: false,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorWeight: 3,
                          labelColor: AppColors.primary,
                          unselectedLabelColor: AppColors.textSecondary,
                          onTap: (index) => setState(() => periodIndex = index),
                          tabs: [
                            for (final period in periods)
                              Tab(
                                text:
                                    period.name.toString().toLowerCase() ==
                                        'final'
                                    ? 'Finals'
                                    : period.name,
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: TabBarView(
                          children: [
                            for (final period in periods)
                              GradeSheetGrid(
                                key: ValueKey((subjectId, period.id)),
                                query: GradeSheetQuery(
                                  subjectId: subjectId!,
                                  gradingPeriodId: period.id,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class GradeSheetGrid extends ConsumerStatefulWidget {
  const GradeSheetGrid({required this.query, super.key});

  final GradeSheetQuery query;

  @override
  ConsumerState<GradeSheetGrid> createState() => _GradeSheetGridState();
}

class _GradeSheetGridState extends ConsumerState<GradeSheetGrid>
    with AutomaticKeepAliveClientMixin {
  final _tableScrollController = ScrollController();
  final _tableVerticalScrollController = ScrollController();
  final _cellFocusNodes = <(int, int), FocusNode>{};
  final _pendingGradeQueries = <GradeSheetQuery>{};
  final _pendingSubjects = <int>{};
  (int, int)? _pendingFocusCell;
  List<double> _tableColumnWidths = const [];
  int _currentPage = 0;
  int _pageSize = 25;
  bool _pendingAllSubjects = false;
  Future<void>? _gradeRecalculation;

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _tableScrollController.dispose();
    _tableVerticalScrollController.dispose();
    for (final focusNode in _cellFocusNodes.values) {
      focusNode.dispose();
    }
    super.dispose();
  }

  FocusNode _focusNodeFor(int studentIndex, int columnIndex) =>
      _cellFocusNodes.putIfAbsent((studentIndex, columnIndex), FocusNode.new);

  Future<void> _navigateToCell(
    int studentIndex,
    int columnIndex,
    int studentCount,
    int editableColumnCount,
  ) async {
    if (studentIndex < 0 ||
        studentIndex >= studentCount ||
        columnIndex < 1 ||
        columnIndex > editableColumnCount) {
      return;
    }

    final target = (studentIndex, columnIndex);
    _pendingFocusCell = target;
    final targetPage = studentIndex ~/ _pageSize;
    setState(() => _currentPage = targetPage);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _pendingFocusCell != target) return;
      _scrollToCell(studentIndex % _pageSize, columnIndex);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusPendingCell(target);
      });
    });
  }

  void _scrollToCell(int localRow, int columnIndex) {
    if (_tableVerticalScrollController.hasClients) {
      final position = _tableVerticalScrollController.position;
      final top = localRow * 44.0;
      final bottom = top + 44.0;
      final visibleHeight = (position.viewportDimension - 58.0).clamp(
        0.0,
        double.infinity,
      );
      var offset = position.pixels;
      if (top < offset) {
        offset = top;
      } else if (bottom > offset + visibleHeight) {
        offset = bottom - visibleHeight;
      }
      offset = offset.clamp(0.0, position.maxScrollExtent);
      if (offset != position.pixels) {
        _tableVerticalScrollController.jumpTo(offset);
      }
    }

    if (_tableScrollController.hasClients &&
        _tableColumnWidths.isNotEmpty &&
        columnIndex < _tableColumnWidths.length) {
      final position = _tableScrollController.position;
      final pinnedWidth = _tableColumnWidths[0];
      final regularColIndex =
          (columnIndex - 1).clamp(0, _tableColumnWidths.length - 1);
      final left = _tableColumnWidths
          .skip(1)
          .take(regularColIndex)
          .fold<double>(0, (total, width) => total + width);
      final right = left + _tableColumnWidths[columnIndex];
      final visibleWidth = (position.viewportDimension - pinnedWidth).clamp(
        0.0,
        double.infinity,
      );
      var offset = position.pixels;
      if (left < offset) {
        offset = left;
      } else if (right > offset + visibleWidth) {
        offset = right - visibleWidth;
      }
      offset = offset.clamp(0.0, position.maxScrollExtent);
      if (offset != position.pixels) {
        _tableScrollController.jumpTo(offset);
      }
    }
  }

  void _focusPendingCell((int, int) target) {
    if (!mounted || _pendingFocusCell != target) return;
    final focusNode = _cellFocusNodes[target];
    if (focusNode?.context == null) return;
    _pendingFocusCell = null;
    focusNode!.requestFocus();
  }

  void _showSaveError(Object error) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Unable to save grade sheet entry: $error'),
        backgroundColor: AppColors.red,
      ),
    );
  }

  void _showRecalculationError(Object error) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Changes saved, but grade recalculation failed: $error'),
        backgroundColor: AppColors.red,
      ),
    );
  }

  Future<void> _recalculateGrades(
    AppDatabase database, {
    GradeSheetQuery? query,
    int? subjectId,
    bool allSubjects = false,
  }) {
    if (allSubjects) {
      _pendingAllSubjects = true;
    } else if (subjectId != null) {
      _pendingSubjects.add(subjectId);
    } else if (query != null) {
      _pendingGradeQueries.add(query);
    }

    final running = _gradeRecalculation;
    if (running != null) return running;

    final calculation = _drainGradeRecalculations(database);
    _gradeRecalculation = calculation;
    return calculation;
  }

  Future<void> _drainGradeRecalculations(AppDatabase database) async {
    try {
      while (_pendingAllSubjects ||
          _pendingSubjects.isNotEmpty ||
          _pendingGradeQueries.isNotEmpty) {
        final queries = <GradeSheetQuery>{};
        if (_pendingAllSubjects) {
          _pendingAllSubjects = false;
          _pendingSubjects.clear();
          _pendingGradeQueries.clear();
          final subjects = await database.getAllSubjects();
          final periods = await database.getGradingPeriods();
          queries.addAll([
            for (final subject in subjects)
              for (final period in periods)
                GradeSheetQuery(
                  subjectId: subject.id,
                  gradingPeriodId: period.id,
                ),
          ]);
        } else if (_pendingSubjects.isNotEmpty) {
          final subjects = _pendingSubjects.toList();
          _pendingSubjects.clear();
          final periods = await database.getGradingPeriods();
          queries.addAll([
            for (final subjectId in subjects)
              for (final period in periods)
                GradeSheetQuery(
                  subjectId: subjectId,
                  gradingPeriodId: period.id,
                ),
          ]);
        }
        queries.addAll(_pendingGradeQueries);
        _pendingGradeQueries.clear();

        for (final query in queries) {
          try {
            await const TermGradeCalculationService().computeAndSave(
              database: database,
              subjectId: query.subjectId,
              gradingPeriodId: query.gradingPeriodId,
            );
            if (mounted) ref.invalidate(gradeSheetScoresProvider(query));
          } catch (error) {
            _showRecalculationError(error);
          }
        }
      }
    } catch (error) {
      _showRecalculationError(error);
    } finally {
      _gradeRecalculation = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final query = widget.query;
    final studentsAsync = ref.watch(enrolledStudentsProvider(query.subjectId));
    final assessmentsAsync = ref.watch(gradeSheetAssessmentsProvider(query));
    final attendanceAsync = ref.watch(gradeSheetAttendanceProvider(query));
    final independentAsync = ref.watch(gradeSheetIndependentProvider(query));
    final scoresAsync = ref.watch(gradeSheetScoresProvider(query));
    final databaseAsync = ref.watch(appDatabaseProvider);

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
                  data: (independent) => scoresAsync.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stack) =>
                        Text('Unable to load saved scores: $error'),
                    data: (scores) => databaseAsync.when(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, stack) =>
                          Text('Unable to open database: $error'),
                      data: (database) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () => addAssessment(
                                  context,
                                  ref,
                                  query,
                                  onSaved: () => _recalculateGrades(
                                    database,
                                    query: query,
                                  ),
                                ),
                                icon: const Icon(Icons.add, size: 18),
                                label: const Text('Assessment'),
                              ),
                              OutlinedButton.icon(
                                onPressed: () => addAttendance(
                                  context,
                                  ref,
                                  query,
                                  onSaved: () => _recalculateGrades(
                                    database,
                                    query: query,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.event_available,
                                  size: 18,
                                ),
                                label: const Text('Attendance Session'),
                              ),
                              OutlinedButton.icon(
                                onPressed: () => addIndependent(
                                  context,
                                  ref,
                                  query,
                                  onSaved: () => _recalculateGrades(
                                    database,
                                    query: query,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.auto_stories_outlined,
                                  size: 18,
                                ),
                                label: const Text('Independent Learning'),
                              ),
                              OutlinedButton.icon(
                                onPressed: () => configureWeights(
                                  context,
                                  ref,
                                  query,
                                  onSaved: () => _recalculateGrades(
                                    database,
                                    subjectId: query.subjectId,
                                  ),
                                ),
                                icon: const Icon(Icons.tune, size: 18),
                                label: const Text('Grading Weights'),
                              ),
                              OutlinedButton.icon(
                                onPressed: () => configureAttendance(
                                  context,
                                  ref,
                                  onSaved: () => _recalculateGrades(
                                    database,
                                    allSubjects: true,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.fact_check_outlined,
                                  size: 18,
                                ),
                                label: const Text('Attendance Scoring'),
                              ),
                              ElevatedButton.icon(
                                onPressed: () =>
                                    computeGrades(context, ref, query),
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
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                const studentWidth = 210.0;
                                const assessmentWidth = 128.0;
                                const attendanceWidth = 92.0;
                                const independentWidth = 138.0;
                                const computedGradeWidth = 112.0;
                                final pageCount = (students.length / _pageSize)
                                    .ceil();
                                if (_currentPage >= pageCount) {
                                  _currentPage = pageCount - 1;
                                }
                                final pageStart = _currentPage * _pageSize;
                                final pageStudents = students
                                    .skip(pageStart)
                                    .take(_pageSize)
                                    .toList();
                                final minimumTableWidth =
                                    studentWidth +
                                    assessments.length * assessmentWidth +
                                    attendance.length * attendanceWidth +
                                    independent.length * independentWidth +
                                    computedGradeWidth;
                                final columnCount =
                                    2 +
                                    assessments.length +
                                    attendance.length +
                                    independent.length;
                                final extraColumnWidth =
                                    constraints.maxWidth > minimumTableWidth
                                    ? (constraints.maxWidth -
                                              minimumTableWidth) /
                                          columnCount
                                    : 0.0;
                                final columnWidths = <double>[
                                  studentWidth + extraColumnWidth,
                                  ...List<double>.filled(
                                    assessments.length,
                                    assessmentWidth + extraColumnWidth,
                                  ),
                                  ...List<double>.filled(
                                    attendance.length,
                                    attendanceWidth + extraColumnWidth,
                                  ),
                                  ...List<double>.filled(
                                    independent.length,
                                    independentWidth + extraColumnWidth,
                                  ),
                                  computedGradeWidth + extraColumnWidth,
                                ];
                                _tableColumnWidths = columnWidths;
                                final assessmentStart = 1;
                                final attendanceStart =
                                    assessmentStart + assessments.length;
                                final independentStart =
                                    attendanceStart + attendance.length;
                                final gradeColumn =
                                    independentStart + independent.length;
                                final editableColumnCount = gradeColumn - 1;

                                Widget borderedCell(
                                  Widget child, {
                                  Alignment alignment = Alignment.centerLeft,
                                  EdgeInsets padding =
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  Color? color,
                                }) => Container(
                                  alignment: alignment,
                                  padding: padding,
                                  decoration: BoxDecoration(
                                    color: color,
                                    border: Border(
                                      right: BorderSide(
                                        color: AppColors.border,
                                        width: 0.6,
                                      ),
                                      bottom: BorderSide(
                                        color: AppColors.border,
                                        width: 0.6,
                                      ),
                                    ),
                                  ),
                                  child: child,
                                );

                                Widget headerCell(int column) {
                                  if (column == 0) {
                                    return borderedCell(
                                      const Text(
                                        'Student',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      color: AppColors.background,
                                    );
                                  }
                                  if (column < attendanceStart) {
                                    final assessment =
                                        assessments[column - assessmentStart];
                                    return borderedCell(
                                      PopupMenuButton<_AssessmentHeaderAction>(
                                        padding: EdgeInsets.zero,
                                        tooltip: 'Assessment options',
                                        onSelected: (action) {
                                          if (action ==
                                              _AssessmentHeaderAction.edit) {
                                            editAssessment(
                                              context,
                                              ref,
                                              query,
                                              assessment,
                                              onSaved: () => _recalculateGrades(
                                                database,
                                                query: query,
                                              ),
                                            );
                                          } else {
                                            deleteAssessment(
                                              context,
                                              ref,
                                              query,
                                              assessment,
                                              onSaved: () => _recalculateGrades(
                                                database,
                                                query: query,
                                              ),
                                            );
                                          }
                                        },
                                        itemBuilder: (context) => const [
                                          PopupMenuItem(
                                            value: _AssessmentHeaderAction.edit,
                                            child: Text('Edit assessment'),
                                          ),
                                          PopupMenuItem(
                                            value:
                                                _AssessmentHeaderAction.delete,
                                            child: Text('Delete assessment'),
                                          ),
                                        ],
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    assessment.name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    '${assessment.type} / ${assessment.totalPossibleScore}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 11,
                                                      color: AppColors
                                                          .textSecondary,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Icon(
                                              Icons.more_vert,
                                              size: 18,
                                              color: AppColors.textSecondary,
                                            ),
                                          ],
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                      ),
                                      color: AppColors.background,
                                    );
                                  }
                                  if (column < independentStart) {
                                    final session =
                                        attendance[column - attendanceStart];
                                    return borderedCell(
                                      Text(
                                        session.sessionDate,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      color: AppColors.background,
                                    );
                                  }
                                  if (column < gradeColumn) {
                                    final record =
                                        independent[column - independentStart];
                                    return borderedCell(
                                      Text(
                                        record.activityName,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      color: AppColors.background,
                                    );
                                  }
                                  return borderedCell(
                                    const Text(
                                      'Grade',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    color: AppColors.background,
                                  );
                                }

                                Widget dataCell(int row, int column) {
                                  final student = pageStudents[row];
                                  final studentIndex = pageStart + row;
                                  if (column == 0) {
                                    return borderedCell(
                                      Text(
                                        '${student.lastName}, ${student.firstName}',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      color: AppColors.white,
                                    );
                                  }
                                  if (column < attendanceStart) {
                                    final assessment =
                                        assessments[column - assessmentStart];
                                    final target = (studentIndex, column);
                                    final focusNode = _focusNodeFor(
                                      studentIndex,
                                      column,
                                    );
                                    if (_pendingFocusCell == target) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback(
                                            (_) => _focusPendingCell(target),
                                          );
                                    }
                                    return borderedCell(
                                      _GradeScoreInput(
                                        key: ValueKey(
                                          'assessment-${assessment.id}-${student.id}',
                                        ),
                                        focusNode: focusNode,
                                        initialScore:
                                            scores.assessmentScores[(
                                              assessment.id,
                                              student.id,
                                            )],
                                        maximum: assessment.totalPossibleScore,
                                        onNavigate: (rowDelta, columnDelta) =>
                                            _navigateToCell(
                                              studentIndex + rowDelta,
                                              column + columnDelta,
                                              students.length,
                                              editableColumnCount,
                                            ),
                                        onSave: (score) async {
                                          await database.saveAssessmentScore(
                                            assessmentId: assessment.id,
                                            studentId: student.id,
                                            score: score,
                                          );
                                          await _recalculateGrades(
                                            database,
                                            query: query,
                                          );
                                        },
                                        onSaveError: _showSaveError,
                                      ),
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                    );
                                  }
                                  if (column < independentStart) {
                                    final session =
                                        attendance[column - attendanceStart];
                                    final target = (studentIndex, column);
                                    final focusNode = _focusNodeFor(
                                      studentIndex,
                                      column,
                                    );
                                    if (_pendingFocusCell == target) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback(
                                            (_) => _focusPendingCell(target),
                                          );
                                    }
                                    return borderedCell(
                                      _AttendanceCodeInput(
                                        key: ValueKey(
                                          'attendance-${session.id}-${student.id}',
                                        ),
                                        focusNode: focusNode,
                                        onNavigate: (rowDelta, columnDelta) =>
                                            _navigateToCell(
                                              studentIndex + rowDelta,
                                              column + columnDelta,
                                              students.length,
                                              editableColumnCount,
                                            ),
                                        initialCode:
                                            scores.attendanceCodes[(
                                              session.id,
                                              student.id,
                                            )],
                                        onSave: (code) async {
                                          await database.saveAttendanceCode(
                                            attendanceSessionId: session.id,
                                            studentId: student.id,
                                            code: code,
                                          );
                                          await _recalculateGrades(
                                            database,
                                            query: query,
                                          );
                                        },
                                        onSaveError: _showSaveError,
                                      ),
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                    );
                                  }
                                  if (column < gradeColumn) {
                                    final record =
                                        independent[column - independentStart];
                                    final target = (studentIndex, column);
                                    final focusNode = _focusNodeFor(
                                      studentIndex,
                                      column,
                                    );
                                    if (_pendingFocusCell == target) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback(
                                            (_) => _focusPendingCell(target),
                                          );
                                    }
                                    return borderedCell(
                                      _GradeScoreInput(
                                        key: ValueKey(
                                          'independent-${record.id}-${student.id}',
                                        ),
                                        focusNode: focusNode,
                                        initialScore:
                                            scores.independentLearningScores[(
                                              record.id,
                                              student.id,
                                            )],
                                        maximum: record.totalPossibleScore,
                                        onNavigate: (rowDelta, columnDelta) =>
                                            _navigateToCell(
                                              studentIndex + rowDelta,
                                              column + columnDelta,
                                              students.length,
                                              editableColumnCount,
                                            ),
                                        onSave: (score) async {
                                          await database
                                              .saveIndependentLearningScore(
                                                recordId: record.id,
                                                studentId: student.id,
                                                score: score,
                                              );
                                          await _recalculateGrades(
                                            database,
                                            query: query,
                                          );
                                        },
                                        onSaveError: _showSaveError,
                                      ),
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                    );
                                  }
                                  return borderedCell(
                                    Text(
                                      switch (scores.termGrades[student.id]) {
                                        null => 'Not computed',
                                        final termGrade =>
                                          termGrade.grade?.toStringAsFixed(2) ??
                                              'Incomplete',
                                      },
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: AppColors.textSecondary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    color: AppColors.background,
                                  );
                                }

                                return Column(
                                  children: [
                                    Expanded(
                                      child: Scrollbar(
                                        controller: _tableScrollController,
                                        thumbVisibility: true,
                                        trackVisibility: true,
                                        interactive: true,
                                        scrollbarOrientation:
                                            ScrollbarOrientation.bottom,
                                        notificationPredicate: (notification) =>
                                            notification.metrics.axis ==
                                            Axis.horizontal,
                                        child: Scrollbar(
                                          controller:
                                              _tableVerticalScrollController,
                                          thumbVisibility: true,
                                          trackVisibility: true,
                                          interactive: true,
                                          scrollbarOrientation:
                                              ScrollbarOrientation.right,
                                          notificationPredicate:
                                              (notification) =>
                                                  notification.metrics.axis ==
                                                  Axis.vertical,
                                          child: TableView.builder(
                                            columnCount: columnWidths.length,
                                            rowCount: pageStudents.length + 1,
                                            pinnedRowCount: 1,
                                            pinnedColumnCount: 1,
                                            horizontalDetails:
                                                ScrollableDetails.horizontal(
                                                  controller:
                                                      _tableScrollController,
                                                ),
                                            verticalDetails:
                                                ScrollableDetails.vertical(
                                                  controller:
                                                      _tableVerticalScrollController,
                                                ),
                                            columnBuilder: (column) =>
                                                TableSpan(
                                                  extent: FixedTableSpanExtent(
                                                    columnWidths[column],
                                                  ),
                                                ),
                                            rowBuilder: (row) => TableSpan(
                                              extent: FixedTableSpanExtent(
                                                row == 0 ? 58 : 44,
                                              ),
                                            ),
                                            cellBuilder: (context, vicinity) =>
                                                TableViewCell(
                                                  child: vicinity.row == 0
                                                      ? headerCell(
                                                          vicinity.column,
                                                        )
                                                      : dataCell(
                                                          vicinity.row - 1,
                                                          vicinity.column,
                                                        ),
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      spacing: 8,
                                      runSpacing: 4,
                                      children: [
                                        Text(
                                          'Page ${_currentPage + 1} of $pageCount '
                                          '(${students.length} students)',
                                          style: const TextStyle(
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                        const Text('Rows per page:'),
                                        DropdownButton<int>(
                                          value: _pageSize,
                                          isDense: true,
                                          items: const [
                                            DropdownMenuItem(
                                              value: 10,
                                              child: Text('10'),
                                            ),
                                            DropdownMenuItem(
                                              value: 25,
                                              child: Text('25'),
                                            ),
                                            DropdownMenuItem(
                                              value: 50,
                                              child: Text('50'),
                                            ),
                                            DropdownMenuItem(
                                              value: 100,
                                              child: Text('100'),
                                            ),
                                          ],
                                          onChanged: (value) {
                                            if (value == null) return;
                                            setState(() {
                                              _pageSize = value;
                                              _currentPage = 0;
                                              _pendingFocusCell = null;
                                            });
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                                  if (_tableVerticalScrollController
                                                      .hasClients) {
                                                    _tableVerticalScrollController
                                                        .jumpTo(0);
                                                  }
                                                });
                                          },
                                        ),
                                        IconButton(
                                          tooltip: 'Previous page',
                                          onPressed: _currentPage > 0
                                              ? () {
                                                  setState(
                                                    () => _currentPage--,
                                                  );
                                                  WidgetsBinding.instance
                                                      .addPostFrameCallback((
                                                        _,
                                                      ) {
                                                        if (_tableVerticalScrollController
                                                            .hasClients) {
                                                          _tableVerticalScrollController
                                                              .jumpTo(0);
                                                        }
                                                      });
                                                }
                                              : null,
                                          icon: const Icon(Icons.chevron_left),
                                        ),
                                        IconButton(
                                          tooltip: 'Next page',
                                          onPressed:
                                              _currentPage + 1 < pageCount
                                              ? () {
                                                  setState(
                                                    () => _currentPage++,
                                                  );
                                                  WidgetsBinding.instance
                                                      .addPostFrameCallback((
                                                        _,
                                                      ) {
                                                        if (_tableVerticalScrollController
                                                            .hasClients) {
                                                          _tableVerticalScrollController
                                                              .jumpTo(0);
                                                        }
                                                      });
                                                }
                                              : null,
                                          icon: const Icon(Icons.chevron_right),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
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

class _GradeScoreInput extends StatefulWidget {
  const _GradeScoreInput({
    required this.initialScore,
    required this.maximum,
    required this.focusNode,
    required this.onNavigate,
    required this.onSave,
    required this.onSaveError,
    super.key,
  });

  final double? initialScore;
  final double maximum;
  final FocusNode focusNode;
  final Future<void> Function(int rowDelta, int columnDelta) onNavigate;
  final Future<void> Function(double? score) onSave;
  final void Function(Object error) onSaveError;

  @override
  State<_GradeScoreInput> createState() => _GradeScoreInputState();
}

class _GradeScoreInputState extends State<_GradeScoreInput> {
  late final TextEditingController _controller;
  Future<void> _saveQueue = Future<void>.value();
  Timer? _debounceTimer;
  Timer? _savedIndicatorTimer;
  double? _lastSaved;
  double? _latestScheduledValue;
  bool _isDirty = false;
  bool _hasInvalidInput = false;
  bool _saveFailed = false;
  bool _justSaved = false;
  bool _isEditing = false;
  int _savingCount = 0;

  @override
  void initState() {
    super.initState();
    _lastSaved = widget.initialScore;
    _controller = TextEditingController(
      text: _formatScore(widget.initialScore),
    );
  }

  @override
  void didUpdateWidget(covariant _GradeScoreInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialScore != oldWidget.initialScore &&
        !_isDirty &&
        _savingCount == 0) {
      _lastSaved = widget.initialScore;
      _controller.text = _formatScore(widget.initialScore);
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _savedIndicatorTimer?.cancel();
    if (_isDirty && !_hasInvalidInput) {
      unawaited(_saveValue(_readValue(), updateUi: false));
    }
    _controller.dispose();
    super.dispose();
  }

  String _formatScore(double? score) {
    if (score == null) return '';
    return score == score.roundToDouble()
        ? score.toStringAsFixed(0)
        : score.toString();
  }

  double? _readValue() {
    final text = _controller.text.trim();
    return text.isEmpty ? null : double.tryParse(text);
  }

  bool _isValid(String text) {
    if (text.trim().isEmpty) return true;
    final score = double.tryParse(text);
    return score != null &&
        score.isFinite &&
        score >= 0 &&
        score <= widget.maximum;
  }

  void _handleChange(String text) {
    _debounceTimer?.cancel();
    setState(() {
      _isEditing = true;
      _hasInvalidInput = !_isValid(text);
      _isDirty =
          !_hasInvalidInput &&
          _readValue() !=
              (_savingCount > 0 ? _latestScheduledValue : _lastSaved);
      _saveFailed = false;
      _justSaved = false;
    });
    _savedIndicatorTimer?.cancel();
    if (!_hasInvalidInput && _isDirty) {
      _debounceTimer = Timer(
        const Duration(milliseconds: 450),
        () => unawaited(_saveValue(_readValue())),
      );
    }
  }

  Future<bool> _saveValue(double? value, {bool updateUi = true}) async {
    _debounceTimer?.cancel();
    final latestValue = _savingCount > 0 ? _latestScheduledValue : _lastSaved;
    if (_hasInvalidInput) return false;
    if (value == latestValue) {
      if (_savingCount > 0) {
        try {
          await _saveQueue;
          return true;
        } catch (_) {
          return false;
        }
      }
      if (updateUi && mounted && !_hasInvalidInput) {
        setState(() => _isDirty = false);
      }
      return true;
    }

    _latestScheduledValue = value;
    if (updateUi && mounted) setState(() => _savingCount++);
    final save = _saveQueue.then(
      (_) => widget.onSave(value),
      onError: (Object _) => widget.onSave(value),
    );
    _saveQueue = save;

    try {
      await save;
      _lastSaved = value;
      if (updateUi && mounted) {
        setState(() {
          _saveFailed = false;
          _justSaved = true;
          _isDirty = !_hasInvalidInput && _readValue() != _lastSaved;
        });
        _savedIndicatorTimer?.cancel();
        _savedIndicatorTimer = Timer(const Duration(seconds: 1), () {
          if (mounted) setState(() => _justSaved = false);
        });
      }
      return true;
    } catch (error) {
      if (updateUi && mounted) {
        setState(() {
          _saveFailed = true;
          _justSaved = false;
        });
      }
      widget.onSaveError(error);
      return false;
    } finally {
      if (updateUi && mounted) setState(() => _savingCount--);
    }
  }

  Future<void> _commitAndNavigate(int rowDelta, int columnDelta) async {
    if (_hasInvalidInput) return;
    if (!await _saveValue(_readValue())) return;
    if (!mounted) return;
    setState(() => _isEditing = false);
    await widget.onNavigate(rowDelta, columnDelta);
  }

  void _cancelEdit() {
    _debounceTimer?.cancel();
    setState(() {
      _controller.text = _formatScore(_lastSaved);
      _controller.selection = TextSelection.collapsed(
        offset: _controller.text.length,
      );
      _isDirty = false;
      _hasInvalidInput = false;
      _saveFailed = false;
      _justSaved = false;
      _isEditing = false;
    });
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    final key = event.logicalKey;
    if (key == LogicalKeyboardKey.enter ||
        key == LogicalKeyboardKey.numpadEnter) {
      unawaited(_commitAndNavigate(1, 0));
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.escape) {
      _cancelEdit();
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.tab) {
      unawaited(
        _commitAndNavigate(
          0,
          HardwareKeyboard.instance.isShiftPressed ? -1 : 1,
        ),
      );
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.arrowUp) {
      unawaited(_commitAndNavigate(-1, 0));
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.arrowDown) {
      unawaited(_commitAndNavigate(1, 0));
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.arrowLeft ||
        key == LogicalKeyboardKey.arrowRight) {
      final selection = _controller.selection;
      final isLeft = key == LogicalKeyboardKey.arrowLeft;
      final canMoveCursor =
          _isEditing &&
          selection.isValid &&
          (!selection.isCollapsed ||
              (isLeft
                  ? selection.extentOffset > 0
                  : selection.extentOffset < _controller.text.length));
      if (canMoveCursor) return KeyEventResult.ignored;
      unawaited(_commitAndNavigate(0, isLeft ? -1 : 1));
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      canRequestFocus: false,
      onKeyEvent: _handleKeyEvent,
      child: TextField(
        focusNode: widget.focusNode,
        controller: _controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        textInputAction: TextInputAction.done,
        textAlign: TextAlign.center,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
        ],
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: AppColors.paleGreen,
          hintText: 'Missing',
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 10,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppColors.border),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppColors.border),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppColors.primary, width: 1.5),
          ),
          suffixIconConstraints: const BoxConstraints(
            minWidth: 22,
            minHeight: 22,
          ),
          suffixIcon: _savingCount > 0
              ? const Padding(
                  padding: EdgeInsets.all(4),
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : _hasInvalidInput || _saveFailed
              ? Tooltip(
                  message: _hasInvalidInput
                      ? 'Enter a score from 0 to ${widget.maximum}.'
                      : 'This value could not be saved.',
                  child: const Icon(
                    Icons.error_outline,
                    size: 16,
                    color: AppColors.red,
                  ),
                )
              : _justSaved
              ? const Tooltip(
                  message: 'Saved',
                  child: Icon(
                    Icons.check_circle_outline,
                    size: 16,
                    color: AppColors.primary,
                  ),
                )
              : null,
        ),
        onTap: () => setState(() => _isEditing = true),
        onChanged: _handleChange,
        onEditingComplete: () {},
      ),
    );
  }
}

class _AttendanceCodeInput extends StatefulWidget {
  const _AttendanceCodeInput({
    required this.initialCode,
    required this.focusNode,
    required this.onNavigate,
    required this.onSave,
    required this.onSaveError,
    super.key,
  });

  final String? initialCode;
  final FocusNode focusNode;
  final Future<void> Function(int rowDelta, int columnDelta) onNavigate;
  final Future<void> Function(String code) onSave;
  final void Function(Object error) onSaveError;

  @override
  State<_AttendanceCodeInput> createState() => _AttendanceCodeInputState();
}

class _AttendanceCodeInputState extends State<_AttendanceCodeInput> {
  String? _value;
  bool _saving = false;
  bool _justSaved = false;
  Timer? _savedIndicatorTimer;
  late Future<bool> _pendingSave;
  String? _lastSaved;

  @override
  void initState() {
    super.initState();
    _value = widget.initialCode;
    _lastSaved = widget.initialCode;
    _pendingSave = Future<bool>.value(true);
  }

  @override
  void didUpdateWidget(covariant _AttendanceCodeInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialCode != oldWidget.initialCode && !_saving) {
      _value = widget.initialCode;
      _lastSaved = widget.initialCode;
    }
  }

  @override
  void dispose() {
    _savedIndicatorTimer?.cancel();
    super.dispose();
  }

  Future<bool> _save(String? code) async {
    if (code == null || code == _value) return true;
    final previousValue = _value;
    setState(() {
      _value = code;
      _saving = true;
      _justSaved = false;
    });
    _savedIndicatorTimer?.cancel();
    try {
      await widget.onSave(code);
      _lastSaved = code;
      if (mounted) {
        setState(() => _justSaved = true);
        _savedIndicatorTimer = Timer(const Duration(seconds: 1), () {
          if (mounted) setState(() => _justSaved = false);
        });
      }
      return true;
    } catch (error) {
      if (mounted) {
        setState(() {
          _value = previousValue;
          _justSaved = false;
        });
      }
      widget.onSaveError(error);
      return false;
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _commitAndNavigate(int rowDelta, int columnDelta) async {
    if (!await _pendingSave) return;
    await widget.onNavigate(rowDelta, columnDelta);
  }

  void _cancelEdit() {
    setState(() {
      _value = _lastSaved;
      _justSaved = false;
    });
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    final key = event.logicalKey;
    if (key == LogicalKeyboardKey.enter ||
        key == LogicalKeyboardKey.numpadEnter) {
      unawaited(_commitAndNavigate(1, 0));
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.escape) {
      _cancelEdit();
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.tab) {
      unawaited(
        _commitAndNavigate(
          0,
          HardwareKeyboard.instance.isShiftPressed ? -1 : 1,
        ),
      );
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.arrowUp) {
      unawaited(_commitAndNavigate(-1, 0));
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.arrowDown) {
      unawaited(_commitAndNavigate(1, 0));
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.arrowLeft) {
      unawaited(_commitAndNavigate(0, -1));
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.arrowRight) {
      unawaited(_commitAndNavigate(0, 1));
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      canRequestFocus: false,
      onKeyEvent: _handleKeyEvent,
      child: DropdownButtonFormField<String>(
        key: ValueKey(_value),
        focusNode: widget.focusNode,
        initialValue: _value,
        isExpanded: true,
        isDense: true,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: AppColors.paleGreen,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 8,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppColors.border),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppColors.border),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppColors.primary, width: 1.5),
          ),
          suffixIcon: _saving
              ? const Padding(
                  padding: EdgeInsets.all(8),
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : _justSaved
              ? const Tooltip(
                  message: 'Saved',
                  child: Icon(
                    Icons.check_circle_outline,
                    size: 16,
                    color: AppColors.primary,
                  ),
                )
              : null,
        ),
        items: const [
          DropdownMenuItem(value: 'P', child: Text('P')),
          DropdownMenuItem(value: 'L', child: Text('L')),
          DropdownMenuItem(value: 'A', child: Text('A')),
          DropdownMenuItem(value: 'E', child: Text('E')),
        ],
        onChanged: _saving
            ? null
            : (code) {
                _pendingSave = _save(code);
              },
      ),
    );
  }
}

enum _AssessmentHeaderAction { edit, delete }

const _assessmentTypes = [
  'Quiz',
  'Assignment',
  'Seatwork',
  'Activity',
  'Project',
  'Major Exam',
];

String _formatAssessmentDate(DateTime date) =>
    '${date.year.toString().padLeft(4, '0')}-'
    '${date.month.toString().padLeft(2, '0')}-'
    '${date.day.toString().padLeft(2, '0')}';

Future<void> _pickAssessmentDate(
  BuildContext context,
  TextEditingController controller,
) async {
  final initialDate = DateTime.tryParse(controller.text) ?? DateTime.now();
  final selectedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
  );
  if (selectedDate != null) {
    controller.text = _formatAssessmentDate(selectedDate);
  }
}

void _showGradeSheetMessage(
  BuildContext context,
  String message, {
  bool isError = false,
}) {
  if (!context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isError ? AppColors.red : null,
    ),
  );
}

Future<void> addAssessment(
  BuildContext context,
  WidgetRef ref,
  GradeSheetQuery query, {
  required Future<void> Function() onSaved,
}) async {
  final name = TextEditingController();
  final max = TextEditingController(text: '100');
  final date = TextEditingController();
  var type = 'Quiz';
  try {
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
                  items: [
                    for (final item in _assessmentTypes)
                      DropdownMenuItem(value: item, child: Text(item)),
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
                const SizedBox(height: 12),
                TextField(
                  controller: date,
                  readOnly: true,
                  onTap: () => _pickAssessmentDate(dialogContext, date),
                  decoration: const InputDecoration(
                    labelText: 'Assessment Date (optional)',
                    suffixIcon: Icon(Icons.calendar_today_outlined),
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
    if (saved != true || !context.mounted) return;

    final maximum = double.tryParse(max.text.trim());
    if (name.text.trim().isEmpty ||
        maximum == null ||
        !maximum.isFinite ||
        maximum <= 0) {
      _showGradeSheetMessage(
        context,
        'Enter an assessment name and a total score greater than zero.',
        isError: true,
      );
      return;
    }

    final database = await ref.read(appDatabaseProvider.future);
    await database.createAssessment(
      subjectId: query.subjectId,
      gradingPeriodId: query.gradingPeriodId,
      name: name.text.trim(),
      type: type,
      date: date.text.isEmpty ? null : date.text,
      totalPossibleScore: maximum,
    );
    if (!context.mounted) return;
    ref.invalidate(gradeSheetAssessmentsProvider(query));
    await onSaved();
    if (!context.mounted) return;
    _showGradeSheetMessage(context, 'Assessment added.');
  } catch (error) {
    if (!context.mounted) return;
    _showGradeSheetMessage(
      context,
      'Unable to add assessment: $error',
      isError: true,
    );
  } finally {
    name.dispose();
    max.dispose();
    date.dispose();
  }
}

Future<void> editAssessment(
  BuildContext context,
  WidgetRef ref,
  GradeSheetQuery query,
  Assessment assessment, {
  required Future<void> Function() onSaved,
}) async {
  final name = TextEditingController(text: assessment.name);
  final max = TextEditingController(
    text: assessment.totalPossibleScore.toString(),
  );
  final date = TextEditingController(text: assessment.date ?? '');
  var type = assessment.type;
  final types = {..._assessmentTypes, assessment.type}.toList();

  try {
    final saved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setState) => AlertDialog(
          title: const Text('Edit Assessment'),
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
                  items: [
                    for (final item in types)
                      DropdownMenuItem(value: item, child: Text(item)),
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
                const SizedBox(height: 12),
                TextField(
                  controller: date,
                  readOnly: true,
                  onTap: () => _pickAssessmentDate(dialogContext, date),
                  decoration: const InputDecoration(
                    labelText: 'Assessment Date (optional)',
                    suffixIcon: Icon(Icons.calendar_today_outlined),
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
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
    if (saved != true || !context.mounted) return;

    final maximum = double.tryParse(max.text.trim());
    if (name.text.trim().isEmpty ||
        maximum == null ||
        !maximum.isFinite ||
        maximum <= 0) {
      _showGradeSheetMessage(
        context,
        'Enter an assessment name and a total score greater than zero.',
        isError: true,
      );
      return;
    }

    final database = await ref.read(appDatabaseProvider.future);
    final scores = await database.getAssessmentScores(assessment.id);
    if (!context.mounted) return;
    final overLimitCount = scores
        .where((score) => score.score != null && score.score! > maximum)
        .length;
    if (overLimitCount > 0) {
      _showGradeSheetMessage(
        context,
        'Correct the $overLimitCount student score(s) above $maximum before lowering the maximum.',
        isError: true,
      );
      return;
    }

    final updated = await database.updateAssessment(
      id: assessment.id,
      name: name.text.trim(),
      type: type,
      date: date.text.isEmpty ? null : date.text,
      totalPossibleScore: maximum,
    );
    if (!updated) {
      throw StateError('The assessment no longer exists.');
    }
    if (!context.mounted) return;
    ref.invalidate(gradeSheetAssessmentsProvider(query));
    ref.invalidate(gradeSheetScoresProvider(query));
    await onSaved();
    if (!context.mounted) return;
    _showGradeSheetMessage(context, 'Assessment updated.');
  } catch (error) {
    if (!context.mounted) return;
    _showGradeSheetMessage(
      context,
      'Unable to update assessment: $error',
      isError: true,
    );
  } finally {
    name.dispose();
    max.dispose();
    date.dispose();
  }
}

Future<void> deleteAssessment(
  BuildContext context,
  WidgetRef ref,
  GradeSheetQuery query,
  Assessment assessment, {
  required Future<void> Function() onSaved,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Delete Assessment?'),
      content: Text(
        'Delete "${assessment.name}" and all student scores recorded for it?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(dialogContext, true),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.red,
            foregroundColor: AppColors.white,
          ),
          child: const Text('Delete'),
        ),
      ],
    ),
  );
  if (confirmed != true || !context.mounted) return;

  try {
    final database = await ref.read(appDatabaseProvider.future);
    final deleted = await database.deleteAssessment(assessment.id);
    if (deleted != 1) {
      throw StateError('The assessment no longer exists.');
    }
    if (!context.mounted) return;
    ref.invalidate(gradeSheetAssessmentsProvider(query));
    ref.invalidate(gradeSheetScoresProvider(query));
    await onSaved();
    if (!context.mounted) return;
    _showGradeSheetMessage(context, 'Assessment deleted.');
  } catch (error) {
    if (!context.mounted) return;
    _showGradeSheetMessage(
      context,
      'Unable to delete assessment: $error',
      isError: true,
    );
  }
}

Future<void> addAttendance(
  BuildContext context,
  WidgetRef ref,
  GradeSheetQuery query, {
  required Future<void> Function() onSaved,
}) async {
  final date = TextEditingController(
    text: DateTime.now().toIso8601String().substring(0, 10),
  );
  try {
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
    if (saved != true || !context.mounted) return;
    final sessionDate = date.text.trim();
    if (DateTime.tryParse(sessionDate) == null) {
      _showGradeSheetMessage(
        context,
        'Enter a valid attendance date in YYYY-MM-DD format.',
        isError: true,
      );
      return;
    }

    final database = await ref.read(appDatabaseProvider.future);
    await database.createAttendanceSession(
      subjectId: query.subjectId,
      gradingPeriodId: query.gradingPeriodId,
      sessionDate: sessionDate,
    );
    if (!context.mounted) return;
    ref.invalidate(gradeSheetAttendanceProvider(query));
    await onSaved();
    if (!context.mounted) return;
    _showGradeSheetMessage(context, 'Attendance session added.');
  } catch (error) {
    if (!context.mounted) return;
    _showGradeSheetMessage(
      context,
      'Unable to add attendance session: $error',
      isError: true,
    );
  } finally {
    date.dispose();
  }
}

Future<void> addIndependent(
  BuildContext context,
  WidgetRef ref,
  GradeSheetQuery query, {
  required Future<void> Function() onSaved,
}) async {
  final name = TextEditingController();
  final description = TextEditingController();
  final max = TextEditingController(text: '100');
  try {
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
    if (saved != true || !context.mounted) return;
    final maximum = double.tryParse(max.text.trim());
    if (name.text.trim().isEmpty ||
        maximum == null ||
        !maximum.isFinite ||
        maximum <= 0) {
      _showGradeSheetMessage(
        context,
        'Enter an activity name and a total score greater than zero.',
        isError: true,
      );
      return;
    }

    final database = await ref.read(appDatabaseProvider.future);
    await database.createIndependentLearningRecord(
      subjectId: query.subjectId,
      gradingPeriodId: query.gradingPeriodId,
      activityName: name.text.trim(),
      description: description.text.trim(),
      totalPossibleScore: maximum,
    );
    if (!context.mounted) return;
    ref.invalidate(gradeSheetIndependentProvider(query));
    await onSaved();
    if (!context.mounted) return;
    _showGradeSheetMessage(context, 'Independent learning activity added.');
  } catch (error) {
    if (!context.mounted) return;
    _showGradeSheetMessage(
      context,
      'Unable to add independent learning activity: $error',
      isError: true,
    );
  } finally {
    name.dispose();
    description.dispose();
    max.dispose();
  }
}

Future<void> configureWeights(
  BuildContext context,
  WidgetRef ref,
  GradeSheetQuery query, {
  required Future<void> Function() onSaved,
}) async {
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
      await onSaved();
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

Future<void> configureAttendance(
  BuildContext context,
  WidgetRef ref, {
  required Future<void> Function() onSaved,
}) async {
  final database = await ref.read(appDatabaseProvider.future);
  final values = AttendanceValues.decode(
    await database.getApplicationSetting('attendance_scoring'),
  );
  if (!context.mounted) return;

  final present = TextEditingController(text: values.present?.toString() ?? '');
  final late = TextEditingController(text: values.late?.toString() ?? '');
  final absent = TextEditingController(text: values.absent?.toString() ?? '');
  final excused = TextEditingController(text: values.excused?.toString() ?? '');
  final saved = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Attendance Scoring Values'),
      content: SizedBox(
        width: 420,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Set each attendance code value from 0 to 100. '
              'These values are not assumed by the application.',
            ),
            const SizedBox(height: 12),
            for (final item in [
              ('P - Present', present),
              ('L - Late', late),
              ('A - Absent', absent),
              ('E - Excused', excused),
            ]) ...[
              TextField(
                controller: item.$2,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(labelText: item.$1),
              ),
              const SizedBox(height: 8),
            ],
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
  final updatedValues = AttendanceValues(
    present: double.tryParse(present.text.trim()),
    late: double.tryParse(late.text.trim()),
    absent: double.tryParse(absent.text.trim()),
    excused: double.tryParse(excused.text.trim()),
  );
  if (saved == true && updatedValues.isConfigured) {
    await database.saveApplicationSetting(
      'attendance_scoring',
      updatedValues.encode(),
    );
    await onSaved();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Attendance scoring values saved.')),
      );
    }
  } else if (saved == true && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Enter a valid value from 0 to 100 for each code.'),
      ),
    );
  }
  present.dispose();
  late.dispose();
  absent.dispose();
  excused.dispose();
}

Future<void> computeGrades(
  BuildContext context,
  WidgetRef ref,
  GradeSheetQuery query,
) async {
  try {
    final database = await ref.read(appDatabaseProvider.future);
    final result = await const TermGradeCalculationService().computeAndSave(
      database: database,
      subjectId: query.subjectId,
      gradingPeriodId: query.gradingPeriodId,
    );
    if (!context.mounted) return;
    ref.invalidate(gradeSheetScoresProvider(query));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Grades computed: ${result.completedGrades} complete, '
          '${result.incompleteGrades} incomplete.',
        ),
      ),
    );
  } catch (error) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Unable to compute grades: $error'),
        backgroundColor: AppColors.red,
      ),
    );
  }
}
