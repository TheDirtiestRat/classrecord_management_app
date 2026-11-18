import 'dart:io';

import 'package:sqlite3/sqlite3.dart';

class BackupRecord {
  const BackupRecord({
    required this.file,
    required this.modifiedAt,
    required this.isSafetyBackup,
  });

  final File file;
  final DateTime modifiedAt;
  final bool isSafetyBackup;
}

class BackupRestoreService {
  const BackupRestoreService();

  static const _requiredTables = {
    'academic_years',
    'subjects',
    'students',
    'assessments',
    'student_assessment_scores',
    'attendance_sessions',
    'student_attendance',
    'term_grades',
  };

  Future<BackupRecord> createBackup({
    required String sourcePath,
    required String backupDirectory,
    bool isSafetyBackup = false,
  }) async {
    final sourceFile = File(sourcePath);
    if (!await sourceFile.exists()) {
      throw FileSystemException(
        'The active database file does not exist.',
        sourcePath,
      );
    }

    final directory = Directory(backupDirectory);
    await directory.create(recursive: true);
    final timestamp = _timestamp(DateTime.now());
    final prefix = isSafetyBackup
        ? 'safety_before_restore'
        : 'grade_management';
    final backupFile = File(
      '${directory.path}${Platform.pathSeparator}${prefix}_$timestamp.db',
    );
    if (await backupFile.exists()) {
      throw FileSystemException(
        'A backup with this timestamp already exists.',
        backupFile.path,
      );
    }

    final source = sqlite3.open(sourcePath, mode: OpenMode.readOnly);
    Database? destination;
    try {
      destination = sqlite3.open(backupFile.path);
      await source.backup(destination).drain();
    } finally {
      destination?.close();
      source.close();
    }

    await validateBackup(backupFile.path);
    return BackupRecord(
      file: backupFile,
      modifiedAt: await backupFile.lastModified(),
      isSafetyBackup: isSafetyBackup,
    );
  }

  Future<void> validateBackup(String path) async {
    final file = File(path);
    if (!await file.exists()) {
      throw FileSystemException('Backup file does not exist.', path);
    }
    if (await file.length() < 100) {
      throw FormatException(
        'Backup file is too small to be a valid SQLite database.',
        path,
      );
    }

    Database? database;
    try {
      database = sqlite3.open(path, mode: OpenMode.readOnly);
      final check = database.select('PRAGMA integrity_check');
      if (check.isEmpty || check.first.values.first != 'ok') {
        throw FormatException('SQLite integrity check failed for "$path".');
      }

      final tables = database
          .select("SELECT name FROM sqlite_master WHERE type = 'table'")
          .map((row) => row['name'] as String)
          .toSet();
      final missingTables = _requiredTables.difference(tables);
      if (missingTables.isNotEmpty) {
        throw FormatException(
          'This file is not a compatible grade-management backup. '
          'Missing tables: ${missingTables.join(', ')}.',
        );
      }
    } finally {
      database?.close();
    }
  }

  Future<BackupRecord> restoreBackup({
    required String backupPath,
    required String activePath,
    required String backupDirectory,
    required Future<void> Function() closeActiveDatabase,
  }) async {
    final normalizedBackup = File(backupPath).absolute.path.toLowerCase();
    final normalizedActive = File(activePath).absolute.path.toLowerCase();
    if (normalizedBackup == normalizedActive) {
      throw ArgumentError(
        'The active database cannot be selected as its own backup.',
      );
    }

    await validateBackup(backupPath);
    final safetyBackup = await createBackup(
      sourcePath: activePath,
      backupDirectory: backupDirectory,
      isSafetyBackup: true,
    );

    await closeActiveDatabase();
    final activeFile = File(activePath);
    final stagingFile = File('$activePath.restore_tmp');
    final previousFile = File('$activePath.pre_restore');
    var originalMoved = false;

    try {
      if (await stagingFile.exists()) {
        await stagingFile.delete();
      }
      if (await previousFile.exists()) {
        await previousFile.delete();
      }
      await File(backupPath).copy(stagingFile.path);
      await validateBackup(stagingFile.path);

      await _deleteIfPresent(File('$activePath-wal'));
      await _deleteIfPresent(File('$activePath-shm'));
      await activeFile.rename(previousFile.path);
      originalMoved = true;
      await stagingFile.rename(activePath);
      await previousFile.delete();
    } catch (error, stackTrace) {
      if (originalMoved &&
          !await activeFile.exists() &&
          await previousFile.exists()) {
        await previousFile.rename(activePath);
      }
      Error.throwWithStackTrace(error, stackTrace);
    } finally {
      if (await stagingFile.exists()) {
        await stagingFile.delete();
      }
    }

    return safetyBackup;
  }

  Future<List<BackupRecord>> listBackups(String backupDirectory) async {
    final directory = Directory(backupDirectory);
    if (!await directory.exists()) return const [];

    final records = <BackupRecord>[];
    await for (final entity in directory.list(followLinks: false)) {
      if (entity is! File || !entity.path.toLowerCase().endsWith('.db')) {
        continue;
      }
      final name = entity.uri.pathSegments.last;
      records.add(
        BackupRecord(
          file: entity,
          modifiedAt: await entity.lastModified(),
          isSafetyBackup: name.startsWith('safety_before_restore_'),
        ),
      );
    }
    records.sort((a, b) => b.modifiedAt.compareTo(a.modifiedAt));
    return records;
  }

  Future<void> _deleteIfPresent(File file) async {
    if (await file.exists()) {
      await file.delete();
    }
  }

  String _timestamp(DateTime dateTime) {
    String twoDigits(int value) => value.toString().padLeft(2, '0');
    return '${dateTime.year}${twoDigits(dateTime.month)}'
        '${twoDigits(dateTime.day)}_${twoDigits(dateTime.hour)}'
        '${twoDigits(dateTime.minute)}${twoDigits(dateTime.second)}'
        '_${dateTime.millisecond.toString().padLeft(3, '0')}';
  }
}
