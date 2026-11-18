import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/router.dart';
import 'app/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: GradeManagementApp()));
}

class GradeManagementApp extends StatelessWidget {
  const GradeManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Grade Management System',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.desktop,
      routerConfig: AppRouter.router,
    );
  }
}
