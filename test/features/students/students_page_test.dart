import 'package:classrecord_management_app/core/database/app_database.dart';
import 'package:classrecord_management_app/core/database/database_provider.dart';
import 'package:classrecord_management_app/features/students/presentation/students_page.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() => database.close());

  testWidgets('batch update changes only selected students', (tester) async {
    tester.view.physicalSize = const Size(1440, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final selectedStudentId = await database.createStudent(
      studentNumber: '2026-001',
      firstName: 'Alex',
      lastName: 'Student',
      course: 'BSIT',
    );
    await database.createStudent(
      studentNumber: '2026-002',
      firstName: 'Jamie',
      lastName: 'Student',
      course: 'BSIT',
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWith((ref) async => database)],
        child: const MaterialApp(home: Scaffold(body: StudentsPage())),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(Checkbox).at(1));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Batch Update'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Update course'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, 'BSCS');
    await tester.tap(find.text('Apply'));
    await tester.pumpAndSettle();

    final students = {
      for (final student in await database.getAllStudents())
        student.id: student,
    };
    expect(students[selectedStudentId]?.course, 'BSCS');
    expect(
      students.values
          .singleWhere((student) => student.studentNumber == '2026-002')
          .course,
      'BSIT',
    );
  });
}
