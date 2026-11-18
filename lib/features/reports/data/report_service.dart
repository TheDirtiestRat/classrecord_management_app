import '../../../core/database/app_database.dart';
import '../domain/report_document_data.dart';

class ReportService {
  const ReportService();

  Future<ReportDocumentData> buildReport({
    required AppDatabase database,
    required ReportType type,
    required int subjectId,
    required int gradingPeriodId,
  }) async {
    final subject = await (database.select(
      database.subjects,
    )..where((row) => row.id.equals(subjectId))).getSingle();
    final year = await (database.select(
      database.academicYears,
    )..where((row) => row.id.equals(subject.academicYearId))).getSingle();
    final semester = await (database.select(
      database.semesters,
    )..where((row) => row.id.equals(subject.semesterId))).getSingle();
    final periods = await database.getGradingPeriods();
    final period = periods.firstWhere((item) => item.id == gradingPeriodId);
    final school = await database.getSchoolSetting();
    final section = subject.sectionId == null
        ? null
        : await (database.select(database.sections)
                ..where((row) => row.id.equals(subject.sectionId!)))
              .getSingleOrNull();
    final instructor = subject.instructorId == null
        ? null
        : await (database.select(database.instructors)
                ..where((row) => row.id.equals(subject.instructorId!)))
              .getSingleOrNull();
    final students = await database.getEnrolledStudents(subjectId);
    final studentById = {for (final student in students) student.id: student};
    final assessments = await database.getAssessments(
      subjectId: subjectId,
      gradingPeriodId: gradingPeriodId,
    );
    final scoresByAssessment = <int, Map<int, double?>>{};
    for (final assessment in assessments) {
      scoresByAssessment[assessment.id] = {
        for (final score in await database.getAssessmentScores(assessment.id))
          score.studentId: score.score,
      };
    }
    final grades = await database.getTermGrades(
      subjectId: subjectId,
      gradingPeriodId: gradingPeriodId,
    );
    final gradesByStudent = {
      for (final grade in grades) grade.studentId: grade,
    };

    final metadata = [
      if (school?.schoolName.isNotEmpty == true) school!.schoolName,
      'Academic Year: ${year.name}',
      'Semester: ${semester.name}',
      'Subject: ${subject.code} - ${subject.name}',
      if (section != null) 'Section: ${section.name}',
      if (instructor != null)
        'Instructor: ${instructor.firstName} ${instructor.lastName}',
      'Grading Period: ${period.name}',
      'Report Date: ${DateTime.now().toIso8601String().substring(0, 10)}',
    ];

    switch (type) {
      case ReportType.gradeSheetPeriod:
      case ReportType.gradeSheet:
        final headers = [
          'Student Number',
          'Student Name',
          ...assessments.map((assessment) => assessment.name),
          'Term Grade',
        ];
        final rows = students.map((student) {
          return [
            student.studentNumber,
            _studentName(student),
            ...assessments.map((assessment) {
              final score = scoresByAssessment[assessment.id]?[student.id];
              return score?.toString() ?? '';
            }),
            _gradeString(gradesByStudent[student.id]?.grade),
          ];
        }).toList();
        return ReportDocumentData(
          title: type.label,
          metadata: metadata,
          headers: headers,
          rows: rows,
          landscape: true,
        );

      case ReportType.attendance:
        final sessions = await database.getAttendanceSessions(
          subjectId: subjectId,
          gradingPeriodId: gradingPeriodId,
        );
        final attendanceBySession = <int, Map<int, String>>{};
        for (final session in sessions) {
          attendanceBySession[session.id] = {
            for (final attendance in await database.getStudentAttendance(
              session.id,
            ))
              attendance.studentId: attendance.code,
          };
        }
        return ReportDocumentData(
          title: type.label,
          metadata: metadata,
          headers: [
            'Student Number',
            'Student Name',
            ...sessions.map((session) => session.sessionDate),
            'Present',
            'Late',
            'Absent',
            'Excused',
          ],
          rows: students.map((student) {
            final codes = sessions
                .map(
                  (session) =>
                      attendanceBySession[session.id]?[student.id] ?? '',
                )
                .toList();
            return [
              student.studentNumber,
              _studentName(student),
              ...codes,
              codes.where((code) => code == 'P').length.toString(),
              codes.where((code) => code == 'L').length.toString(),
              codes.where((code) => code == 'A').length.toString(),
              codes.where((code) => code == 'E').length.toString(),
            ];
          }).toList(),
          landscape: true,
        );

      case ReportType.studentProfile:
        return ReportDocumentData(
          title: type.label,
          metadata: metadata,
          headers: const [
            'Student Number',
            'Student Name',
            'Gender',
            'Email',
            'Contact Number',
            'Course',
            'Year',
            'Status',
          ],
          rows: students
              .map(
                (student) => [
                  student.studentNumber,
                  _studentName(student),
                  student.gender ?? '',
                  student.email ?? '',
                  student.contactNumber ?? '',
                  student.course,
                  student.yearLevel?.toString() ?? '',
                  student.status,
                ],
              )
              .toList(),
          landscape: true,
        );

      case ReportType.quiz:
        final quizzes = assessments
            .where(
              (assessment) => assessment.type.toLowerCase().contains('quiz'),
            )
            .toList();
        return ReportDocumentData(
          title: type.label,
          metadata: metadata,
          headers: [
            'Student Number',
            'Student Name',
            ...quizzes.map(
              (quiz) => '${quiz.name} / ${quiz.totalPossibleScore}',
            ),
          ],
          rows: students
              .map(
                (student) => [
                  student.studentNumber,
                  _studentName(student),
                  ...quizzes.map(
                    (quiz) =>
                        scoresByAssessment[quiz.id]?[student.id]?.toString() ??
                        '',
                  ),
                ],
              )
              .toList(),
          landscape: true,
        );

      case ReportType.incomplete:
        final headers = ['Student Number', 'Student Name', 'Missing Items'];
        final rows = <List<String>>[];
        for (final student in students) {
          final missing = <String>[];
          for (final assessment in assessments) {
            if (scoresByAssessment[assessment.id]?[student.id] == null) {
              missing.add(assessment.name);
            }
          }
          if (missing.isNotEmpty) {
            rows.add([
              student.studentNumber,
              _studentName(student),
              missing.join(', '),
            ]);
          }
        }
        return ReportDocumentData(
          title: type.label,
          metadata: metadata,
          headers: headers,
          rows: rows,
          landscape: false,
        );

      case ReportType.studentSummary:
        final allGrades = <int, Map<String, double?>>{};
        for (final gradingPeriod in periods) {
          final periodGrades = await database.getTermGrades(
            subjectId: subjectId,
            gradingPeriodId: gradingPeriod.id,
          );
          for (final grade in periodGrades) {
            allGrades.putIfAbsent(
              grade.studentId,
              () => {},
            )[gradingPeriod.name] = grade.grade;
          }
        }
        return ReportDocumentData(
          title: type.label,
          metadata: metadata,
          headers: [
            'Student Number',
            'Student Name',
            ...periods.map((item) => item.name),
          ],
          rows: students
              .map(
                (student) => [
                  student.studentNumber,
                  _studentName(student),
                  ...periods.map(
                    (item) => _gradeString(allGrades[student.id]?[item.name]),
                  ),
                ],
              )
              .toList(),
          landscape: true,
        );

      case ReportType.ranking:
        final rankings = await database.getRankings(
          subjectId: subjectId,
          gradingPeriodId: gradingPeriodId,
        );
        return ReportDocumentData(
          title: type.label,
          metadata: metadata,
          headers: const ['Rank', 'Student Number', 'Student Name', 'Grade'],
          rows: rankings.map((ranking) {
            final student = studentById[ranking.studentId];
            return [
              ranking.rank.toString(),
              student?.studentNumber ?? '',
              student == null ? '' : _studentName(student),
              ranking.grade.toStringAsFixed(2),
            ];
          }).toList(),
          landscape: false,
        );
    }
  }

  String _studentName(Student student) {
    final givenName = [
      student.firstName,
      student.middleName,
    ].where((part) => part.isNotEmpty).join(' ');
    final suffix = student.suffix.isEmpty ? '' : ' ${student.suffix}';
    return '${student.lastName}, $givenName$suffix';
  }

  String _gradeString(double? grade) =>
      grade == null ? '' : grade.toStringAsFixed(2);
}
