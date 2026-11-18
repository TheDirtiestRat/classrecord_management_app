import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:classrecord_management_app/core/database/app_database.dart';
import 'package:classrecord_management_app/core/services/term_grade_calculation_service.dart';

void main() {
  late AppDatabase database;
  late int subjectId;
  late int periodId;
  late List<int> studentIds;

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
    periodId = (await database.getGradingPeriods()).first.id;
    studentIds = [
      await database.createStudent(
        studentNumber: '2026-401',
        firstName: 'Ana',
        lastName: 'Reyes',
      ),
      await database.createStudent(
        studentNumber: '2026-402',
        firstName: 'Ben',
        lastName: 'Cruz',
      ),
      await database.createStudent(
        studentNumber: '2026-403',
        firstName: 'Cara',
        lastName: 'Santos',
      ),
    ];
    for (final studentId in studentIds) {
      await database.enrollStudent(subjectId: subjectId, studentId: studentId);
    }
    await database.saveGradingConfiguration(
      subjectId: subjectId,
      quizWeight: 50,
      attendanceWeight: 0,
      workWeight: 50,
      majorExamWeight: 0,
      independentLearningWeight: 0,
    );
  });

  tearDown(() => database.close());

  test(
    'stores complete grades, leaves missing entries incomplete, and ranks ties',
    () async {
      final quizId = await database.createAssessment(
        subjectId: subjectId,
        gradingPeriodId: periodId,
        name: 'Quiz 1',
        type: 'Quiz',
        totalPossibleScore: 10,
      );
      final workId = await database.createAssessment(
        subjectId: subjectId,
        gradingPeriodId: periodId,
        name: 'Seatwork 1',
        type: 'Seatwork',
        totalPossibleScore: 10,
      );
      for (final studentId in studentIds.take(2)) {
        await database.saveAssessmentScore(
          assessmentId: quizId,
          studentId: studentId,
          score: 10,
        );
        await database.saveAssessmentScore(
          assessmentId: workId,
          studentId: studentId,
          score: 10,
        );
      }
      await database.saveAssessmentScore(
        assessmentId: workId,
        studentId: studentIds.last,
        score: 10,
      );

      const service = TermGradeCalculationService();
      final initial = await service.computeAndSave(
        database: database,
        subjectId: subjectId,
        gradingPeriodId: periodId,
      );
      expect(initial.enrolledStudents, 3);
      expect(initial.completedGrades, 2);
      expect(initial.incompleteGrades, 1);

      var grades = await database.getTermGrades(
        subjectId: subjectId,
        gradingPeriodId: periodId,
      );
      expect(
        grades.singleWhere((grade) => grade.studentId == studentIds.last).grade,
        isNull,
      );
      var rankings = await database.getRankings(
        subjectId: subjectId,
        gradingPeriodId: periodId,
      );
      expect(rankings.map((ranking) => ranking.rank), [1, 1]);

      await database.saveAssessmentScore(
        assessmentId: quizId,
        studentId: studentIds.last,
        score: 10,
      );
      final recomputed = await service.computeAndSave(
        database: database,
        subjectId: subjectId,
        gradingPeriodId: periodId,
      );
      expect(recomputed.completedGrades, 3);
      grades = await database.getTermGrades(
        subjectId: subjectId,
        gradingPeriodId: periodId,
      );
      expect(grades.every((grade) => grade.grade == 100), isTrue);
      rankings = await database.getRankings(
        subjectId: subjectId,
        gradingPeriodId: periodId,
      );
      expect(rankings.map((ranking) => ranking.rank), [1, 1, 1]);
    },
  );

  test('attendance grade uses instructor-configured code values', () async {
    await database.saveGradingConfiguration(
      subjectId: subjectId,
      quizWeight: 0,
      attendanceWeight: 100,
      workWeight: 0,
      majorExamWeight: 0,
      independentLearningWeight: 0,
    );
    await database.saveApplicationSetting(
      'attendance_scoring',
      '{"P":90,"L":70,"A":0,"E":100}',
    );
    final sessionId = await database.createAttendanceSession(
      subjectId: subjectId,
      gradingPeriodId: periodId,
      sessionDate: '2026-11-18',
    );
    await database.saveAttendanceCode(
      attendanceSessionId: sessionId,
      studentId: studentIds.first,
      code: 'L',
    );

    final result = await const TermGradeCalculationService().computeAndSave(
      database: database,
      subjectId: subjectId,
      gradingPeriodId: periodId,
    );
    final grades = await database.getTermGrades(
      subjectId: subjectId,
      gradingPeriodId: periodId,
    );
    final attendanceGrade = grades
        .singleWhere((grade) => grade.studentId == studentIds.first)
        .grade;

    expect(result.completedGrades, 1);
    expect(attendanceGrade, 70);
  });

  test(
    'attendance without configured values is not assigned an assumed grade',
    () async {
      await database.saveGradingConfiguration(
        subjectId: subjectId,
        quizWeight: 0,
        attendanceWeight: 100,
        workWeight: 0,
        majorExamWeight: 0,
        independentLearningWeight: 0,
      );
      final sessionId = await database.createAttendanceSession(
        subjectId: subjectId,
        gradingPeriodId: periodId,
        sessionDate: '2026-11-18',
      );
      await database.saveAttendanceCode(
        attendanceSessionId: sessionId,
        studentId: studentIds.first,
        code: 'P',
      );

      final result = await const TermGradeCalculationService().computeAndSave(
        database: database,
        subjectId: subjectId,
        gradingPeriodId: periodId,
      );
      final grades = await database.getTermGrades(
        subjectId: subjectId,
        gradingPeriodId: periodId,
      );

      expect(result.completedGrades, 0);
      expect(
        grades
            .singleWhere((grade) => grade.studentId == studentIds.first)
            .grade,
        isNull,
      );
    },
  );
}
