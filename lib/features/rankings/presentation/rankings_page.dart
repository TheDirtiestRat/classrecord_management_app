import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../academic_management/providers/academic_management_providers.dart';

class RankingsPage extends ConsumerStatefulWidget {
  const RankingsPage({super.key});

  @override
  ConsumerState<RankingsPage> createState() => _RankingsPageState();
}

class _RankingsPageState extends ConsumerState<RankingsPage> {
  int? subjectId;
  int? periodId;
  

  @override
  Widget build(BuildContext context) {
    final subjectsAsync = ref.watch(subjectsProvider);
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
          subjectsAsync.when(
            loading: () => const LinearProgressIndicator(),
            error: (error, stack) => Text('Unable to load subjects: $error'),
            data: (subjects) {
              if (subjects.isEmpty) {
                return const Expanded(
                  child: Center(
                    child: Text(
                      'Create a subject to view rankings',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                );
              }
              if (subjectId == null ||
                  !subjects.any((subject) => subject.id == subjectId)) {
                subjectId = subjects.first.id;
              }
              return Expanded(
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 320,
                              child: DropdownButtonFormField<int>(
                                initialValue: subjectId,
                                decoration: const InputDecoration(
                                  labelText: 'Subject',
                                ),
                                items: subjects
                                    .map(
                                      (subject) => DropdownMenuItem(
                                        value: subject.id,
                                        child: Text(
                                          '${subject.code} - ${subject.name}',
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) =>
                                    setState(() => subjectId = value),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _PeriodSelector(
                                subjectId: subjectId!,
                                onChanged: (value) =>
                                    setState(() => periodId = value),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: _RankingTable(
                            subjectId: subjectId!,
                            periodId: periodId,
                          ),
                        ),
                      ],
                    ),
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

class _PeriodSelector extends ConsumerWidget {
  const _PeriodSelector({required this.subjectId, required this.onChanged});

  final int subjectId;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<AppDatabase>(
      future: ref.read(appDatabaseProvider.future),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();
        return FutureBuilder<List<GradingPeriod>>(
          future: snapshot.data!.getGradingPeriods(),
          builder: (context, periodSnapshot) {
            final periods = periodSnapshot.data ?? [];
            if (periods.isEmpty) return const SizedBox();
            return DropdownButtonFormField<int>(
              initialValue: periods.first.id,
              decoration: const InputDecoration(labelText: 'Grading Period'),
              items: periods
                  .map(
                    (period) => DropdownMenuItem(
                      value: period.id,
                      child: Text(period.name),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
            );
          },
        );
      },
    );
  }
}

class _RankingTable extends ConsumerWidget {
  const _RankingTable({required this.subjectId, required this.periodId});
  final int subjectId;
  final int? periodId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<AppDatabase>(
      future: ref.read(appDatabaseProvider.future),
      builder: (context, databaseSnapshot) {
        if (!databaseSnapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final database = databaseSnapshot.data!;
        return FutureBuilder<List<GradingPeriod>>(
          future: database.getGradingPeriods(),
          builder: (context, periodSnapshot) {
            if (!periodSnapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final periods = periodSnapshot.data!;
            if (periods.isEmpty) return const SizedBox();
            final selectedPeriodId = periodId ?? periods.first.id;
            return FutureBuilder<List<GradeRanking>>(
              future: database.getRankings(
                subjectId: subjectId,
                gradingPeriodId: selectedPeriodId,
              ),
              builder: (context, rankingSnapshot) {
                if (!rankingSnapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final rankings = rankingSnapshot.data!;
                if (rankings.isEmpty) {
                  return const Center(
                    child: Text(
                      'Compute grades in the Grade Sheets module to create rankings.',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  );
                }
                return FutureBuilder<List<Student>>(
                  future: database.getAllStudents(),
                  builder: (context, studentSnapshot) {
                    final students = studentSnapshot.data ?? [];
                    return SingleChildScrollView(
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Rank')),
                          DataColumn(label: Text('Student')),
                          DataColumn(label: Text('Grade')),
                        ],
                        rows: rankings.map((ranking) {
                          Student? student;
                          for (final item in students) {
                            if (item.id == ranking.studentId) {
                              student = item;
                              break;
                            }
                          }
                          final name = student == null
                              ? 'Student ${ranking.studentId}'
                              : '${student.lastName}, ${student.firstName}';
                          return DataRow(
                            cells: [
                              DataCell(Text(ranking.rank.toString())),
                              DataCell(Text(name)),
                              DataCell(Text(ranking.grade.toStringAsFixed(2))),
                            ],
                          );
                        }).toList(),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
