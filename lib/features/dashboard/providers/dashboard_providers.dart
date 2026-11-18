import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

final dashboardDataProvider = FutureProvider.autoDispose<DashboardData>((
  ref,
) async {
  final database = await ref.watch(appDatabaseProvider.future);
  final subjects = await database.getAllSubjects();
  final students = await database.getAllStudents();
  final enrollments = await database.select(database.subjectEnrollments).get();
  final assessments = await database.select(database.assessments).get();
  final gradingPeriods = await database.getGradingPeriods();
  final termGrades = await database.select(database.termGrades).get();
  final academicYears = await database.getAllAcademicYears();
  final recentActivity = await database.getRecentActivity(limit: 8);

  final enrolledStudentsBySubject = <int, Set<int>>{};
  for (final enrollment in enrollments) {
    enrolledStudentsBySubject
        .putIfAbsent(enrollment.subjectId, () => <int>{})
        .add(enrollment.studentId);
  }

  final completedStudentsBySheet = <(int, int), Set<int>>{};
  for (final grade in termGrades) {
    if (grade.grade != null) {
      completedStudentsBySheet
          .putIfAbsent((grade.subjectId, grade.gradingPeriodId), () => <int>{})
          .add(grade.studentId);
    }
  }

  var pendingGradeSheets = 0;
  var completedGradeSheets = 0;
  for (final subject in subjects.where(
    (subject) => subject.status.toLowerCase() == 'active',
  )) {
    final enrolledStudentIds = enrolledStudentsBySubject[subject.id] ?? {};
    for (final period in gradingPeriods) {
      final completedStudentIds =
          completedStudentsBySheet[(subject.id, period.id)] ?? {};
      if (enrolledStudentIds.isNotEmpty &&
          enrolledStudentIds.every(completedStudentIds.contains)) {
        completedGradeSheets++;
      } else {
        pendingGradeSheets++;
      }
    }
  }

  final activeYear = academicYears.where((year) => year.isActive).firstOrNull;
  final activeSemester = activeYear == null
      ? null
      : (await database.getSemesters(activeYear.id))
            .where((semester) => semester.isActive)
            .firstOrNull;

  return DashboardData(
    subjects: subjects,
    totalStudents: students.length,
    totalEnrollments: enrollments.length,
    totalAssessments: assessments.length,
    pendingGradeSheets: pendingGradeSheets,
    completedGradeSheets: completedGradeSheets,
    activeAcademicYear: activeYear,
    activeSemester: activeSemester,
    enrolledStudentsBySubject: {
      for (final entry in enrolledStudentsBySubject.entries)
        entry.key: entry.value.length,
    },
    recentActivity: recentActivity,
  );
});

class DashboardData {
  const DashboardData({
    required this.subjects,
    required this.totalStudents,
    required this.totalEnrollments,
    required this.totalAssessments,
    required this.pendingGradeSheets,
    required this.completedGradeSheets,
    required this.activeAcademicYear,
    required this.activeSemester,
    required this.enrolledStudentsBySubject,
    required this.recentActivity,
  });

  final List<Subject> subjects;
  final int totalStudents;
  final int totalEnrollments;
  final int totalAssessments;
  final int pendingGradeSheets;
  final int completedGradeSheets;
  final AcademicYear? activeAcademicYear;
  final Semester? activeSemester;
  final Map<int, int> enrolledStudentsBySubject;
  final List<ActivityLog> recentActivity;

  int get activeSubjects => subjects
      .where((subject) => subject.status.toLowerCase() == 'active')
      .length;
}
