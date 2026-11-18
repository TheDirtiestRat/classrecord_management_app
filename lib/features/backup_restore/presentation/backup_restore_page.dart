import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/database/database_path_service.dart';
import '../../../core/database/database_provider.dart';
import '../data/backup_restore_service.dart';

class BackupRestorePage extends ConsumerStatefulWidget {
  const BackupRestorePage({super.key});

  @override
  ConsumerState<BackupRestorePage> createState() => _BackupRestorePageState();
}

class _BackupRestorePageState extends ConsumerState<BackupRestorePage> {
  final _service = const BackupRestoreService();
  List<BackupRecord> _backups = const [];
  bool _loading = true;
  bool _working = false;
  String? _error;
  late Future<String> _backupPath;

  @override
  void initState() {
    super.initState();
    _backupPath = DatabasePathService.backupDirectoryPath();
    _loadBackups();
  }

  Future<void> _loadBackups() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final path = await DatabasePathService.backupDirectoryPath();
      final backups = await _service.listBackups(path);
      if (!mounted) return;
      setState(() {
        _backups = backups;
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = 'Unable to load backups: $error';
        _loading = false;
      });
    }
  }

  Future<void> _createBackup() async {
    setState(() => _working = true);
    try {
      final sourcePath = await DatabasePathService.databasePath();
      final backupDirectory = await DatabasePathService.backupDirectoryPath();
      final backup = await _service.createBackup(
        sourcePath: sourcePath,
        backupDirectory: backupDirectory,
      );
      if (!mounted) return;
      _showMessage('Backup created: ${backup.file.uri.pathSegments.last}');
      await _loadBackups();
    } catch (error) {
      if (mounted) _showError('Unable to create backup: $error');
    } finally {
      if (mounted) setState(() => _working = false);
    }
  }

  Future<void> _chooseBackupToRestore() async {
    final files = await FilePicker.pickFiles(
      dialogTitle: 'Select a Grade Management Backup',
      type: FileType.custom,
      allowedExtensions: const ['db', 'sqlite'],
    );
    if (files.isEmpty || files.first.path == null) return;
    await _restore(files.first.path!);
  }

  Future<void> _restore(String backupPath) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restore Database?'),
        content: const Text(
          'Restoring replaces all current application records with the selected '
          'backup. A safety backup of the current database will be created '
          'before replacement. Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.red),
            child: const Text('Restore'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    setState(() => _working = true);
    try {
      final database = await ref.read(appDatabaseProvider.future);
      final activePath = await DatabasePathService.databasePath();
      final backupDirectory = await DatabasePathService.backupDirectoryPath();
      final safetyBackup = await _service.restoreBackup(
        backupPath: backupPath,
        activePath: activePath,
        backupDirectory: backupDirectory,
        closeActiveDatabase: database.close,
      );
      ref.invalidate(appDatabaseProvider);
      if (!mounted) return;
      _showMessage(
        'Database restored. Safety backup saved as '
        '${safetyBackup.file.uri.pathSegments.last}.',
      );
    } catch (error) {
      ref.invalidate(appDatabaseProvider);
      if (mounted) _showError('Unable to restore database: $error');
    } finally {
      if (mounted) {
        setState(() => _working = false);
        await _loadBackups();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _backupPath,
      builder: (context, pathSnapshot) {
        final directory = pathSnapshot.data ?? 'Loading...';
        return SingleChildScrollView(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Backup and Restore',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              const Text(
                'Protect your local grade records with validated database backups.',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 20),
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Local Backup Location',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      SelectableText(directory),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          ElevatedButton.icon(
                            onPressed: _working ? null : _createBackup,
                            icon: const Icon(Icons.backup_outlined),
                            label: const Text('Create Backup'),
                          ),
                          OutlinedButton.icon(
                            onPressed: _working ? null : _chooseBackupToRestore,
                            icon: const Icon(Icons.restore_outlined),
                            label: const Text('Restore from File'),
                          ),
                          IconButton(
                            onPressed: _working ? null : _loadBackups,
                            tooltip: 'Refresh backup history',
                            icon: const Icon(Icons.refresh),
                          ),
                        ],
                      ),
                      if (_working) ...[
                        const SizedBox(height: 16),
                        const LinearProgressIndicator(),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Backup History',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Text(
                            '${_backups.length} backup${_backups.length == 1 ? '' : 's'}',
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                      if (_loading)
                        const Padding(
                          padding: EdgeInsets.all(24),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      else if (_error != null)
                        Text(
                          _error!,
                          style: const TextStyle(color: AppColors.red),
                        )
                      else if (_backups.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(24),
                          child: Center(
                            child: Text(
                              'No backups created yet.',
                              style: TextStyle(color: AppColors.textSecondary),
                            ),
                          ),
                        )
                      else
                        ..._backups.map(_backupTile),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _backupTile(BackupRecord backup) {
    final filename = backup.file.uri.pathSegments.last;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        backup.isSafetyBackup
            ? Icons.health_and_safety_outlined
            : Icons.storage,
        color: backup.isSafetyBackup ? AppColors.orange : AppColors.primary,
      ),
      title: Text(filename),
      subtitle: Text(
        '${DateFormat('MMM d, yyyy  h:mm a').format(backup.modifiedAt)}'
        '  ·  ${_formatSize(backup.file.lengthSync())}'
        '${backup.isSafetyBackup ? '  ·  Safety backup' : ''}',
      ),
      trailing: TextButton.icon(
        onPressed: _working ? null : () => _restore(backup.file.path),
        icon: const Icon(Icons.restore),
        label: const Text('Restore'),
      ),
    );
  }

  String _formatSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.red),
    );
  }
}
