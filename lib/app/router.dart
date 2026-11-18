import 'package:go_router/go_router.dart';

import '../features/academic_management/presentation/academic_management_page.dart';
import '../features/dashboard/presentation/dashboard_page.dart';
import '../features/grade_sheets/presentation/grade_sheets_page.dart';
import '../features/rankings/presentation/rankings_page.dart';
import '../features/shared/presentation/module_placeholder_page.dart';
import '../features/students/presentation/students_page.dart';
import '../features/subjects/presentation/subjects_page.dart';
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
          GoRoute(
            path: '/academic',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: AcademicManagementPage()),
          ),
          GoRoute(
            path: '/subjects',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: SubjectsPage()),
          ),
          GoRoute(
            path: '/students',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: StudentsPage()),
          ),
          GoRoute(
            path: '/grade-sheets',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: GradeSheetsPage()),
          ),
          GoRoute(
            path: '/rankings',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: RankingsPage()),
          ),
          ..._moduleRoutes(),
        ],
      ),
    ],
  );

  static List<GoRoute> _moduleRoutes() {
    const modules = <String, String>{
      '/attendance': 'Attendance',
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
