import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

final studentsProvider = FutureProvider.autoDispose<List<Student>>((ref) async {
  final database = await ref.watch(appDatabaseProvider.future);
  return database.getAllStudents();
});

final studentDirectoryPageProvider = FutureProvider.autoDispose
    .family<DatabasePage<Student>, StudentDirectoryQuery>((ref, query) async {
      final database = await ref.watch(appDatabaseProvider.future);
      return database.getStudentsPage(
        limit: query.rowsPerPage,
        offset: query.pageIndex * query.rowsPerPage,
        search: query.search,
        course: query.course,
        status: query.status,
        yearLevel: query.yearLevel,
      );
    });

final studentCourseOptionsProvider = FutureProvider.autoDispose<List<String>>((
  ref,
) async {
  final database = await ref.watch(appDatabaseProvider.future);
  return database.getStudentCourses();
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
  ref.invalidate(studentDirectoryPageProvider);
  ref.invalidate(studentCourseOptionsProvider);
  for (final subjectId in subjectIdsToAdd.toSet()) {
    ref.invalidate(enrolledStudentsProvider(subjectId));
  }
}

class StudentDirectoryQuery {
  const StudentDirectoryQuery({
    required this.search,
    required this.course,
    required this.status,
    required this.yearLevel,
    required this.pageIndex,
    required this.rowsPerPage,
  });

  final String search;
  final String? course;
  final String? status;
  final int? yearLevel;
  final int pageIndex;
  final int rowsPerPage;

  @override
  bool operator ==(Object other) =>
      other is StudentDirectoryQuery &&
      other.search == search &&
      other.course == course &&
      other.status == status &&
      other.yearLevel == yearLevel &&
      other.pageIndex == pageIndex &&
      other.rowsPerPage == rowsPerPage;

  @override
  int get hashCode =>
      Object.hash(search, course, status, yearLevel, pageIndex, rowsPerPage);
}
