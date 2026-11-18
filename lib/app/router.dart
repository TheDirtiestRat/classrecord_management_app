import 'package:go_router/go_router.dart';

import '../features/dashboard/presentation/dashboard_page.dart';
import '../features/shared/presentation/module_placeholder_page.dart';
import '../shared/widgets/app_shell.dart';

class AppRouter {
  const AppRouter._();

  static final router = GoRouter(
    initialLocation: '/dashboard',
    routes: [
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: DashboardPage()),
          ),
          ..._moduleRoutes(),
        ],
      ),
    ],
  );

  static List<GoRoute> _moduleRoutes() {
    const modules = <String, String>{
      '/academic': 'Academic Management',
      '/subjects': 'Subjects',
      '/students': 'Students',
      '/grade-sheets': 'Grade Sheets',
      '/attendance': 'Attendance',
      '/rankings': 'Rankings',
      '/reports': 'Reports',
      '/backup': 'Backup and Restore',
      '/settings': 'Settings',
    };

    return modules.entries
        .map(
          (entry) => GoRoute(
            path: entry.key,
            pageBuilder: (context, state) => NoTransitionPage(
              child: ModulePlaceholderPage(title: entry.value),
            ),
          ),
        )
        .toList();
  }
}
