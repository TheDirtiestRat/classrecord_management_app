import 'package:classrecord_management_app/core/database/app_database.dart';
import 'package:classrecord_management_app/core/database/database_provider.dart';
import 'package:classrecord_management_app/features/attendance/presentation/attendance_page.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late int subjectId;
  late int studentId;

  setUp(() async {
    database = AppDatabase(NativeDatabase.memory());
    final yearId = await database.createAcademicYear('2026-2027');
    final semesterId = await database.createSemester(
      academicYearId: yearId,
      name: 'First Semester',
    );
    subjectId = await database.createSubject(
      code: 'IT101',
      name: 'Introduction to Computing',
      academicYearId: yearId,
      semesterId: semesterId,
    );
    studentId = await database.createStudent(
      studentNumber: '2026-001',
      firstName: 'Ana',
      lastName: 'Reyes',
    );
    await database.enrollStudent(subjectId: subjectId, studentId: studentId);
  });

  tearDown(() => database.close());

  testWidgets('starts a dated session and automatically saves attendance', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1440, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWith((ref) async => database)],
        child: const MaterialApp(home: Scaffold(body: AttendancePage())),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Start Attendance'));
    await tester.pumpAndSettle();
    expect(find.text('Student Number'), findsOneWidget);

    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('P — Present').last);
    await tester.pumpAndSettle();

    final period = (await database.getGradingPeriods()).first;
    final sessions = await database.getAttendanceSessions(
      subjectId: subjectId,
      gradingPeriodId: period.id,
    );
    expect(sessions, hasLength(1));
    final attendance = await database.getStudentAttendance(sessions.single.id);
    expect(attendance.single.studentId, studentId);
    expect(attendance.single.code, 'P');
    expect(
      await database.getTermGrades(
        subjectId: subjectId,
        gradingPeriodId: period.id,
      ),
      hasLength(1),
    );
  });
}
