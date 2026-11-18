import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../app/theme/app_colors.dart';

class AppShell extends StatefulWidget {
  const AppShell({required this.child, super.key});

  final Widget child;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  bool _collapsed = false;

  static const _destinations = <_NavDestination>[
    _NavDestination('/dashboard', Icons.dashboard_outlined, 'Dashboard'),
    _NavDestination('/academic', Icons.school_outlined, 'Academic Management'),
    _NavDestination('/subjects', Icons.menu_book_outlined, 'Subjects'),
    _NavDestination('/students', Icons.people_outlined, 'Students'),
    _NavDestination('/grade-sheets', Icons.grid_on_outlined, 'Grade Sheets'),
    _NavDestination('/attendance', Icons.fact_check_outlined, 'Attendance'),
    _NavDestination('/rankings', Icons.leaderboard_outlined, 'Rankings'),
    _NavDestination('/reports', Icons.description_outlined, 'Reports'),
    _NavDestination('/backup', Icons.backup_outlined, 'Backup and Restore'),
    _NavDestination('/settings', Icons.settings_outlined, 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final sidebarWidth = _collapsed ? 76.0 : 252.0;

    return Scaffold(
      body: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: sidebarWidth,
            color: AppColors.white,
            child: Column(
              children: [
                SizedBox(
                  height: 72,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.grade_outlined,
                            color: AppColors.white,
                          ),
                        ),
                        if (!_collapsed) ...[
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'GradeBook',
                              style: TextStyle(
                                color: AppColors.text,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 12,
                    ),
                    children: _destinations.map((destination) {
                      final active =
                          location == destination.path ||
                          location.startsWith('${destination.path}/');
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Tooltip(
                          message: _collapsed ? destination.label : '',
                          child: InkWell(
                            onTap: () => context.go(destination.path),
                            borderRadius: BorderRadius.circular(8),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              height: 44,
                              padding: EdgeInsets.symmetric(
                                horizontal: _collapsed ? 13 : 12,
                              ),
                              decoration: BoxDecoration(
                                color: active
                                    ? AppColors.primaryLight
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: _collapsed
                                    ? MainAxisAlignment.center
                                    : MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    destination.icon,
                                    size: 21,
                                    color: active
                                        ? AppColors.primaryDark
                                        : AppColors.textSecondary,
                                  ),
                                  if (!_collapsed) ...[
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        destination.label,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: active
                                              ? AppColors.primaryDark
                                              : AppColors.text,
                                          fontWeight: active
                                              ? FontWeight.w700
                                              : FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const Divider(height: 1),
                SizedBox(
                  height: 56,
                  child: IconButton(
                    onPressed: () => setState(() => _collapsed = !_collapsed),
                    tooltip: _collapsed ? 'Expand sidebar' : 'Collapse sidebar',
                    icon: Icon(
                      _collapsed
                          ? Icons.keyboard_double_arrow_right
                          : Icons.keyboard_double_arrow_left,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: Column(
              children: [
                _TopToolbar(location: location),
                Expanded(child: widget.child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TopToolbar extends StatelessWidget {
  const _TopToolbar({required this.location});

  final String location;

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('MMMM d, yyyy').format(DateTime.now());
    final title = _pageTitle(location);

    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 28),
      color: AppColors.white,
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Academic Year 2026–2027',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            date,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 16),
          const CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.primaryLight,
            child: Icon(
              Icons.person_outline,
              size: 20,
              color: AppColors.primaryDark,
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'Instructor',
            style: TextStyle(
              color: AppColors.text,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _pageTitle(String location) {
    switch (location) {
      case '/dashboard':
        return 'Dashboard';
      case '/academic':
        return 'Academic Management';
      case '/subjects':
        return 'Subjects';
      case '/students':
        return 'Students';
      case '/grade-sheets':
        return 'Grade Sheets';
      case '/attendance':
        return 'Attendance';
      case '/rankings':
        return 'Rankings';
      case '/reports':
        return 'Reports';
      case '/backup':
        return 'Backup and Restore';
      case '/settings':
        return 'Settings';
      default:
        return 'Grade Management';
    }
  }
}

class _NavDestination {
  const _NavDestination(this.path, this.icon, this.label);

  final String path;
  final IconData icon;
  final String label;
}
