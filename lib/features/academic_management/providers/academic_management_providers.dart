import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

final academicYearsProvider = FutureProvider.autoDispose<List<AcademicYear>>((
  ref,
) async {
  final database = await ref.watch(appDatabaseProvider.future);
  return database.getAllAcademicYears();
});

final semestersProvider = FutureProvider.autoDispose
    .family<List<Semester>, int>((ref, yearId) async {
      final database = await ref.watch(appDatabaseProvider.future);
      return database.getSemesters(yearId);
    });

final schoolSettingProvider = FutureProvider.autoDispose<SchoolSetting?>((
  ref,
) async {
  final database = await ref.watch(appDatabaseProvider.future);
  return database.getSchoolSetting();
});

final instructorsProvider = FutureProvider.autoDispose<List<Instructor>>((
  ref,
) async {
  final database = await ref.watch(appDatabaseProvider.future);
  return database.getAllInstructors();
});

final sectionsProvider = FutureProvider.autoDispose<List<Section>>((ref) async {
  final database = await ref.watch(appDatabaseProvider.future);
  return database.getAllSections();
});

final subjectsProvider = FutureProvider.autoDispose<List<Subject>>((ref) async {
  final database = await ref.watch(appDatabaseProvider.future);
  return database.getAllSubjects();
});
