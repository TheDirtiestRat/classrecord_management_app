import 'dart:math';

class GradeWeights {
  const GradeWeights({
    this.quizzes = 20,
    this.attendance = 10,
    this.work = 20,
    this.majorExams = 40,
    this.independentLearning = 10,
  });

  final double quizzes;
  final double attendance;
  final double work;
  final double majorExams;
  final double independentLearning;

  double get total =>
      quizzes + attendance + work + majorExams + independentLearning;

  bool get isValid => (total - 100).abs() < 0.0001;
}

class AttendanceValues {
  const AttendanceValues({
    this.present = 100,
    this.late = 75,
    this.absent = 0,
    this.excused = 100,
  });

  final double present;
  final double late;
  final double absent;
  final double excused;

  double valueFor(String code) {
    switch (code.toUpperCase()) {
      case 'P':
        return present;
      case 'L':
        return late;
      case 'A':
        return absent;
      case 'E':
        return excused;
      default:
        return double.nan;
    }
  }
}

class GradeComponentInput {
  const GradeComponentInput({required this.earned, required this.possible});

  final double earned;
  final double possible;
}

class GradeComputationService {
  const GradeComputationService();

  double percentage(List<GradeComponentInput> entries) {
    if (entries.isEmpty) return double.nan;
    var earned = 0.0;
    var possible = 0.0;
    for (final entry in entries) {
      if (entry.possible <= 0) continue;
      earned += entry.earned;
      possible += entry.possible;
    }
    if (possible <= 0) return double.nan;
    return earned / possible * 100;
  }

  double? computeTermGrade({
    required GradeWeights weights,
    required List<GradeComponentInput> quizzes,
    required List<GradeComponentInput> attendance,
    required List<GradeComponentInput> work,
    required List<GradeComponentInput> majorExams,
    required List<GradeComponentInput> independentLearning,
    int decimalPlaces = 2,
  }) {
    if (!weights.isValid) return null;
    final components = [
      percentage(quizzes),
      percentage(attendance),
      percentage(work),
      percentage(majorExams),
      percentage(independentLearning),
    ];
    if (components.any((value) => value.isNaN)) return null;
    final grade =
        components[0] * weights.quizzes / 100 +
        components[1] * weights.attendance / 100 +
        components[2] * weights.work / 100 +
        components[3] * weights.majorExams / 100 +
        components[4] * weights.independentLearning / 100;
    final factor = pow(10, decimalPlaces).toDouble();
    return (grade * factor).round() / factor;
  }

  static List<GradeRankingEntry> rankEntries(List<GradeRankingEntry> entries) {
    final sorted = [...entries]..sort((a, b) => b.grade.compareTo(a.grade));
    double? previousGrade;
    var rank = 0;
    for (var index = 0; index < sorted.length; index++) {
      if (previousGrade == null || sorted[index].grade != previousGrade) {
        rank = index + 1;
        previousGrade = sorted[index].grade;
      }
      sorted[index] = sorted[index].copyWith(rank: rank);
    }
    return sorted;
  }
}

class GradeRankingEntry {
  const GradeRankingEntry({
    required this.studentId,
    required this.studentName,
    required this.grade,
    this.rank,
  });

  final int studentId;
  final String studentName;
  final double grade;
  final int? rank;

  GradeRankingEntry copyWith({int? rank}) => GradeRankingEntry(
    studentId: studentId,
    studentName: studentName,
    grade: grade,
    rank: rank ?? this.rank,
  );
}
