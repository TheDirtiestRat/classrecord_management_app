import 'package:go_router/go_router.dart';

import '../features/academic_management/presentation/academic_management_page.dart';
import '../features/backup_restore/presentation/backup_restore_page.dart';
import '../features/attendance/presentation/attendance_page.dart';
import '../features/dashboard/presentation/dashboard_page.dart';
import '../features/grade_sheets/presentation/grade_sheets_page.dart';
import '../features/rankings/presentation/rankings_page.dart';
import '../features/reports/presentation/reports_page.dart';
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
            path: '/attendance',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: AttendancePage()),
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
          GoRoute(
            path: '/reports',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ReportsPage()),
          ),
          GoRoute(
            path: '/backup',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: BackupRestorePage()),
          ),
          ..._moduleRoutes(),
        ],
      ),
    ],
  );

  static List<GoRoute> _moduleRoutes() {
    const modules = <String, String>{'/settings': 'Settings'};

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
