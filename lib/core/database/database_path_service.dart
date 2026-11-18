import 'dart:io';

import 'package:path_provider/path_provider.dart';

class DatabasePathService {
  const DatabasePathService._();

  static Future<Directory> applicationDirectory() async {
    if (Platform.isWindows) {
      final appData = Platform.environment['APPDATA'];
      if (appData != null && appData.isNotEmpty) {
        final directory = Directory('$appData\\GradeManagementSystem');
        await directory.create(recursive: true);
        await Directory('$appData\\GradeManagementSystem\\backups')
            .create(recursive: true);
        return directory;
      }
    }

    final directory = await getApplicationSupportDirectory();
    await Directory(
      '${directory.path}${Platform.pathSeparator}GradeManagementSystem',
    ).create(recursive: true);
    return Directory(
      '${directory.path}${Platform.pathSeparator}GradeManagementSystem',
    );
  }

  static Future<String> databasePath() async {
    final directory = await applicationDirectory();
    return '${directory.path}${Platform.pathSeparator}grade_management.db';
  }

  static Future<String> backupDirectoryPath() async {
    final directory = await applicationDirectory();
    return '${directory.path}${Platform.pathSeparator}backups';
  }
}
