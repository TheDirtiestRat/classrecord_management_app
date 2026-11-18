import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../../shared/widgets/app_data_table.dart';
import '../../academic_management/providers/academic_management_providers.dart';
import '../../grade_sheets/providers/grade_sheet_providers.dart';
import '../providers/ranking_providers.dart';

class RankingsPage extends ConsumerStatefulWidget {
  const RankingsPage({super.key});

  @override
  ConsumerState<RankingsPage> createState() => _RankingsPageState();
}

class _RankingsPageState extends ConsumerState<RankingsPage> {
  int? _subjectId;
  int? _periodId;
  int _pageIndex = 0;
  int _rowsPerPage = 10;

  @override
  Widget build(BuildContext context) {
    final subjectsAsync = ref.watch(subjectsProvider);
    final periodsAsync = ref.watch(gradingPeriodsProvider);

    return Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rankings',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 18),
          Expanded(
            child: subjectsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) =>
                  Center(child: Text('Unable to load subjects: $error')),
              data: (subjects) => periodsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Text('Unable to load grading periods: $error'),
                ),
                data: (periods) {
                  if (subjects.isEmpty) {
                    return const _RankingEmptyState(
                      message: 'Create a subject to view rankings.',
                    );
                  }
                  if (periods.isEmpty) {
                    return const _RankingEmptyState(
                      message: 'No grading periods are available.',
                    );
                  }

                  final selectedSubjects = subjects
                      .where((subject) => subject.id == _subjectId)
                      .toList();
                  final subjectId = selectedSubjects.isEmpty
                      ? subjects.first.id
                      : selectedSubjects.first.id;
                  final selectedPeriods = periods
                      .where((period) => period.id == _periodId)
                      .toList();
                  final periodId = selectedPeriods.isEmpty
                      ? periods.first.id
                      : selectedPeriods.first.id;
                  final query = RankingPageQuery(
                    subjectId: subjectId,
                    gradingPeriodId: periodId,
                    pageIndex: _pageIndex,
                    rowsPerPage: _rowsPerPage,
                  );
                  final rankingsAsync = ref.watch(rankingPageProvider(query));

                  return Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final narrow = constraints.maxWidth < 680;
                              final subjectDropdown =
                                  DropdownButtonFormField<int>(
                                    key: ValueKey(subjectId),
                                    initialValue: subjectId,
                                    isExpanded: true,
                                    decoration: const InputDecoration(
                                      labelText: 'Subject',
                                    ),
                                    items: subjects
                                        .map(
                                          (subject) => DropdownMenuItem(
                                            value: subject.id,
                                            child: Text(
                                              '${subject.code} — ${subject.name}',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      if (value == null) return;
                                      setState(() {
                                        _subjectId = value;
                                        _periodId = null;
                                        _pageIndex = 0;
                                      });
                                    },
                                  );
                              final periodDropdown =
                                  DropdownButtonFormField<int>(
                                    key: ValueKey(periodId),
                                    initialValue: periodId,
                                    isExpanded: true,
                                    decoration: const InputDecoration(
                                      labelText: 'Grading Period',
                                    ),
                                    items: periods
                                        .map(
                                          (period) => DropdownMenuItem(
                                            value: period.id,
                                            child: Text(period.name),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      if (value == null) return;
                                      setState(() {
                                        _periodId = value;
                                        _pageIndex = 0;
                                      });
                                    },
                                  );
                              if (narrow) {
                                return Column(
                                  children: [
                                    subjectDropdown,
                                    const SizedBox(height: 12),
                                    periodDropdown,
                                  ],
                                );
                              }
                              return Row(
                                children: [
                                  SizedBox(width: 320, child: subjectDropdown),
                                  const SizedBox(width: 12),
                                  Expanded(child: periodDropdown),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 12),
                          Expanded(
                            child: rankingsAsync.when(
                              loading: () => AppDataTable(
                                columns: const [
                                  DataColumn(label: Text('Rank')),
                                  DataColumn(label: Text('Student')),
                                  DataColumn(label: Text('Grade')),
                                ],
                                rows: const [],
                                totalRecords: 0,
                                pageIndex: _pageIndex,
                                rowsPerPage: _rowsPerPage,
                                onPageChanged: (_) {},
                                onRowsPerPageChanged: (_) {},
                                isLoading: true,
                              ),
                              error: (error, stack) => Center(
                                child: Text('Unable to load rankings: $error'),
                              ),
                              data: (page) => AppDataTable(
                                columns: const [
                                  DataColumn(label: Text('Rank')),
                                  DataColumn(label: Text('Student')),
                                  DataColumn(label: Text('Grade')),
                                ],
                                rows: page.records.map((entry) {
                                  final ranking = entry.$1;
                                  final student = entry.$2;
                                  final name =
                                      '${student.lastName}, ${student.firstName}';
                                  return DataRow(
                                    cells: [
                                      DataCell(Text('${ranking.rank}')),
                                      DataCell(
                                        SizedBox(
                                          width: 280,
                                          child: Text(
                                            name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Text(ranking.grade.toStringAsFixed(2)),
                                      ),
                                    ],
                                  );
                                }).toList(),
                                totalRecords: page.totalRecords,
                                pageIndex: _pageIndex,
                                rowsPerPage: _rowsPerPage,
                                onPageChanged: (pageIndex) =>
                                    setState(() => _pageIndex = pageIndex),
                                onRowsPerPageChanged: (rowsPerPage) {
                                  setState(() {
                                    _rowsPerPage = rowsPerPage;
                                    _pageIndex = 0;
                                  });
                                },
                                emptyMessage: 'Compute grades in Grade Sheets to create rankings.',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RankingEmptyState extends StatelessWidget {
  const _RankingEmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: AppColors.textSecondary),
      ),
    );
  }
}
