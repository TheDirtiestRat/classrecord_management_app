import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:classrecord_management_app/core/database/app_database.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() => database.close());

  test('creates grading periods during database initialization', () async {
    final periods = await database.select(database.gradingPeriods).get();

    expect(periods.map((period) => period.name), [
      'Prelim',
      'Midterm',
      'Prefinal',
      'Final',
    ]);
  });

  test('creates and retrieves an academic year', () async {
    await database.createAcademicYear('2026-2027', isActive: true);

    final years = await database.getAllAcademicYears();

    expect(years, hasLength(1));
    expect(years.single.name, '2026-2027');
    expect(years.single.isActive, isTrue);
  });

  test('records and retrieves recent activity', () async {
    await database.createActivityLog(
      activity: 'Student added',
      details: 'Test student',
    );

    final activity = await database.getRecentActivity();

    expect(activity, hasLength(1));
    expect(activity.single.activity, 'Student added');
  });

  test('creates academic data, sections, and a subject', () async {
    final yearId = await database.createAcademicYear(
      '2026-2027',
      isActive: true,
    );
    final semesterId = await database.createSemester(
      academicYearId: yearId,
      name: 'First Semester',
      isActive: true,
    );
    final sectionId = await database.createSection(
      name: 'BSIT-1A',
      course: 'BSIT',
      yearLevel: 1,
    );

    final subjectId = await database.createSubject(
      code: 'IT101',
      name: 'Introduction to Computing',
      academicYearId: yearId,
      semesterId: semesterId,
      sectionId: sectionId,
      units: 3,
    );

    final subjects = await database.getAllSubjects();
    final semesters = await database.getSemesters(yearId);
    final sections = await database.getAllSections();

    expect(subjectId, greaterThan(0));
    expect(subjects.single.code, 'IT101');
    expect(semesters.single.name, 'First Semester');
    expect(sections.single.name, 'BSIT-1A');
  });

  test('only one academic year remains active', () async {
    final firstId = await database.createAcademicYear(
      '2025-2026',
      isActive: true,
    );
    await database.createAcademicYear('2026-2027', isActive: true);

    final years = await database.getAllAcademicYears();
    expect(years.where((year) => year.isActive), hasLength(1));
    expect(years.where((year) => year.isActive).single.id, isNot(firstId));
  });

  test('saves and retrieves school settings', () async {
    await database.saveSchoolSetting(
      schoolName: 'Example College',
      address: 'Test Address',
    );

    final school = await database.getSchoolSetting();
    expect(school?.schoolName, 'Example College');
    expect(school?.address, 'Test Address');
  });

  test('creates a student and prevents duplicate subject enrollment', () async {
    final yearId = await database.createAcademicYear('2026-2027');
    final semesterId = await database.createSemester(
      academicYearId: yearId,
      name: 'First Semester',
    );
    final subjectId = await database.createSubject(
      code: 'IT101',
      name: 'Introduction to Computing',
      academicYearId: yearId,
      semesterId: semesterId,
    );
    final studentId = await database.createStudent(
      studentNumber: '2026-0001',
      firstName: 'Juan',
      lastName: 'Dela Cruz',
      course: 'BSIT',
      yearLevel: 1,
    );

    await database.enrollStudent(subjectId: subjectId, studentId: studentId);
    await database.enrollStudent(subjectId: subjectId, studentId: studentId);

    final students = await database.getAllStudents();
    final enrolled = await database.getEnrolledStudents(subjectId);
    expect(students.single.studentNumber, '2026-0001');
    expect(enrolled, hasLength(1));
    expect(enrolled.single.id, studentId);
  });

  test('CSV import helper does not duplicate student numbers', () async {
    await database.findOrCreateStudentFromCsv(
      studentNumber: '2026-100',
      firstName: 'Maria',
      lastName: 'Santos',
      course: 'BSIT',
    );
    await database.findOrCreateStudentFromCsv(
      studentNumber: '2026-100',
      firstName: 'Maria',
      lastName: 'Santos',
      course: 'BSIT',
    );

    final students = await database.getAllStudents();
    expect(students, hasLength(1));
  });
}
