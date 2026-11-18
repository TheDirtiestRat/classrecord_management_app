import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:classrecord_management_app/core/database/app_database.dart';
import 'package:classrecord_management_app/features/backup_restore/data/backup_restore_service.dart';

void main() {
  late Directory temporaryDirectory;
  late Directory backupDirectory;
  late String activePath;
  late BackupRestoreService service;

  setUp(() async {
    temporaryDirectory = await Directory.systemTemp.createTemp(
      'grade_management_backup_test_',
    );
    backupDirectory = Directory(
      '${temporaryDirectory.path}${Platform.pathSeparator}backups',
    );
    activePath =
        '${temporaryDirectory.path}${Platform.pathSeparator}grade_management.db';
    service = const BackupRestoreService();
  });

  tearDown(() async {
    await temporaryDirectory.delete(recursive: true);
  });

  test('creates a consistent backup and validates its schema', () async {
    final database = AppDatabase.openFile(activePath);
    await database.createAcademicYear('2026-2027');

    final backup = await service.createBackup(
      sourcePath: activePath,
      backupDirectory: backupDirectory.path,
    );

    expect(await backup.file.exists(), isTrue);
    await service.validateBackup(backup.file.path);
    expect(await database.getAllAcademicYears(), hasLength(1));
    await database.close();
  });

  test('restore makes a safety backup and replaces active data', () async {
    final database = AppDatabase.openFile(activePath);
    await database.createAcademicYear('2025-2026');
    final backup = await service.createBackup(
      sourcePath: activePath,
      backupDirectory: backupDirectory.path,
    );
    await database.createAcademicYear('2026-2027');

    final safetyBackup = await service.restoreBackup(
      backupPath: backup.file.path,
      activePath: activePath,
      backupDirectory: backupDirectory.path,
      closeActiveDatabase: database.close,
    );

    expect(safetyBackup.isSafetyBackup, isTrue);
    expect(await safetyBackup.file.exists(), isTrue);

    final restoredDatabase = AppDatabase.openFile(activePath);
    final years = await restoredDatabase.getAllAcademicYears();
    expect(years.map((year) => year.name), ['2025-2026']);
    await restoredDatabase.close();
  });

  test(
    'rejects invalid restore files before closing the live database',
    () async {
      final database = AppDatabase.openFile(activePath);
      await database.createAcademicYear('2026-2027');
      final invalidFile = File(
        '${temporaryDirectory.path}${Platform.pathSeparator}not_a_backup.db',
      );
      await invalidFile.writeAsString('not a SQLite database');
      var closeCalled = false;

      await expectLater(
        service.restoreBackup(
          backupPath: invalidFile.path,
          activePath: activePath,
          backupDirectory: backupDirectory.path,
          closeActiveDatabase: () async {
            closeCalled = true;
            await database.close();
          },
        ),
        throwsA(isA<FormatException>()),
      );

      expect(closeCalled, isFalse);
      expect((await database.getAllAcademicYears()).single.name, '2026-2027');
      await database.close();
    },
  );
}
