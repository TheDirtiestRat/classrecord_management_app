import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_database.dart';
import 'database_path_service.dart';

final appDatabaseProvider = FutureProvider<AppDatabase>((ref) async {
  final path = await DatabasePathService.databasePath();
  final database = AppDatabase.openFile(path);
  ref.onDispose(() async {
    await database.close();
  });
  return database;
});
