import '../database/app_database.dart';
import 'grade_computation_service.dart';

class TermGradeCalculationResult {
  const TermGradeCalculationResult({
    required this.enrolledStudents,
    required this.completedGrades,
  });

  final int enrolledStudents;
  final int completedGrades;

  int get incompleteGrades => enrolledStudents - completedGrades;
}

class TermGradeCalculationService {
  const TermGradeCalculationService();

  Future<TermGradeCalculationResult> computeAndSave({
    required AppDatabase database,
    required int subjectId,
    required int gradingPeriodId,
  }) async {
    final students = await database.getEnrolledStudents(subjectId);
    final assessments = await database.getAssessments(
      subjectId: subjectId,
      gradingPeriodId: gradingPeriodId,
    );
    final attendanceSessions = await database.getAttendanceSessions(
      subjectId: subjectId,
      gradingPeriodId: gradingPeriodId,
    );
    final independentRecords = await database.getIndependentLearningRecords(
      subjectId: subjectId,
      gradingPeriodId: gradingPeriodId,
    );
    final config = await database.getActiveGradingConfiguration(subjectId);
    final weights = GradeWeights(
      quizzes: config?.quizWeight ?? 20,
      attendance: config?.attendanceWeight ?? 10,
      work: config?.workWeight ?? 20,
      majorExams: config?.majorExamWeight ?? 40,
      independentLearning: config?.independentLearningWeight ?? 10,
    );
    if (!weights.isValid) {
      throw StateError('Grading weights must be valid and total 100%.');
    }

    final attendanceValues = AttendanceValues.decode(
      await database.getApplicationSetting('attendance_scoring'),
    );
    final scoresByAssessment = <int, Map<int, double?>>{};
    for (final assessment in assessments) {
      scoresByAssessment[assessment.id] = {
        for (final score in await database.getAssessmentScores(assessment.id))
          score.studentId: score.score,
      };
    }
    final attendanceBySession = <int, Map<int, String>>{};
    for (final session in attendanceSessions) {
      attendanceBySession[session.id] = {
        for (final record in await database.getStudentAttendance(session.id))
          record.studentId: record.code,
      };
    }
    final independentByRecord = <int, Map<int, double?>>{};
    for (final record in independentRecords) {
      independentByRecord[record.id] = {
        for (final score in await database.getIndependentLearningScores(
          record.id,
        ))
          score.studentId: score.score,
      };
    }

    const computation = GradeComputationService();
    final rankedEntries = <GradeRankingEntry>[];
    var completedGrades = 0;

    for (final student in students) {
      final quizzes = <GradeComponentInput>[];
      final work = <GradeComponentInput>[];
      final exams = <GradeComponentInput>[];
      var isComplete = true;

      for (final assessment in assessments) {
        final type = assessment.type.toLowerCase();
        final categoryWeight = type.contains('exam')
            ? weights.majorExams
            : type.contains('quiz')
            ? weights.quizzes
            : weights.work;
        final score = scoresByAssessment[assessment.id]?[student.id];
        if (score == null) {
          if (categoryWeight > 0) isComplete = false;
          continue;
        }

        final input = GradeComponentInput(
          earned: score,
          possible: assessment.totalPossibleScore,
        );
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
        final code = attendanceBySession[session.id]?[student.id];
        final score = code == null
            ? double.nan
            : attendanceValues.valueFor(code);
        if (score.isNaN) {
          if (weights.attendance > 0) isComplete = false;
        } else {
          attendance.add(GradeComponentInput(earned: score, possible: 100));
        }
      }

      final independent = <GradeComponentInput>[];
      for (final record in independentRecords) {
        final score = independentByRecord[record.id]?[student.id];
        if (score == null) {
          if (weights.independentLearning > 0) isComplete = false;
        } else {
          independent.add(
            GradeComponentInput(
              earned: score,
              possible: record.totalPossibleScore,
            ),
          );
        }
      }

      final grade = computation.computeTermGrade(
        weights: weights,
        isComplete: isComplete,
        quizzes: quizzes,
        attendance: attendance,
        work: work,
        majorExams: exams,
        independentLearning: independent,
        decimalPlaces: config?.decimalPlaces ?? 2,
      );
      await database.saveTermGrade(
        subjectId: subjectId,
        studentId: student.id,
        gradingPeriodId: gradingPeriodId,
        grade: grade,
      );
      if (grade != null) {
        completedGrades++;
        rankedEntries.add(
          GradeRankingEntry(
            studentId: student.id,
            studentName: '${student.lastName}, ${student.firstName}',
            grade: grade,
          ),
        );
      }
    }

    final rankings = GradeComputationService.rankEntries(rankedEntries);
    await database.replaceRankings(
      subjectId: subjectId,
      gradingPeriodId: gradingPeriodId,
      rankings: rankings
          .map(
            (entry) => (
              studentId: entry.studentId,
              rank: entry.rank!,
              grade: entry.grade,
            ),
          )
          .toList(),
    );

    return TermGradeCalculationResult(
      enrolledStudents: students.length,
      completedGrades: completedGrades,
    );
  }
}
