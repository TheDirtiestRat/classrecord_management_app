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

  test('batch-updates selected students and adds subjects', () async {
    final yearId = await database.createAcademicYear('2026-2027');
    final semesterId = await database.createSemester(
      academicYearId: yearId,
      name: 'First Semester',
    );
    final firstSectionId = await database.createSection(name: 'BSIT-1A');
    final nextSectionId = await database.createSection(name: 'BSIT-2A');
    final firstStudentId = await database.createStudent(
      studentNumber: '2026-300',
      firstName: 'Ana',
      lastName: 'Reyes',
      course: 'BSIT',
      yearLevel: 1,
      sectionId: firstSectionId,
    );
    final secondStudentId = await database.createStudent(
      studentNumber: '2026-301',
      firstName: 'Ben',
      lastName: 'Santos',
      course: 'BSIT',
      yearLevel: 1,
      sectionId: firstSectionId,
    );
    final unselectedStudentId = await database.createStudent(
      studentNumber: '2026-302',
      firstName: 'Cara',
      lastName: 'Diaz',
      course: 'BSIT',
      yearLevel: 1,
      sectionId: firstSectionId,
    );
    final existingSubjectId = await database.createSubject(
      code: 'IT101',
      name: 'Existing Subject',
      academicYearId: yearId,
      semesterId: semesterId,
    );
    final addedSubjectId = await database.createSubject(
      code: 'IT102',
      name: 'Added Subject',
      academicYearId: yearId,
      semesterId: semesterId,
    );
    await database.enrollStudent(
      subjectId: existingSubjectId,
      studentId: firstStudentId,
    );

    final updatedCount = await database.updateStudentsBatch(
      studentIds: [firstStudentId, secondStudentId, firstStudentId],
      updateCourse: true,
      course: 'BSCS',
      updateYearLevel: true,
      yearLevel: 2,
      updateSection: true,
      sectionId: nextSectionId,
      updateStatus: true,
      status: 'Inactive',
      subjectIdsToAdd: [addedSubjectId],
    );

    final students = {
      for (final student in await database.getAllStudents())
        student.id: student,
    };
    final addedEnrollments = await database.getEnrolledStudents(addedSubjectId);
    final existingEnrollments = await database.getEnrolledStudents(
      existingSubjectId,
    );
    expect(updatedCount, 2);
    for (final studentId in [firstStudentId, secondStudentId]) {
      expect(students[studentId]?.course, 'BSCS');
      expect(students[studentId]?.yearLevel, 2);
      expect(students[studentId]?.sectionId, nextSectionId);
      expect(students[studentId]?.status, 'Inactive');
    }
    expect(students[unselectedStudentId]?.course, 'BSIT');
    expect(addedEnrollments.map((student) => student.id).toSet(), {
      firstStudentId,
      secondStudentId,
    });
    expect(existingEnrollments.map((student) => student.id).toList(), [
      firstStudentId,
    ]);
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

  test(
    'grade sheet stores missing and zero assessment scores separately',
    () async {
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
        studentNumber: '2026-200',
        firstName: 'Ana',
        lastName: 'Reyes',
      );
      final period = (await database.getGradingPeriods()).first;
      final assessmentId = await database.createAssessment(
        subjectId: subjectId,
        gradingPeriodId: period.id,
        name: 'Quiz 1',
        type: 'Quiz',
        totalPossibleScore: 20,
      );

      await database.saveAssessmentScore(
        assessmentId: assessmentId,
        studentId: studentId,
        score: null,
      );
      final missing = await database.getAssessmentScores(assessmentId);
      expect(missing.single.score, isNull);
      expect(
        (await database.getAssessmentScoresForAssessments([assessmentId]))
            .single
            .score,
        isNull,
      );

      await database.saveAssessmentScore(
        assessmentId: assessmentId,
        studentId: studentId,
        score: 0,
      );
      final zero = await database.getAssessmentScores(assessmentId);
      expect(zero.single.score, 0);
      expect(
        (await database.getAssessmentScoresForAssessments([assessmentId]))
            .single
            .score,
        0,
      );
    },
  );

  test('grade sheet stores attendance codes by session', () async {
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
      studentNumber: '2026-201',
      firstName: 'Leo',
      lastName: 'Garcia',
    );
    final period = (await database.getGradingPeriods()).first;
    final sessionId = await database.createAttendanceSession(
      subjectId: subjectId,
      gradingPeriodId: period.id,
      sessionDate: '2026-11-18',
    );

    await database.saveAttendanceCode(
      attendanceSessionId: sessionId,
      studentId: studentId,
      code: 'P',
    );
    await database.saveAttendanceCode(
      attendanceSessionId: sessionId,
      studentId: studentId,
      code: 'A',
    );

    final records = await database.getStudentAttendance(sessionId);
    expect(records, hasLength(1));
    expect(records.single.code, 'A');
    expect(
      (await database.getStudentAttendanceForSessions([sessionId])).single.code,
      'A',
    );
  });

  test('loads independent learning scores in batches by record ID', () async {
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
      studentNumber: '2026-202',
      firstName: 'Mia',
      lastName: 'Reyes',
    );
    final period = (await database.getGradingPeriods()).first;
    final recordId = await database.createIndependentLearningRecord(
      subjectId: subjectId,
      gradingPeriodId: period.id,
      activityName: 'Reading',
      totalPossibleScore: 10,
    );

    await database.saveIndependentLearningScore(
      recordId: recordId,
      studentId: studentId,
      score: 8,
    );

    final scores = await database.getIndependentLearningScoresForRecords([
      recordId,
    ]);
    expect(scores, hasLength(1));
    expect(scores.single.studentId, studentId);
    expect(scores.single.score, 8);
    expect(await database.getIndependentLearningScoresForRecords([]), isEmpty);
  });

  test('persists grading settings, term grades, and rankings', () async {
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
      studentNumber: '2026-300',
      firstName: 'Nina',
      lastName: 'Lopez',
    );
    final period = (await database.getGradingPeriods()).first;

    await database.saveGradingConfiguration(
      subjectId: subjectId,
      quizWeight: 25,
      attendanceWeight: 5,
      workWeight: 20,
      majorExamWeight: 40,
      independentLearningWeight: 10,
      decimalPlaces: 1,
    );
    await database.saveApplicationSetting(
      'attendance_scoring',
      '{"P":100,"L":80,"A":0,"E":100}',
    );
    await database.saveTermGrade(
      subjectId: subjectId,
      studentId: studentId,
      gradingPeriodId: period.id,
      grade: 87.5,
    );
    await database.saveTermGrade(
      subjectId: subjectId,
      studentId: studentId,
      gradingPeriodId: period.id,
      grade: 88,
    );
    await database.replaceRankings(
      subjectId: subjectId,
      gradingPeriodId: period.id,
      rankings: [(studentId: studentId, rank: 1, grade: 88)],
    );

    final config = await database.getActiveGradingConfiguration(subjectId);
    final setting = await database.getApplicationSetting('attendance_scoring');
    final grades = await database.getTermGrades(
      subjectId: subjectId,
      gradingPeriodId: period.id,
    );
    final rankings = await database.getRankings(
      subjectId: subjectId,
      gradingPeriodId: period.id,
    );

    expect(config?.quizWeight, 25);
    expect(config?.decimalPlaces, 1);
    expect(setting, '{"P":100,"L":80,"A":0,"E":100}');
    expect(grades, hasLength(1));
    expect(grades.single.grade, 88);
    expect(rankings.single.rank, 1);
  });
}
