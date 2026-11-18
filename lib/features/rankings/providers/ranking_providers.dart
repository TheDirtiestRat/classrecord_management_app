import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

final rankingPageProvider = FutureProvider.autoDispose
    .family<DatabasePage<(GradeRanking, Student)>, RankingPageQuery>((
      ref,
      query,
    ) async {
      final database = await ref.watch(appDatabaseProvider.future);
      return database.getRankingsPage(
        subjectId: query.subjectId,
        gradingPeriodId: query.gradingPeriodId,
        limit: query.rowsPerPage,
        offset: query.pageIndex * query.rowsPerPage,
      );
    });

class RankingPageQuery {
  const RankingPageQuery({
    required this.subjectId,
    required this.gradingPeriodId,
    required this.pageIndex,
    required this.rowsPerPage,
  });

  final int subjectId;
  final int gradingPeriodId;
  final int pageIndex;
  final int rowsPerPage;

  @override
  bool operator ==(Object other) =>
      other is RankingPageQuery &&
      other.subjectId == subjectId &&
      other.gradingPeriodId == gradingPeriodId &&
      other.pageIndex == pageIndex &&
      other.rowsPerPage == rowsPerPage;

  @override
  int get hashCode =>
      Object.hash(subjectId, gradingPeriodId, pageIndex, rowsPerPage);
}
