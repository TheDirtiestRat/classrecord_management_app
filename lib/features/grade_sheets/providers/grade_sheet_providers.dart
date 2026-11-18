import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

final gradingPeriodsProvider = FutureProvider.autoDispose<List<GradingPeriod>>((
  ref,
) async {
  final database = await ref.watch(appDatabaseProvider.future);
  return database.getGradingPeriods();
});

final gradeSheetAssessmentsProvider = FutureProvider.autoDispose
    .family<List<Assessment>, GradeSheetQuery>((ref, query) async {
      final database = await ref.watch(appDatabaseProvider.future);
      return database.getAssessments(
        subjectId: query.subjectId,
        gradingPeriodId: query.gradingPeriodId,
      );
    });

final gradeSheetAttendanceProvider = FutureProvider.autoDispose
    .family<List<AttendanceSession>, GradeSheetQuery>((ref, query) async {
      final database = await ref.watch(appDatabaseProvider.future);
      return database.getAttendanceSessions(
        subjectId: query.subjectId,
        gradingPeriodId: query.gradingPeriodId,
      );
    });

final gradeSheetIndependentProvider = FutureProvider.autoDispose
    .family<List<IndependentLearningRecord>, GradeSheetQuery>((
      ref,
      query,
    ) async {
      final database = await ref.watch(appDatabaseProvider.future);
      return database.getIndependentLearningRecords(
        subjectId: query.subjectId,
        gradingPeriodId: query.gradingPeriodId,
      );
    });

final gradeSheetScoresProvider = FutureProvider.autoDispose
    .family<GradeSheetScores, GradeSheetQuery>((ref, query) async {
      final databaseFuture = ref.watch(appDatabaseProvider.future);
      final assessmentsFuture = ref.watch(
        gradeSheetAssessmentsProvider(query).future,
      );
      final attendanceFuture = ref.watch(
        gradeSheetAttendanceProvider(query).future,
      );
      final independentFuture = ref.watch(
        gradeSheetIndependentProvider(query).future,
      );
      final database = await databaseFuture;
      final assessments = await assessmentsFuture;
      final attendance = await attendanceFuture;
      final independent = await independentFuture;
      final assessmentScoresFuture = database.getAssessmentScoresForAssessments(
        assessments.map((assessment) => assessment.id),
      );
      final attendanceScoresFuture = database.getStudentAttendanceForSessions(
        attendance.map((session) => session.id),
      );
      final independentScoresFuture = database
          .getIndependentLearningScoresForRecords(
            independent.map((record) => record.id),
          );
      final termGradesFuture = database.getTermGrades(
        subjectId: query.subjectId,
        gradingPeriodId: query.gradingPeriodId,
      );
      final assessmentScores = await assessmentScoresFuture;
      final attendanceScores = await attendanceScoresFuture;
      final independentScores = await independentScoresFuture;
      final termGrades = await termGradesFuture;

      return GradeSheetScores(
        assessmentScores: {
          for (final score in assessmentScores)
            (score.assessmentId, score.studentId): score.score,
        },
        attendanceCodes: {
          for (final record in attendanceScores)
            (record.attendanceSessionId, record.studentId): record.code,
        },
        independentLearningScores: {
          for (final score in independentScores)
            (score.recordId, score.studentId): score.score,
        },
        termGrades: {for (final grade in termGrades) grade.studentId: grade},
      );
    });

class GradeSheetScores {
  const GradeSheetScores({
    required this.assessmentScores,
    required this.attendanceCodes,
    required this.independentLearningScores,
    required this.termGrades,
  });

  final Map<(int, int), double?> assessmentScores;
  final Map<(int, int), String> attendanceCodes;
  final Map<(int, int), double?> independentLearningScores;
  final Map<int, TermGrade> termGrades;
}

class GradeSheetQuery {
  const GradeSheetQuery({
    required this.subjectId,
    required this.gradingPeriodId,
  });

  final int subjectId;
  final int gradingPeriodId;

  @override
  bool operator ==(Object other) =>
      other is GradeSheetQuery &&
      other.subjectId == subjectId &&
      other.gradingPeriodId == gradingPeriodId;

  @override
  int get hashCode => Object.hash(subjectId, gradingPeriodId);
}
