import 'package:flutter_test/flutter_test.dart';

import 'package:classrecord_management_app/core/services/grade_computation_service.dart';

void main() {
  const service = GradeComputationService();

  test('computes weighted term grade', () {
    final grade = service.computeTermGrade(
      weights: const GradeWeights(),
      quizzes: const [
        GradeComponentInput(earned: 18, possible: 20),
        GradeComponentInput(earned: 20, possible: 20),
      ],
      attendance: const [GradeComponentInput(earned: 100, possible: 100)],
      work: const [GradeComponentInput(earned: 40, possible: 50)],
      majorExams: const [GradeComponentInput(earned: 80, possible: 100)],
      independentLearning: const [
        GradeComponentInput(earned: 45, possible: 50),
      ],
    );

    expect(grade, 86);
  });

  test('rejects grading weights that do not total 100', () {
    final grade = service.computeTermGrade(
      weights: const GradeWeights(quizzes: 10),
      quizzes: const [GradeComponentInput(earned: 10, possible: 10)],
      attendance: const [GradeComponentInput(earned: 100, possible: 100)],
      work: const [GradeComponentInput(earned: 50, possible: 50)],
      majorExams: const [GradeComponentInput(earned: 100, possible: 100)],
      independentLearning: const [
        GradeComponentInput(earned: 50, possible: 50),
      ],
    );

    expect(grade, isNull);
  });

  test('missing component returns incomplete grade', () {
    final grade = service.computeTermGrade(
      weights: const GradeWeights(),
      quizzes: const [],
      attendance: const [GradeComponentInput(earned: 100, possible: 100)],
      work: const [GradeComponentInput(earned: 50, possible: 50)],
      majorExams: const [GradeComponentInput(earned: 100, possible: 100)],
      independentLearning: const [
        GradeComponentInput(earned: 50, possible: 50),
      ],
    );

    expect(grade, isNull);
  });

  test('uses competition ranking for ties', () {
    final ranked = GradeComputationService.rankEntries([
      const GradeRankingEntry(studentId: 1, studentName: 'One', grade: 95),
      const GradeRankingEntry(studentId: 2, studentName: 'Two', grade: 95),
      const GradeRankingEntry(studentId: 3, studentName: 'Three', grade: 90),
    ]);

    expect(ranked.map((entry) => entry.rank), [1, 1, 3]);
  });

  test('attendance codes use configured values', () {
    const values = AttendanceValues(
      present: 100,
      late: 80,
      absent: 0,
      excused: 100,
    );
    expect(values.valueFor('P'), 100);
    expect(values.valueFor('L'), 80);
    expect(values.valueFor('A'), 0);
    expect(values.valueFor('E'), 100);
  });
}
