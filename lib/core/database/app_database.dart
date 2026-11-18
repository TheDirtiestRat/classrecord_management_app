import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    SchoolSettings,
    AcademicYears,
    Semesters,
    GradingPeriods,
    Instructors,
    Sections,
    Subjects,
    Students,
    SubjectEnrollments,
    Assessments,
    StudentAssessmentScores,
    AttendanceSessions,
    StudentAttendance,
    IndependentLearningRecords,
    StudentIndependentLearningScores,
    GradingConfigurations,
    TermGrades,
    GradeRankings,
    ApplicationSettings,
    ActivityLogs,
  ],
)
class AppDatabase extends _$AppDatabase {
  bool _isClosed = false;

  AppDatabase(super.e);

  factory AppDatabase.openFile(String path) {
    return AppDatabase(NativeDatabase.createInBackground(File(path)));
  }

  @override
  Future<void> close() async {
    if (_isClosed) return;
    _isClosed = true;
    await super.close();
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator migrator) async {
        await migrator.createAll();
        await transaction(() async {
          await batch((batch) {
            batch.insertAll(gradingPeriods, [
              GradingPeriodsCompanion.insert(name: 'Prelim', sortOrder: 1),
              GradingPeriodsCompanion.insert(name: 'Midterm', sortOrder: 2),
              GradingPeriodsCompanion.insert(name: 'Prefinal', sortOrder: 3),
              GradingPeriodsCompanion.insert(name: 'Final', sortOrder: 4),
            ]);
          });
        });
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
        await customStatement('PRAGMA busy_timeout = 5000');
      },
    );
  }

  Future<List<AcademicYear>> getAllAcademicYears() =>
      (select(academicYears)..orderBy([
            (row) =>
                OrderingTerm(expression: row.name, mode: OrderingMode.desc),
          ]))
          .get();

  Future<int> createAcademicYear(String name, {bool isActive = false}) {
    return transaction(() async {
      if (isActive) {
        await update(academicYears)
            .write(const AcademicYearsCompanion(isActive: Value(false)));
      }
      return into(academicYears).insert(
        AcademicYearsCompanion.insert(
          name: name,
          isActive: Value(isActive),
          createdAt: DateTime.now().toIso8601String(),
        ),
      );
    });
  }

  Future<bool> updateAcademicYear(int id, String name, bool isActive) async {
    final count =
        await (update(academicYears)..where((row) => row.id.equals(id))).write(
          AcademicYearsCompanion(name: Value(name), isActive: Value(isActive)),
        );
    if (isActive) {
      await (update(academicYears)..where((row) => row.id.equals(id).not()))
          .write(const AcademicYearsCompanion(isActive: Value(false)));
    }
    return count == 1;
  }

  Future<int> deleteAcademicYear(int id) =>
      (delete(academicYears)..where((row) => row.id.equals(id))).go();

  Future<List<Subject>> getAllSubjects() => (select(
    subjects,
  )..orderBy([(row) => OrderingTerm(expression: row.code)])).get();

  Future<List<Semester>> getSemesters(int academicYearId) =>
      (select(semesters)
            ..where((row) => row.academicYearId.equals(academicYearId))
            ..orderBy([(row) => OrderingTerm(expression: row.name)]))
          .get();

  Future<int> createSemester({
    required int academicYearId,
    required String name,
    bool isActive = false,
  }) {
    return transaction(() async {
      if (isActive) {
        await (update(semesters)
              ..where((row) => row.academicYearId.equals(academicYearId)))
            .write(const SemestersCompanion(isActive: Value(false)));
      }
      return into(semesters).insert(
        SemestersCompanion.insert(
          academicYearId: academicYearId,
          name: name,
          isActive: Value(isActive),
          createdAt: DateTime.now().toIso8601String(),
        ),
      );
    });
  }

  Future<bool> updateSemester({
    required int id,
    required int academicYearId,
    required String name,
    bool isActive = false,
  }) async {
    final count = await (update(semesters)..where((row) => row.id.equals(id)))
        .write(
          SemestersCompanion(
            academicYearId: Value(academicYearId),
            name: Value(name),
            isActive: Value(isActive),
          ),
        );
    if (isActive) {
      await (update(semesters)..where(
            (row) =>
                row.academicYearId.equals(academicYearId) &
                row.id.equals(id).not(),
          ))
          .write(const SemestersCompanion(isActive: Value(false)));
    }
    return count == 1;
  }

  Future<int> deleteSemester(int id) =>
      (delete(semesters)..where((row) => row.id.equals(id))).go();

  Future<SchoolSetting?> getSchoolSetting() async {
    final rows = await (select(schoolSettings)..limit(1)).get();
    return rows.isEmpty ? null : rows.first;
  }

  Future<int> saveSchoolSetting({
    required String schoolName,
    required String address,
  }) async {
    final existing = await getSchoolSetting();
    if (existing == null) {
      return into(schoolSettings).insert(
        SchoolSettingsCompanion.insert(
          schoolName: Value(schoolName),
          address: Value(address),
        ),
      );
    }
    await (update(
      schoolSettings,
    )..where((row) => row.id.equals(existing.id))).write(
      SchoolSettingsCompanion(
        schoolName: Value(schoolName),
        address: Value(address),
      ),
    );
    return existing.id;
  }

  Future<List<Instructor>> getAllInstructors() =>
      (select(instructors)
            ..where((row) => row.isActive.equals(true))
            ..orderBy([(row) => OrderingTerm(expression: row.lastName)]))
          .get();

  Future<int> createInstructor({
    required String firstName,
    required String lastName,
    String middleName = '',
    String suffix = '',
    String? employeeNumber,
    String? email,
    String? contactNumber,
  }) {
    return into(instructors).insert(
      InstructorsCompanion.insert(
        employeeNumber: Value(employeeNumber),
        firstName: firstName,
        middleName: Value(middleName),
        lastName: lastName,
        suffix: Value(suffix),
        email: Value(email),
        contactNumber: Value(contactNumber),
      ),
    );
  }

  Future<bool> updateInstructor({
    required int id,
    required String firstName,
    required String lastName,
    String middleName = '',
    String suffix = '',
    String? employeeNumber,
    String? email,
    String? contactNumber,
  }) async {
    final count = await (update(instructors)..where((row) => row.id.equals(id)))
        .write(
          InstructorsCompanion(
            employeeNumber: Value(employeeNumber),
            firstName: Value(firstName),
            middleName: Value(middleName),
            lastName: Value(lastName),
            suffix: Value(suffix),
            email: Value(email),
            contactNumber: Value(contactNumber),
          ),
        );
    return count == 1;
  }

  Future<int> deleteInstructor(int id) =>
      (delete(instructors)..where((row) => row.id.equals(id))).go();

  Future<List<Section>> getAllSections() => (select(
    sections,
  )..orderBy([(row) => OrderingTerm(expression: row.name)])).get();

  Future<int> createSection({
    required String name,
    String course = '',
    int? yearLevel,
  }) {
    return into(sections).insert(
      SectionsCompanion.insert(
        name: name,
        course: Value(course),
        yearLevel: Value(yearLevel),
      ),
    );
  }

  Future<bool> updateSection({
    required int id,
    required String name,
    String course = '',
    int? yearLevel,
  }) async {
    final count = await (update(sections)..where((row) => row.id.equals(id)))
        .write(
          SectionsCompanion(
            name: Value(name),
            course: Value(course),
            yearLevel: Value(yearLevel),
          ),
        );
    return count == 1;
  }

  Future<int> deleteSection(int id) =>
      (delete(sections)..where((row) => row.id.equals(id))).go();

  Future<int> createSubject({
    required String code,
    required String name,
    String description = '',
    required int academicYearId,
    required int semesterId,
    int? sectionId,
    int? instructorId,
    double units = 3,
    String status = 'Active',
  }) {
    final now = DateTime.now().toIso8601String();
    return into(subjects).insert(
      SubjectsCompanion.insert(
        code: code,
        name: name,
        description: Value(description),
        academicYearId: academicYearId,
        semesterId: semesterId,
        sectionId: Value(sectionId),
        instructorId: Value(instructorId),
        units: Value(units),
        status: Value(status),
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  Future<bool> updateSubject({
    required int id,
    required String code,
    required String name,
    String description = '',
    required int academicYearId,
    required int semesterId,
    int? sectionId,
    int? instructorId,
    double units = 3,
    String status = 'Active',
  }) async {
    final count = await (update(subjects)..where((row) => row.id.equals(id)))
        .write(
          SubjectsCompanion(
            code: Value(code),
            name: Value(name),
            description: Value(description),
            academicYearId: Value(academicYearId),
            semesterId: Value(semesterId),
            sectionId: Value(sectionId),
            instructorId: Value(instructorId),
            units: Value(units),
            status: Value(status),
            updatedAt: Value(DateTime.now().toIso8601String()),
          ),
        );
    return count == 1;
  }

  Future<int> deleteSubject(int id) =>
      (delete(subjects)..where((row) => row.id.equals(id))).go();

  Future<List<Student>> getAllStudents() =>
      (select(students)..orderBy([
            (row) => OrderingTerm(expression: row.lastName),
            (row) => OrderingTerm(expression: row.firstName),
          ]))
          .get();

  Future<DatabasePage<Student>> getStudentsPage({
    required int limit,
    required int offset,
    String search = '',
    String? course,
    String? status,
    int? yearLevel,
  }) async {
    final filter = _studentFilter(
      search: search,
      course: course,
      status: status,
      yearLevel: yearLevel,
    );
    final countExpression = students.id.count();
    final totalRecords =
        await (selectOnly(students)
              ..addColumns([countExpression])
              ..where(filter))
            .map((row) => row.read(countExpression) ?? 0)
            .getSingle();
    final records =
        await (select(students)
              ..where((row) => filter)
              ..orderBy([
                (row) => OrderingTerm(expression: row.lastName),
                (row) => OrderingTerm(expression: row.firstName),
                (row) => OrderingTerm(expression: row.studentNumber),
              ])
              ..limit(limit, offset: offset))
            .get();
    return DatabasePage(records: records, totalRecords: totalRecords);
  }

  Future<List<int>> getStudentIds({
    String search = '',
    String? course,
    String? status,
    int? yearLevel,
  }) async {
    final filter = _studentFilter(
      search: search,
      course: course,
      status: status,
      yearLevel: yearLevel,
    );
    final rows =
        await (selectOnly(students)
              ..addColumns([students.id])
              ..where(filter))
            .get();
    return rows.map((row) => row.read(students.id)).whereType<int>().toList();
  }

  Future<List<String>> getStudentCourses() async {
    final rows =
        await (selectOnly(students)
              ..addColumns([students.course])
              ..groupBy([students.course])
              ..orderBy([OrderingTerm(expression: students.course)]))
            .get();
    return rows
        .map((row) => row.read(students.course))
        .whereType<String>()
        .where((course) => course.isNotEmpty)
        .toList();
  }

  Expression<bool> _studentFilter({
    required String search,
    String? course,
    String? status,
    int? yearLevel,
  }) {
    Expression<bool> filter = const Constant(true);
    final normalizedSearch = search.trim();
    if (normalizedSearch.isNotEmpty) {
      final pattern = '%$normalizedSearch%';
      filter =
          filter &
          (students.studentNumber.like(pattern) |
              students.firstName.like(pattern) |
              students.middleName.like(pattern) |
              students.lastName.like(pattern) |
              students.suffix.like(pattern));
    }
    if (course != null) filter = filter & students.course.equals(course);
    if (status != null) filter = filter & students.status.equals(status);
    if (yearLevel != null) {
      filter = filter & students.yearLevel.equals(yearLevel);
    }
    return filter;
  }

  Future<int> createStudent({
    required String studentNumber,
    required String firstName,
    String middleName = '',
    required String lastName,
    String suffix = '',
    String? gender,
    String? email,
    String? contactNumber,
    String course = '',
    int? yearLevel,
    int? sectionId,
    String status = 'Active',
  }) {
    final now = DateTime.now().toIso8601String();
    return into(students).insert(
      StudentsCompanion.insert(
        studentNumber: studentNumber,
        firstName: firstName,
        middleName: Value(middleName),
        lastName: lastName,
        suffix: Value(suffix),
        gender: Value(gender),
        email: Value(email),
        contactNumber: Value(contactNumber),
        course: Value(course),
        yearLevel: Value(yearLevel),
        sectionId: Value(sectionId),
        status: Value(status),
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  Future<bool> updateStudent({
    required int id,
    required String studentNumber,
    required String firstName,
    String middleName = '',
    required String lastName,
    String suffix = '',
    String? gender,
    String? email,
    String? contactNumber,
    String course = '',
    int? yearLevel,
    int? sectionId,
    String status = 'Active',
  }) async {
    final count = await (update(students)..where((row) => row.id.equals(id)))
        .write(
          StudentsCompanion(
            studentNumber: Value(studentNumber),
            firstName: Value(firstName),
            middleName: Value(middleName),
            lastName: Value(lastName),
            suffix: Value(suffix),
            gender: Value(gender),
            email: Value(email),
            contactNumber: Value(contactNumber),
            course: Value(course),
            yearLevel: Value(yearLevel),
            sectionId: Value(sectionId),
            status: Value(status),
            updatedAt: Value(DateTime.now().toIso8601String()),
          ),
        );
    return count == 1;
  }

  Future<int> updateStudentsBatch({
    required List<int> studentIds,
    bool updateCourse = false,
    String course = '',
    bool updateYearLevel = false,
    int? yearLevel,
    bool updateSection = false,
    int? sectionId,
    bool updateStatus = false,
    String status = 'Active',
    List<int> subjectIdsToAdd = const [],
  }) async {
    final uniqueStudentIds = studentIds.toSet().toList();
    final uniqueSubjectIds = subjectIdsToAdd.toSet().toList();
    if (uniqueStudentIds.isEmpty) {
      return 0;
    }

    final updateStudentFields =
        updateCourse || updateYearLevel || updateSection || updateStatus;
    if (!updateStudentFields && uniqueSubjectIds.isEmpty) {
      return 0;
    }

    return transaction(() async {
      var updatedCount = uniqueStudentIds.length;
      if (updateStudentFields) {
        updatedCount =
            await (update(
              students,
            )..where((row) => row.id.isIn(uniqueStudentIds))).write(
              StudentsCompanion(
                course: updateCourse ? Value(course) : const Value.absent(),
                yearLevel: updateYearLevel
                    ? Value(yearLevel)
                    : const Value.absent(),
                sectionId: updateSection
                    ? Value(sectionId)
                    : const Value.absent(),
                status: updateStatus ? Value(status) : const Value.absent(),
                updatedAt: Value(DateTime.now().toIso8601String()),
              ),
            );
      }

      for (final studentId in uniqueStudentIds) {
        for (final subjectId in uniqueSubjectIds) {
          await enrollStudent(subjectId: subjectId, studentId: studentId);
        }
      }

      return updatedCount;
    });
  }

  Future<int> deleteStudent(int id) =>
      (delete(students)..where((row) => row.id.equals(id))).go();

  Future<int> findOrCreateStudentFromCsv({
    required String studentNumber,
    required String firstName,
    String middleName = '',
    required String lastName,
    String suffix = '',
    String course = '',
    int? yearLevel,
  }) async {
    final existing =
        await (select(students)
              ..where((row) => row.studentNumber.equals(studentNumber))
              ..limit(1))
            .get();
    if (existing.isNotEmpty) {
      return existing.first.id;
    }
    return createStudent(
      studentNumber: studentNumber,
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      suffix: suffix,
      course: course,
      yearLevel: yearLevel,
    );
  }

  Future<int> enrollStudent({
    required int subjectId,
    required int studentId,
  }) async {
    final existing =
        await (select(subjectEnrollments)
              ..where(
                (row) =>
                    row.subjectId.equals(subjectId) &
                    row.studentId.equals(studentId),
              )
              ..limit(1))
            .get();
    if (existing.isNotEmpty) {
      return existing.first.id;
    }
    return into(subjectEnrollments).insert(
      SubjectEnrollmentsCompanion.insert(
        subjectId: subjectId,
        studentId: studentId,
        enrolledAt: DateTime.now().toIso8601String(),
      ),
    );
  }

  Future<int> unenrollStudent({
    required int subjectId,
    required int studentId,
  }) =>
      (delete(subjectEnrollments)..where(
            (row) =>
                row.subjectId.equals(subjectId) &
                row.studentId.equals(studentId),
          ))
          .go();

  Future<List<Student>> getEnrolledStudents(int subjectId) async {
    final query = select(students).join([
      innerJoin(
        subjectEnrollments,
        subjectEnrollments.studentId.equalsExp(students.id),
      ),
    ]);
    query
      ..where(subjectEnrollments.subjectId.equals(subjectId))
      ..orderBy([OrderingTerm(expression: students.lastName)]);
    final rows = await query.get();
    return rows.map((row) => row.readTable(students)).toList();
  }

  Future<DatabasePage<Student>> getEnrolledStudentsPage({
    required int subjectId,
    required int limit,
    required int offset,
  }) async {
    final countExpression = subjectEnrollments.id.count();
    final totalRecords =
        await (selectOnly(subjectEnrollments)
              ..addColumns([countExpression])
              ..where(subjectEnrollments.subjectId.equals(subjectId)))
            .map((row) => row.read(countExpression) ?? 0)
            .getSingle();
    final query = select(students).join([
      innerJoin(
        subjectEnrollments,
        subjectEnrollments.studentId.equalsExp(students.id),
      ),
    ]);
    query
      ..where(subjectEnrollments.subjectId.equals(subjectId))
      ..orderBy([
        OrderingTerm(expression: students.lastName),
        OrderingTerm(expression: students.firstName),
        OrderingTerm(expression: students.studentNumber),
      ])
      ..limit(limit, offset: offset);
    final rows = await query.get();
    return DatabasePage(
      records: rows.map((row) => row.readTable(students)).toList(),
      totalRecords: totalRecords,
    );
  }

  Future<List<GradingPeriod>> getGradingPeriods() => (select(
    gradingPeriods,
  )..orderBy([(row) => OrderingTerm(expression: row.sortOrder)])).get();

  Future<List<Assessment>> getAssessments({
    required int subjectId,
    required int gradingPeriodId,
  }) =>
      (select(assessments)
            ..where(
              (row) =>
                  row.subjectId.equals(subjectId) &
                  row.gradingPeriodId.equals(gradingPeriodId),
            )
            ..orderBy([
              (row) => OrderingTerm(expression: row.sortOrder),
              (row) => OrderingTerm(expression: row.id),
            ]))
          .get();

  Future<int> createAssessment({
    required int subjectId,
    required int gradingPeriodId,
    required String name,
    required String type,
    String? date,
    required double totalPossibleScore,
  }) {
    return into(assessments).insert(
      AssessmentsCompanion.insert(
        subjectId: subjectId,
        gradingPeriodId: gradingPeriodId,
        name: name,
        type: type,
        date: Value(date),
        totalPossibleScore: totalPossibleScore,
        createdAt: DateTime.now().toIso8601String(),
      ),
    );
  }

  Future<bool> updateAssessment({
    required int id,
    required String name,
    required String type,
    String? date,
    required double totalPossibleScore,
  }) async {
    return transaction(() async {
      final existing = await (select(
        assessments,
      )..where((row) => row.id.equals(id))).get();
      if (existing.isEmpty) return false;

      final scores = await getAssessmentScores(id);
      final scoresAboveMaximum = scores
          .where(
            (studentScore) =>
                studentScore.score != null &&
                studentScore.score! > totalPossibleScore,
          )
          .length;
      if (scoresAboveMaximum > 0) {
        throw StateError(
          'The new maximum is below $scoresAboveMaximum recorded student '
          'score(s).',
        );
      }

      final count =
          await (update(assessments)..where((row) => row.id.equals(id))).write(
            AssessmentsCompanion(
              name: Value(name),
              type: Value(type),
              date: Value(date),
              totalPossibleScore: Value(totalPossibleScore),
            ),
          );
      return count == 1;
    });
  }

  Future<int> deleteAssessment(int id) =>
      (delete(assessments)..where((row) => row.id.equals(id))).go();

  Future<List<StudentAssessmentScore>> getAssessmentScores(int assessmentId) =>
      (select(
        studentAssessmentScores,
      )..where((row) => row.assessmentId.equals(assessmentId))).get();

  Future<List<StudentAssessmentScore>> getAssessmentScoresForAssessments(
    Iterable<int> assessmentIds,
  ) {
    final ids = assessmentIds.toList();
    if (ids.isEmpty) return Future.value(const []);
    return (select(
      studentAssessmentScores,
    )..where((row) => row.assessmentId.isIn(ids))).get();
  }

  Future<void> saveAssessmentScore({
    required int assessmentId,
    required int studentId,
    required double? score,
  }) async {
    await transaction(() async {
      final assessment = await (select(
        assessments,
      )..where((row) => row.id.equals(assessmentId))).get();
      if (assessment.isEmpty) {
        throw StateError('Assessment $assessmentId does not exist.');
      }
      final enrollment =
          await (select(subjectEnrollments)
                ..where(
                  (row) =>
                      row.subjectId.equals(assessment.first.subjectId) &
                      row.studentId.equals(studentId),
                )
                ..limit(1))
              .get();
      if (enrollment.isEmpty) {
        throw StateError(
          'Student $studentId is not enrolled in the assessment subject.',
        );
      }
      if (score != null &&
          (!score.isFinite ||
              score < 0 ||
              score > assessment.first.totalPossibleScore)) {
        throw ArgumentError.value(
          score,
          'score',
          'Must be between zero and the assessment maximum.',
        );
      }

      final existing =
          await (select(studentAssessmentScores)
                ..where(
                  (row) =>
                      row.assessmentId.equals(assessmentId) &
                      row.studentId.equals(studentId),
                )
                ..limit(1))
              .get();
      if (existing.isNotEmpty && existing.first.score == score) return;

      final now = DateTime.now().toIso8601String();
      if (existing.isEmpty) {
        await into(studentAssessmentScores).insert(
          StudentAssessmentScoresCompanion.insert(
            assessmentId: assessmentId,
            studentId: studentId,
            score: Value(score),
            updatedAt: Value(now),
          ),
        );
      } else {
        await (update(
          studentAssessmentScores,
        )..where((row) => row.id.equals(existing.first.id))).write(
          StudentAssessmentScoresCompanion(
            score: Value(score),
            updatedAt: Value(now),
          ),
        );
      }
    });
  }

  Future<List<AttendanceSession>> getAttendanceSessions({
    required int subjectId,
    required int gradingPeriodId,
  }) =>
      (select(attendanceSessions)
            ..where(
              (row) =>
                  row.subjectId.equals(subjectId) &
                  row.gradingPeriodId.equals(gradingPeriodId),
            )
            ..orderBy([
              (row) => OrderingTerm(expression: row.sortOrder),
              (row) => OrderingTerm(expression: row.id),
            ]))
          .get();

  Future<int> createAttendanceSession({
    required int subjectId,
    required int gradingPeriodId,
    required String sessionDate,
    String name = 'Attendance',
  }) {
    return into(attendanceSessions).insert(
      AttendanceSessionsCompanion.insert(
        subjectId: subjectId,
        gradingPeriodId: gradingPeriodId,
        sessionDate: sessionDate,
        name: Value(name),
      ),
    );
  }

  Future<int> getOrCreateAttendanceSession({
    required int subjectId,
    required int gradingPeriodId,
    required String sessionDate,
    String name = 'Attendance',
  }) {
    return transaction(() async {
      final existing =
          await (select(attendanceSessions)
                ..where(
                  (row) =>
                      row.subjectId.equals(subjectId) &
                      row.gradingPeriodId.equals(gradingPeriodId) &
                      row.sessionDate.equals(sessionDate),
                )
                ..orderBy([
                  (row) => OrderingTerm(expression: row.sortOrder),
                  (row) => OrderingTerm(expression: row.id),
                ])
                ..limit(1))
              .get();
      if (existing.isNotEmpty) return existing.first.id;

      return into(attendanceSessions).insert(
        AttendanceSessionsCompanion.insert(
          subjectId: subjectId,
          gradingPeriodId: gradingPeriodId,
          sessionDate: sessionDate,
          name: Value(name),
        ),
      );
    });
  }

  Future<int> deleteAttendanceSession(int id) =>
      (delete(attendanceSessions)..where((row) => row.id.equals(id))).go();

  Future<void> saveAttendanceCode({
    required int attendanceSessionId,
    required int studentId,
    required String code,
  }) async {
    await transaction(() async {
      final session = await (select(
        attendanceSessions,
      )..where((row) => row.id.equals(attendanceSessionId))).get();
      if (session.isEmpty) {
        throw StateError(
          'Attendance session $attendanceSessionId does not exist.',
        );
      }
      final enrollment =
          await (select(subjectEnrollments)
                ..where(
                  (row) =>
                      row.subjectId.equals(session.first.subjectId) &
                      row.studentId.equals(studentId),
                )
                ..limit(1))
              .get();
      if (enrollment.isEmpty) {
        throw StateError(
          'Student $studentId is not enrolled in the attendance subject.',
        );
      }
      if (!const {'P', 'L', 'A', 'E'}.contains(code)) {
        throw ArgumentError.value(code, 'code', 'Unsupported attendance code.');
      }

      final existing =
          await (select(studentAttendance)
                ..where(
                  (row) =>
                      row.attendanceSessionId.equals(attendanceSessionId) &
                      row.studentId.equals(studentId),
                )
                ..limit(1))
              .get();
      if (existing.isNotEmpty && existing.first.code == code) return;

      final now = DateTime.now().toIso8601String();
      if (existing.isEmpty) {
        await into(studentAttendance).insert(
          StudentAttendanceCompanion.insert(
            attendanceSessionId: attendanceSessionId,
            studentId: studentId,
            code: code,
            updatedAt: Value(now),
          ),
        );
      } else {
        await (update(
          studentAttendance,
        )..where((row) => row.id.equals(existing.first.id))).write(
          StudentAttendanceCompanion(code: Value(code), updatedAt: Value(now)),
        );
      }
    });
  }

  Future<List<StudentAttendanceData>> getStudentAttendance(
    int attendanceSessionId,
  ) => (select(
    studentAttendance,
  )..where((row) => row.attendanceSessionId.equals(attendanceSessionId))).get();

  Future<List<StudentAttendanceData>> getStudentAttendanceForStudents({
    required int attendanceSessionId,
    required Iterable<int> studentIds,
  }) {
    final ids = studentIds.toList();
    if (ids.isEmpty) return Future.value(const []);
    return (select(studentAttendance)..where(
          (row) =>
              row.attendanceSessionId.equals(attendanceSessionId) &
              row.studentId.isIn(ids),
        ))
        .get();
  }

  Future<Map<String, int>> getAttendanceCodeCounts(
    int attendanceSessionId,
  ) async {
    final countExpression = studentAttendance.id.count();
    final rows =
        await (selectOnly(studentAttendance)
              ..addColumns([studentAttendance.code, countExpression])
              ..where(
                studentAttendance.attendanceSessionId.equals(
                  attendanceSessionId,
                ),
              )
              ..groupBy([studentAttendance.code]))
            .get();
    final counts = <String, int>{};
    for (final row in rows) {
      final code = row.read(studentAttendance.code);
      if (code != null) {
        counts[code] = row.read(countExpression) ?? 0;
      }
    }
    return counts;
  }

  Future<List<StudentAttendanceData>> getStudentAttendanceForSessions(
    Iterable<int> attendanceSessionIds,
  ) {
    final ids = attendanceSessionIds.toList();
    if (ids.isEmpty) return Future.value(const []);
    return (select(
      studentAttendance,
    )..where((row) => row.attendanceSessionId.isIn(ids))).get();
  }

  Future<List<IndependentLearningRecord>> getIndependentLearningRecords({
    required int subjectId,
    required int gradingPeriodId,
  }) =>
      (select(independentLearningRecords)
            ..where(
              (row) =>
                  row.subjectId.equals(subjectId) &
                  row.gradingPeriodId.equals(gradingPeriodId),
            )
            ..orderBy([(row) => OrderingTerm(expression: row.id)]))
          .get();

  Future<int> createIndependentLearningRecord({
    required int subjectId,
    required int gradingPeriodId,
    required String activityName,
    String description = '',
    String? activityDate,
    required double totalPossibleScore,
  }) {
    return into(independentLearningRecords).insert(
      IndependentLearningRecordsCompanion.insert(
        subjectId: subjectId,
        gradingPeriodId: gradingPeriodId,
        activityName: activityName,
        description: Value(description),
        activityDate: Value(activityDate),
        totalPossibleScore: totalPossibleScore,
        createdAt: DateTime.now().toIso8601String(),
      ),
    );
  }

  Future<void> saveIndependentLearningScore({
    required int recordId,
    required int studentId,
    required double? score,
    String remarks = '',
  }) async {
    await transaction(() async {
      final record = await (select(
        independentLearningRecords,
      )..where((row) => row.id.equals(recordId))).get();
      if (record.isEmpty) {
        throw StateError(
          'Independent learning record $recordId does not exist.',
        );
      }
      final enrollment =
          await (select(subjectEnrollments)
                ..where(
                  (row) =>
                      row.subjectId.equals(record.first.subjectId) &
                      row.studentId.equals(studentId),
                )
                ..limit(1))
              .get();
      if (enrollment.isEmpty) {
        throw StateError(
          'Student $studentId is not enrolled in the activity subject.',
        );
      }
      if (score != null &&
          (!score.isFinite ||
              score < 0 ||
              score > record.first.totalPossibleScore)) {
        throw ArgumentError.value(
          score,
          'score',
          'Must be between zero and the activity maximum.',
        );
      }

      final existing =
          await (select(studentIndependentLearningScores)
                ..where(
                  (row) =>
                      row.recordId.equals(recordId) &
                      row.studentId.equals(studentId),
                )
                ..limit(1))
              .get();
      if (existing.isNotEmpty &&
          existing.first.score == score &&
          existing.first.remarks == remarks) {
        return;
      }

      final now = DateTime.now().toIso8601String();
      if (existing.isEmpty) {
        await into(studentIndependentLearningScores).insert(
          StudentIndependentLearningScoresCompanion.insert(
            recordId: recordId,
            studentId: studentId,
            score: Value(score),
            remarks: Value(remarks),
            updatedAt: Value(now),
          ),
        );
      } else {
        await (update(
          studentIndependentLearningScores,
        )..where((row) => row.id.equals(existing.first.id))).write(
          StudentIndependentLearningScoresCompanion(
            score: Value(score),
            remarks: Value(remarks),
            updatedAt: Value(now),
          ),
        );
      }
    });
  }

  Future<List<StudentIndependentLearningScore>> getIndependentLearningScores(
    int recordId,
  ) => (select(
    studentIndependentLearningScores,
  )..where((row) => row.recordId.equals(recordId))).get();

  Future<List<StudentIndependentLearningScore>>
  getIndependentLearningScoresForRecords(Iterable<int> recordIds) {
    final ids = recordIds.toList();
    if (ids.isEmpty) return Future.value(const []);
    return (select(
      studentIndependentLearningScores,
    )..where((row) => row.recordId.isIn(ids))).get();
  }

  Future<int> createActivityLog({
    required String activity,
    String details = '',
    String? entityType,
    int? entityId,
  }) {
    return into(activityLogs).insert(
      ActivityLogsCompanion.insert(
        activity: activity,
        details: Value(details),
        entityType: Value(entityType),
        entityId: Value(entityId),
        createdAt: DateTime.now().toIso8601String(),
      ),
    );
  }

  Future<List<ActivityLog>> getRecentActivity({int limit = 20}) =>
      (select(activityLogs)
            ..orderBy([
              (row) => OrderingTerm(
                expression: row.createdAt,
                mode: OrderingMode.desc,
              ),
            ])
            ..limit(limit))
          .get();

  Future<GradingConfiguration?> getActiveGradingConfiguration(
    int subjectId,
  ) async {
    final subjectSpecific =
        await (select(gradingConfigurations)
              ..where(
                (row) =>
                    row.subjectId.equals(subjectId) & row.isActive.equals(true),
              )
              ..limit(1))
            .get();
    if (subjectSpecific.isNotEmpty) return subjectSpecific.first;
    final defaults =
        await (select(gradingConfigurations)
              ..where(
                (row) => row.subjectId.isNull() & row.isActive.equals(true),
              )
              ..limit(1))
            .get();
    if (defaults.isNotEmpty) return defaults.first;
    await into(gradingConfigurations).insert(
      GradingConfigurationsCompanion.insert(
        name: 'Default',
        subjectId: const Value.absent(),
        isActive: const Value(true),
      ),
    );
    return (select(gradingConfigurations)
          ..where((row) => row.name.equals('Default') & row.subjectId.isNull())
          ..limit(1))
        .getSingle();
  }

  Future<int> saveGradingConfiguration({
    int? subjectId,
    required double quizWeight,
    required double attendanceWeight,
    required double workWeight,
    required double majorExamWeight,
    required double independentLearningWeight,
    int decimalPlaces = 2,
  }) async {
    final existing =
        await (select(gradingConfigurations)
              ..where(
                subjectId == null
                    ? (row) => row.subjectId.isNull()
                    : (row) => row.subjectId.equals(subjectId),
              )
              ..limit(1))
            .get();
    final values = GradingConfigurationsCompanion(
      quizWeight: Value(quizWeight),
      attendanceWeight: Value(attendanceWeight),
      workWeight: Value(workWeight),
      majorExamWeight: Value(majorExamWeight),
      independentLearningWeight: Value(independentLearningWeight),
      decimalPlaces: Value(decimalPlaces),
      isActive: const Value(true),
    );
    if (existing.isEmpty) {
      return into(gradingConfigurations).insert(
        GradingConfigurationsCompanion.insert(
          subjectId: Value(subjectId),
          name: subjectId == null ? 'Default' : 'Subject $subjectId',
          quizWeight: Value(quizWeight),
          attendanceWeight: Value(attendanceWeight),
          workWeight: Value(workWeight),
          majorExamWeight: Value(majorExamWeight),
          independentLearningWeight: Value(independentLearningWeight),
          decimalPlaces: Value(decimalPlaces),
        ),
      );
    }
    await (update(
      gradingConfigurations,
    )..where((row) => row.id.equals(existing.first.id))).write(values);
    return existing.first.id;
  }

  Future<void> saveTermGrade({
    required int subjectId,
    required int studentId,
    required int gradingPeriodId,
    required double? grade,
  }) async {
    final existing =
        await (select(termGrades)
              ..where(
                (row) =>
                    row.subjectId.equals(subjectId) &
                    row.studentId.equals(studentId) &
                    row.gradingPeriodId.equals(gradingPeriodId),
              )
              ..limit(1))
            .get();
    if (existing.isNotEmpty && existing.first.grade == grade) return;
    final now = DateTime.now().toIso8601String();
    if (existing.isEmpty) {
      await into(termGrades).insertOnConflictUpdate(
        TermGradesCompanion.insert(
          subjectId: subjectId,
          studentId: studentId,
          gradingPeriodId: gradingPeriodId,
          grade: Value(grade),
          calculatedAt: Value(now),
        ),
      );
    } else {
      await (update(
        termGrades,
      )..where((row) => row.id.equals(existing.first.id))).write(
        TermGradesCompanion(grade: Value(grade), calculatedAt: Value(now)),
      );
    }
  }

  Future<List<TermGrade>> getTermGrades({
    required int subjectId,
    required int gradingPeriodId,
  }) =>
      (select(termGrades)..where(
            (row) =>
                row.subjectId.equals(subjectId) &
                row.gradingPeriodId.equals(gradingPeriodId),
          ))
          .get();

  Future<void> replaceRankings({
    required int subjectId,
    required int gradingPeriodId,
    required List<({int studentId, int rank, double grade})> rankings,
  }) async {
    final existing =
        await (select(gradeRankings)..where(
              (row) =>
                  row.subjectId.equals(subjectId) &
                  row.gradingPeriodId.equals(gradingPeriodId),
            ))
            .get();
    final updatedByStudent = {
      for (final ranking in rankings)
        ranking.studentId: (ranking.rank, ranking.grade),
    };
    if (existing.length == rankings.length &&
        existing.every(
          (row) => updatedByStudent[row.studentId] == (row.rank, row.grade),
        )) {
      return;
    }

    await transaction(() async {
      await (delete(gradeRankings)..where(
            (row) =>
                row.subjectId.equals(subjectId) &
                row.gradingPeriodId.equals(gradingPeriodId),
          ))
          .go();
      final now = DateTime.now().toIso8601String();
      await batch((batch) {
        batch.insertAll(
          gradeRankings,
          rankings
              .map(
                (entry) => GradeRankingsCompanion.insert(
                  subjectId: subjectId,
                  gradingPeriodId: gradingPeriodId,
                  studentId: entry.studentId,
                  rank: entry.rank,
                  grade: entry.grade,
                  calculatedAt: now,
                ),
              )
              .toList(),
        );
      });
    });
  }

  Future<List<GradeRanking>> getRankings({
    required int subjectId,
    required int gradingPeriodId,
  }) =>
      (select(gradeRankings)
            ..where(
              (row) =>
                  row.subjectId.equals(subjectId) &
                  row.gradingPeriodId.equals(gradingPeriodId),
            )
            ..orderBy([(row) => OrderingTerm(expression: row.rank)]))
          .get();

  Future<DatabasePage<(GradeRanking, Student)>> getRankingsPage({
    required int subjectId,
    required int gradingPeriodId,
    required int limit,
    required int offset,
  }) async {
    final filter =
        gradeRankings.subjectId.equals(subjectId) &
        gradeRankings.gradingPeriodId.equals(gradingPeriodId);
    final countExpression = gradeRankings.id.count();
    final totalRecords =
        await (selectOnly(gradeRankings)
              ..addColumns([countExpression])
              ..where(filter))
            .map((row) => row.read(countExpression) ?? 0)
            .getSingle();
    final query = select(gradeRankings).join([
      innerJoin(students, students.id.equalsExp(gradeRankings.studentId)),
    ]);
    query
      ..where(filter)
      ..orderBy([
        OrderingTerm(expression: gradeRankings.rank),
        OrderingTerm(expression: gradeRankings.studentId),
      ])
      ..limit(limit, offset: offset);
    final rows = await query.get();
    return DatabasePage(
      records: rows
          .map((row) => (row.readTable(gradeRankings), row.readTable(students)))
          .toList(),
      totalRecords: totalRecords,
    );
  }

  Future<String?> getApplicationSetting(String key) async {
    final rows =
        await (select(applicationSettings)
              ..where((row) => row.key.equals(key))
              ..limit(1))
            .get();
    return rows.isEmpty ? null : rows.first.value;
  }

  Future<void> saveApplicationSetting(String key, String value) async {
    final existing =
        await (select(applicationSettings)
              ..where((row) => row.key.equals(key))
              ..limit(1))
            .get();
    final now = DateTime.now().toIso8601String();
    if (existing.isEmpty) {
      await into(applicationSettings).insert(
        ApplicationSettingsCompanion.insert(
          key: key,
          value: value,
          updatedAt: now,
        ),
      );
    } else {
      await (update(
        applicationSettings,
      )..where((row) => row.id.equals(existing.first.id))).write(
        ApplicationSettingsCompanion(
          value: Value(value),
          updatedAt: Value(now),
        ),
      );
    }
  }
}

class DatabasePage<T> {
  const DatabasePage({required this.records, required this.totalRecords});

  final List<T> records;
  final int totalRecords;
}
