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

Future<void> applyStudentBatchUpdate(
  WidgetRef ref, {
  required List<int> studentIds,
  bool updateCourse = false,
  String course = '',
  bool updateYearLevel = false,
  int? yearLevel,
  bool updateSection = false,
  int? sectionId,
  bool updateStatus = false,
  String status = 'Active',
  List<int> subjectIdsToAdd = const [],
}) async {
  final database = await ref.read(appDatabaseProvider.future);
  await database.updateStudentsBatch(
    studentIds: studentIds,
    updateCourse: updateCourse,
    course: course,
    updateYearLevel: updateYearLevel,
    yearLevel: yearLevel,
    updateSection: updateSection,
    sectionId: sectionId,
    updateStatus: updateStatus,
    status: status,
    subjectIdsToAdd: subjectIdsToAdd,
  );
  ref.invalidate(studentsProvider);
  for (final subjectId in subjectIdsToAdd.toSet()) {
    ref.invalidate(enrolledStudentsProvider(subjectId));
  }
}
