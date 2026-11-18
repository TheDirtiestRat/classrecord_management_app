import 'dart:convert';
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

  bool get isValid =>
      [
        quizzes,
        attendance,
        work,
        majorExams,
        independentLearning,
      ].every((weight) => weight.isFinite && weight >= 0 && weight <= 100) &&
      (total - 100).abs() < 0.0001;
}

class AttendanceValues {
  const AttendanceValues({this.present, this.late, this.absent, this.excused});

  final double? present;
  final double? late;
  final double? absent;
  final double? excused;

  bool get isConfigured => [present, late, absent, excused].every(
    (value) => value != null && value.isFinite && value >= 0 && value <= 100,
  );

  double valueFor(String code) {
    switch (code.toUpperCase()) {
      case 'P':
        return present ?? double.nan;
      case 'L':
        return late ?? double.nan;
      case 'A':
        return absent ?? double.nan;
      case 'E':
        return excused ?? double.nan;
      default:
        return double.nan;
    }
  }

  factory AttendanceValues.decode(String? value) {
    if (value == null || value.isEmpty) return const AttendanceValues();
    final json = jsonDecode(value);
    if (json is! Map<String, dynamic>) {
      throw const FormatException(
        'Attendance scoring settings must be an object.',
      );
    }

    double? numberFor(String key) {
      final item = json[key];
      return item is num ? item.toDouble() : null;
    }

    return AttendanceValues(
      present: numberFor('P'),
      late: numberFor('L'),
      absent: numberFor('A'),
      excused: numberFor('E'),
    );
  }

  String encode() =>
      jsonEncode({'P': present, 'L': late, 'A': absent, 'E': excused});
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
      if (!entry.earned.isFinite ||
          !entry.possible.isFinite ||
          entry.possible <= 0 ||
          entry.earned < 0 ||
          entry.earned > entry.possible) {
        return double.nan;
      }
      earned += entry.earned;
      possible += entry.possible;
    }
    if (possible <= 0) return double.nan;
    return earned / possible * 100;
  }

  double? computeTermGrade({
    required GradeWeights weights,
    bool isComplete = true,
    required List<GradeComponentInput> quizzes,
    required List<GradeComponentInput> attendance,
    required List<GradeComponentInput> work,
    required List<GradeComponentInput> majorExams,
    required List<GradeComponentInput> independentLearning,
    int decimalPlaces = 2,
  }) {
    if (!isComplete ||
        !weights.isValid ||
        decimalPlaces < 0 ||
        decimalPlaces > 6) {
      return null;
    }
    final components = [
      percentage(quizzes),
      percentage(attendance),
      percentage(work),
      percentage(majorExams),
      percentage(independentLearning),
    ];
    final componentWeights = [
      weights.quizzes,
      weights.attendance,
      weights.work,
      weights.majorExams,
      weights.independentLearning,
    ];
    for (var index = 0; index < components.length; index++) {
      if (componentWeights[index] > 0 && components[index].isNaN) {
        return null;
      }
    }
    var grade = 0.0;
    for (var index = 0; index < components.length; index++) {
      if (componentWeights[index] > 0) {
        grade += components[index] * componentWeights[index] / 100;
      }
    }
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
