import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../app/theme/app_colors.dart';
import '../providers/dashboard_providers.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(dashboardDataProvider);
    return dashboardAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: AppColors.red, size: 36),
              const SizedBox(height: 12),
              Text(
                'Unable to load dashboard data: $error',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.red),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => ref.invalidate(dashboardDataProvider),
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      data: (data) => _DashboardContent(
        data: data,
        onRefresh: () => ref.refresh(dashboardDataProvider.future).then((_) {}),
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent({required this.data, required this.onRefresh});

  final DashboardData data;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
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
                  children: [
                    _SummaryCard(
                      title: 'Total Subjects',
                      value: '${data.subjects.length}',
                      icon: Icons.menu_book_outlined,
                    ),
                    _SummaryCard(
                      title: 'Total Students',
                      value: '${data.totalStudents}',
                      icon: Icons.people_outlined,
                    ),
                    _SummaryCard(
                      title: 'Enrolled',
                      value: '${data.totalEnrollments}',
                      icon: Icons.person_add_outlined,
                    ),
                    _SummaryCard(
                      title: 'Assessments',
                      value: '${data.totalAssessments}',
                      icon: Icons.assignment_outlined,
                    ),
                    _SummaryCard(
                      title: 'Pending Grades',
                      value: '${data.pendingGradeSheets}',
                      icon: Icons.pending_actions_outlined,
                      warning: true,
                    ),
                    _SummaryCard(
                      title: 'Completed Sheets',
                      value: '${data.completedGradeSheets}',
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
                final subjectOverview = _SectionCard(
                  title: 'Subject Overview',
                  actionLabel: 'View all',
                  destination: '/subjects',
                  child: _SubjectOverview(data: data),
                );
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
                    const _QuickActions(),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                final recent = _SectionCard(
                  title: 'Recent Activities',
                  child: _RecentActivities(data: data),
                );
                final summary = _SectionCard(
                  title: 'Academic Summary',
                  child: _AcademicSummary(data: data),
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
                return Column(
                  children: [recent, const SizedBox(height: 16), summary],
                );
              },
            ),
          ],
        ),
      ),
    );
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

class _SubjectOverview extends StatelessWidget {
  const _SubjectOverview({required this.data});

  final DashboardData data;

  @override
  Widget build(BuildContext context) {
    if (data.subjects.isEmpty) {
      return const _EmptyTable(
        message: 'No subjects have been created',
        icon: Icons.menu_book_outlined,
      );
    }

    final subjects = data.subjects.take(5);
    return Column(
      children: [
        for (final (index, subject) in subjects.indexed) ...[
          if (index > 0) const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.menu_book_outlined,
                    color: AppColors.primaryDark,
                    size: 19,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subject.name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.text,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        subject.code,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${data.enrolledStudentsBySubject[subject.id] ?? 0} students',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 12),
                _StatusBadge(status: subject.status),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final active = status.toLowerCase() == 'active';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: active ? AppColors.primaryLight : AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: active ? AppColors.primaryDark : AppColors.textSecondary,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _RecentActivities extends StatelessWidget {
  const _RecentActivities({required this.data});

  final DashboardData data;

  @override
  Widget build(BuildContext context) {
    if (data.recentActivity.isEmpty) {
      return const _EmptyTable(
        message: 'No recent activity',
        icon: Icons.history,
      );
    }
    return Column(
      children: [
        for (final (index, activity) in data.recentActivity.indexed) ...[
          if (index > 0) const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                const Icon(Icons.history, size: 18, color: AppColors.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity.activity,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.text,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (activity.details.isNotEmpty)
                        Text(
                          activity.details,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  _activityDate(activity.createdAt),
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  String _activityDate(String value) {
    final date = DateTime.tryParse(value);
    return date == null ? value : DateFormat('MMM d, h:mm a').format(date);
  }
}

class _AcademicSummary extends StatelessWidget {
  const _AcademicSummary({required this.data});

  final DashboardData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SummaryLine(
          label: 'Active academic year',
          value: data.activeAcademicYear?.name ?? 'Not set',
        ),
        const Divider(height: 1),
        _SummaryLine(
          label: 'Active semester',
          value: data.activeSemester?.name ?? 'Not set',
        ),
        const Divider(height: 1),
        _SummaryLine(label: 'Active subjects', value: '${data.activeSubjects}'),
        const Divider(height: 1),
        _SummaryLine(
          label: 'Student enrollments',
          value: '${data.totalEnrollments}',
        ),
        const Divider(height: 1),
        _SummaryLine(
          label: 'Assessments created',
          value: '${data.totalAssessments}',
        ),
      ],
    );
  }
}

class _SummaryLine extends StatelessWidget {
  const _SummaryLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.text,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
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
