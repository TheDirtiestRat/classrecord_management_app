import 'package:drift/drift.dart';

class SchoolSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get schoolName => text().withDefault(const Constant(''))();
  TextColumn get address => text().withDefault(const Constant(''))();
  TextColumn get logoPath => text().nullable()();
}

class AcademicYears extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();
  TextColumn get createdAt => text()();
}

class Semesters extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get academicYearId =>
      integer().references(AcademicYears, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();
  TextColumn get createdAt => text()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {academicYearId, name},
  ];
}

class GradingPeriods extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  IntColumn get sortOrder => integer()();
}

class Instructors extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get employeeNumber => text().nullable().unique()();
  TextColumn get firstName => text()();
  TextColumn get middleName => text().withDefault(const Constant(''))();
  TextColumn get lastName => text()();
  TextColumn get suffix => text().withDefault(const Constant(''))();
  TextColumn get email => text().nullable()();
  TextColumn get contactNumber => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}

class Sections extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  TextColumn get course => text().withDefault(const Constant(''))();
  IntColumn get yearLevel => integer().nullable()();
}

class Subjects extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text()();
  TextColumn get name => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  IntColumn get academicYearId =>
      integer().references(AcademicYears, #id, onDelete: KeyAction.cascade)();
  IntColumn get semesterId =>
      integer().references(Semesters, #id, onDelete: KeyAction.cascade)();
  IntColumn get sectionId => integer().nullable().references(
    Sections,
    #id,
    onDelete: KeyAction.setNull,
  )();
  IntColumn get instructorId => integer().nullable().references(
    Instructors,
    #id,
    onDelete: KeyAction.setNull,
  )();
  RealColumn get units => real().withDefault(const Constant(3.0))();
  TextColumn get status => text().withDefault(const Constant('Active'))();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {code, academicYearId, semesterId, sectionId},
  ];
}

class Students extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get studentNumber => text().unique()();
  TextColumn get firstName => text()();
  TextColumn get middleName => text().withDefault(const Constant(''))();
  TextColumn get lastName => text()();
  TextColumn get suffix => text().withDefault(const Constant(''))();
  TextColumn get gender => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get contactNumber => text().nullable()();
  TextColumn get course => text().withDefault(const Constant(''))();
  IntColumn get yearLevel => integer().nullable()();
  IntColumn get sectionId => integer().nullable().references(
    Sections,
    #id,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get status => text().withDefault(const Constant('Active'))();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();
}

class SubjectEnrollments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get subjectId =>
      integer().references(Subjects, #id, onDelete: KeyAction.cascade)();
  IntColumn get studentId =>
      integer().references(Students, #id, onDelete: KeyAction.cascade)();
  TextColumn get enrolledAt => text()();
  TextColumn get status => text().withDefault(const Constant('Enrolled'))();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {subjectId, studentId},
  ];
}

class Assessments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get subjectId =>
      integer().references(Subjects, #id, onDelete: KeyAction.cascade)();
  IntColumn get gradingPeriodId =>
      integer().references(GradingPeriods, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
  TextColumn get type => text()();
  TextColumn get date => text().nullable()();
  RealColumn get totalPossibleScore => real()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  TextColumn get createdAt => text()();
}

class StudentAssessmentScores extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get assessmentId =>
      integer().references(Assessments, #id, onDelete: KeyAction.cascade)();
  IntColumn get studentId =>
      integer().references(Students, #id, onDelete: KeyAction.cascade)();
  RealColumn get score => real().nullable()();
  TextColumn get updatedAt => text().nullable()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {assessmentId, studentId},
  ];
}

class AttendanceSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get subjectId =>
      integer().references(Subjects, #id, onDelete: KeyAction.cascade)();
  IntColumn get gradingPeriodId =>
      integer().references(GradingPeriods, #id, onDelete: KeyAction.cascade)();
  TextColumn get sessionDate => text()();
  TextColumn get name => text().withDefault(const Constant('Attendance'))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}

class StudentAttendance extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get attendanceSessionId => integer().references(
    AttendanceSessions,
    #id,
    onDelete: KeyAction.cascade,
  )();
  IntColumn get studentId =>
      integer().references(Students, #id, onDelete: KeyAction.cascade)();
  TextColumn get code => text()();
  TextColumn get updatedAt => text().nullable()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {attendanceSessionId, studentId},
  ];
}

class IndependentLearningRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get subjectId =>
      integer().references(Subjects, #id, onDelete: KeyAction.cascade)();
  IntColumn get gradingPeriodId =>
      integer().references(GradingPeriods, #id, onDelete: KeyAction.cascade)();
  TextColumn get activityName => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  TextColumn get activityDate => text().nullable()();
  RealColumn get totalPossibleScore => real()();
  TextColumn get remarks => text().withDefault(const Constant(''))();
  TextColumn get createdAt => text()();
}

class StudentIndependentLearningScores extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get recordId => integer().references(
    IndependentLearningRecords,
    #id,
    onDelete: KeyAction.cascade,
  )();
  IntColumn get studentId =>
      integer().references(Students, #id, onDelete: KeyAction.cascade)();
  RealColumn get score => real().nullable()();
  TextColumn get remarks => text().withDefault(const Constant(''))();
  TextColumn get updatedAt => text().nullable()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {recordId, studentId},
  ];
}

class GradingConfigurations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get subjectId => integer().nullable().references(
    Subjects,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get name => text()();
  RealColumn get quizWeight => real().withDefault(const Constant(20.0))();
  RealColumn get attendanceWeight => real().withDefault(const Constant(10.0))();
  RealColumn get workWeight => real().withDefault(const Constant(20.0))();
  RealColumn get majorExamWeight => real().withDefault(const Constant(40.0))();
  RealColumn get independentLearningWeight =>
      real().withDefault(const Constant(10.0))();
  IntColumn get decimalPlaces => integer().withDefault(const Constant(2))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}

class TermGrades extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get subjectId =>
      integer().references(Subjects, #id, onDelete: KeyAction.cascade)();
  IntColumn get studentId =>
      integer().references(Students, #id, onDelete: KeyAction.cascade)();
  IntColumn get gradingPeriodId =>
      integer().references(GradingPeriods, #id, onDelete: KeyAction.cascade)();
  RealColumn get grade => real().nullable()();
  TextColumn get remarks => text().withDefault(const Constant(''))();
  TextColumn get calculatedAt => text().nullable()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {subjectId, studentId, gradingPeriodId},
  ];
}

class GradeRankings extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get subjectId =>
      integer().references(Subjects, #id, onDelete: KeyAction.cascade)();
  IntColumn get gradingPeriodId =>
      integer().references(GradingPeriods, #id, onDelete: KeyAction.cascade)();
  IntColumn get studentId =>
      integer().references(Students, #id, onDelete: KeyAction.cascade)();
  IntColumn get rank => integer()();
  RealColumn get grade => real()();
  TextColumn get calculatedAt => text()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {subjectId, gradingPeriodId, studentId},
  ];
}

class ApplicationSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get key => text().unique()();
  TextColumn get value => text()();
  TextColumn get updatedAt => text()();
}

class ActivityLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get activity => text()();
  TextColumn get details => text().withDefault(const Constant(''))();
  TextColumn get entityType => text().nullable()();
  IntColumn get entityId => integer().nullable()();
  TextColumn get createdAt => text()();
}
