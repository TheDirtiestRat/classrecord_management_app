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
  AppDatabase(super.e);

  factory AppDatabase.openFile(String path) {
    return AppDatabase(NativeDatabase.createInBackground(File(path)));
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
    return into(academicYears).insert(
      AcademicYearsCompanion.insert(
        name: name,
        isActive: Value(isActive),
        createdAt: DateTime.now().toIso8601String(),
      ),
    );
  }

  Future<bool> updateAcademicYear(int id, String name, bool isActive) async {
    final count =
        await (update(academicYears)..where((row) => row.id.equals(id))).write(
          AcademicYearsCompanion(name: Value(name), isActive: Value(isActive)),
        );
    return count == 1;
  }

  Future<int> deleteAcademicYear(int id) =>
      (delete(academicYears)..where((row) => row.id.equals(id))).go();

  Future<List<Subject>> getAllSubjects() => (select(
    subjects,
  )..orderBy([(row) => OrderingTerm(expression: row.code)])).get();

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
}
