import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

final attendancePeriodsProvider =
    FutureProvider.autoDispose<List<GradingPeriod>>((ref) async {
      final database = await ref.watch(appDatabaseProvider.future);
      return database.getGradingPeriods();
    });

final attendancePageDataProvider = FutureProvider.autoDispose
    .family<AttendancePageData, AttendancePageQuery>((ref, query) async {
      final database = await ref.watch(appDatabaseProvider.future);
      final page = await database.getEnrolledStudentsPage(
        subjectId: query.subjectId,
        limit: query.rowsPerPage,
        offset: query.pageIndex * query.rowsPerPage,
      );
      final sessions = await database.getAttendanceSessions(
        subjectId: query.subjectId,
        gradingPeriodId: query.gradingPeriodId,
      );
      AttendanceSession? selectedSession;
      for (final session in sessions) {
        if (session.sessionDate == query.sessionDate) {
          selectedSession = session;
          break;
        }
      }

      final attendance = selectedSession == null
          ? const <StudentAttendanceData>[]
          : await database.getStudentAttendanceForStudents(
              attendanceSessionId: selectedSession.id,
              studentIds: page.records.map((student) => student.id),
            );
      final attendanceCounts = selectedSession == null
          ? const <String, int>{}
          : await database.getAttendanceCodeCounts(selectedSession.id);
      return AttendancePageData(
        students: page.records,
        totalStudents: page.totalRecords,
        session: selectedSession,
        attendanceByStudent: {
          for (final record in attendance) record.studentId: record.code,
        },
        attendanceCounts: attendanceCounts,
      );
    });

class AttendancePageQuery {
  const AttendancePageQuery({
    required this.subjectId,
    required this.gradingPeriodId,
    required this.sessionDate,
    required this.pageIndex,
    required this.rowsPerPage,
  });

  final int subjectId;
  final int gradingPeriodId;
  final String sessionDate;
  final int pageIndex;
  final int rowsPerPage;

  @override
  bool operator ==(Object other) =>
      other is AttendancePageQuery &&
      other.subjectId == subjectId &&
      other.gradingPeriodId == gradingPeriodId &&
      other.sessionDate == sessionDate &&
      other.pageIndex == pageIndex &&
      other.rowsPerPage == rowsPerPage;

  @override
  int get hashCode => Object.hash(
    subjectId,
    gradingPeriodId,
    sessionDate,
    pageIndex,
    rowsPerPage,
  );
}

class AttendancePageData {
  const AttendancePageData({
    required this.students,
    required this.totalStudents,
    required this.session,
    required this.attendanceByStudent,
    required this.attendanceCounts,
  });

  final List<Student> students;
  final int totalStudents;
  final AttendanceSession? session;
  final Map<int, String> attendanceByStudent;
  final Map<String, int> attendanceCounts;
}
