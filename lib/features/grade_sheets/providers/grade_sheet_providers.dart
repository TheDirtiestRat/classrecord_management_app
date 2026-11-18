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
