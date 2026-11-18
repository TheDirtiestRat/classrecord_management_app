import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

final studentsProvider = FutureProvider.autoDispose<List<Student>>((ref) async {
  final database = await ref.watch(appDatabaseProvider.future);
  return database.getAllStudents();
});

final enrolledStudentsProvider = FutureProvider.autoDispose
    .family<List<Student>, int>((ref, subjectId) async {
      final database = await ref.watch(appDatabaseProvider.future);
      return database.getEnrolledStudents(subjectId);
    });
