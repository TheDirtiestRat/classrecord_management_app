import 'package:classrecord_management_app/core/database/app_database.dart';
import 'package:classrecord_management_app/core/database/database_provider.dart';
import 'package:classrecord_management_app/features/dashboard/providers/dashboard_providers.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() => database.close());

  test('dashboard totals and sheet states come from saved records', () async {
    final yearId = await database.createAcademicYear(
      '2026-2027',
      isActive: true,
    );
    final semesterId = await database.createSemester(
      academicYearId: yearId,
      name: 'First Semester',
      isActive: true,
    );
    final subjectId = await database.createSubject(
      code: 'IT101',
      name: 'Introduction to Computing',
      academicYearId: yearId,
      semesterId: semesterId,
    );
    final studentId = await database.createStudent(
      studentNumber: '2026-001',
      firstName: 'Ana',
      lastName: 'Reyes',
    );
    await database.enrollStudent(subjectId: subjectId, studentId: studentId);
    final period = (await database.getGradingPeriods()).first;
    await database.saveTermGrade(
      subjectId: subjectId,
      studentId: studentId,
      gradingPeriodId: period.id,
      grade: 90,
    );
    await database.createAssessment(
      subjectId: subjectId,
      gradingPeriodId: period.id,
      name: 'Quiz 1',
      type: 'Quiz',
      totalPossibleScore: 20,
    );

    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWith((ref) async => database)],
    );
    addTearDown(container.dispose);

    final data = await container.read(dashboardDataProvider.future);

    expect(data.subjects, hasLength(1));
    expect(data.totalStudents, 1);
    expect(data.totalEnrollments, 1);
    expect(data.totalAssessments, 1);
    expect(data.activeSubjects, 1);
    expect(data.activeAcademicYear?.name, '2026-2027');
    expect(data.activeSemester?.name, 'First Semester');
    expect(data.completedGradeSheets, 1);
    expect(data.pendingGradeSheets, 3);
  });
}
