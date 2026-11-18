import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Good morning',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
          const SizedBox(height: 4),
          const Text(
            'Academic Overview',
            style: TextStyle(
              color: AppColors.text,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth < 900
                  ? 2
                  : constraints.maxWidth < 1250
                  ? 3
                  : 6;
              return GridView.count(
                crossAxisCount: columns,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: columns == 6 ? 1.32 : 1.7,
                children: const [
                  _SummaryCard(
                    title: 'Total Subjects',
                    value: '0',
                    icon: Icons.menu_book_outlined,
                  ),
                  _SummaryCard(
                    title: 'Total Students',
                    value: '0',
                    icon: Icons.people_outlined,
                  ),
                  _SummaryCard(
                    title: 'Enrolled',
                    value: '0',
                    icon: Icons.person_add_outlined,
                  ),
                  _SummaryCard(
                    title: 'Assessments',
                    value: '0',
                    icon: Icons.assignment_outlined,
                  ),
                  _SummaryCard(
                    title: 'Pending Grades',
                    value: '0',
                    icon: Icons.pending_actions_outlined,
                    warning: true,
                  ),
                  _SummaryCard(
                    title: 'Completed Sheets',
                    value: '0',
                    icon: Icons.task_alt_outlined,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 1050;
              final subjectOverview = const _SectionCard(
                title: 'Subject Overview',
                actionLabel: 'View all',
                destination: '/subjects',
                child: _EmptyTable(
                  message: 'No subjects have been created',
                  icon: Icons.menu_book_outlined,
                ),
              );
              final quickActions = const _QuickActions();

              if (wide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: subjectOverview),
                    const SizedBox(width: 16),
                    const Expanded(flex: 2, child: _QuickActions()),
                  ],
                );
              }
              return Column(
                children: [
                  subjectOverview,
                  const SizedBox(height: 16),
                  quickActions,
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          const LayoutBuilder(builder: _lowerSections),
        ],
      ),
    );
  }

  static Widget _lowerSections(
    BuildContext context,
    BoxConstraints constraints,
  ) {
    final recent = const _SectionCard(
      title: 'Recent Activities',
      child: _EmptyTable(message: 'No recent activity', icon: Icons.history),
    );
    final summary = const _SectionCard(
      title: 'Academic Summary',
      child: _EmptyTable(
        message: 'Academic data will appear here',
        icon: Icons.insights_outlined,
      ),
    );

    if (constraints.maxWidth >= 1050) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: recent),
          const SizedBox(width: 16),
          Expanded(child: summary),
        ],
      );
    }
    return Column(children: [recent, const SizedBox(height: 16), summary]);
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    this.warning = false,
  });

  final String title;
  final String value;
  final IconData icon;
  final bool warning;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  icon,
                  size: 18,
                  color: warning ? AppColors.orange : AppColors.primary,
                ),
              ],
            ),
            Text(
              value,
              style: const TextStyle(
                color: AppColors.text,
                fontSize: 26,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.child,
    this.actionLabel,
    this.destination,
  });

  final String title;
  final Widget child;
  final String? actionLabel;
  final String? destination;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.text,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (actionLabel != null)
                  TextButton(
                    onPressed: () => context.go(destination!),
                    child: Text(actionLabel!),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _EmptyTable extends StatelessWidget {
  const _EmptyTable({required this.message, required this.icon});

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 34, color: AppColors.textSecondary),
          const SizedBox(height: 10),
          Text(message, style: const TextStyle(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    const actions = [
      ('Add Subject', Icons.add_circle_outline, '/subjects'),
      ('Add Student', Icons.person_add_alt_1_outlined, '/students'),
      ('Create Grade Sheet', Icons.grid_on_outlined, '/grade-sheets'),
      ('Record Attendance', Icons.fact_check_outlined, '/attendance'),
      ('Generate Report', Icons.description_outlined, '/reports'),
    ];

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(
                color: AppColors.text,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            ...actions.map(
              (action) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => context.go(action.$3),
                    icon: Icon(action.$2, size: 18),
                    label: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(action.$1),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
