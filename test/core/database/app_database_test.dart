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
}
