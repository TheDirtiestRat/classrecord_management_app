import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/services/term_grade_calculation_service.dart';
import '../../../shared/widgets/app_data_table.dart';
import '../../academic_management/providers/academic_management_providers.dart';
import '../../grade_sheets/providers/grade_sheet_providers.dart';
import '../providers/attendance_providers.dart';

class AttendancePage extends ConsumerStatefulWidget {
  const AttendancePage({super.key});

  @override
  ConsumerState<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends ConsumerState<AttendancePage> {
  DateTime _selectedDate = DateTime.now();
  int? _selectedSubjectId;
  int? _selectedGradingPeriodId;
  int _pageIndex = 0;
  int _rowsPerPage = 10;
  final Map<_AttendanceCellKey, String?> _localCodes = {};
  final Set<_AttendanceCellKey> _savingCells = {};

  String get _sessionDate => DateFormat('yyyy-MM-dd').format(_selectedDate);

  @override
  Widget build(BuildContext context) {
    final subjectsAsync = ref.watch(subjectsProvider);
    final periodsAsync = ref.watch(attendancePeriodsProvider);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Attendance Management',
            style: TextStyle(
              color: AppColors.text,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Record and review attendance by subject, grading period, and date.',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 20),
          subjectsAsync.when(
            loading: () => const LinearProgressIndicator(),
            error: (error, stack) =>
                _ErrorMessage(message: 'Unable to load subjects: $error'),
            data: (subjects) => periodsAsync.when(
              loading: () => const LinearProgressIndicator(),
              error: (error, stack) => _ErrorMessage(
                message: 'Unable to load grading periods: $error',
              ),
              data: (periods) {
                if (subjects.isEmpty || periods.isEmpty) {
                  return const Expanded(
                    child: _EmptyState(
                      icon: Icons.fact_check_outlined,
                      message: 'Create a subject and grading period before recording attendance.',
                    ),
                  );
                }

                final selectedSubjects = subjects
                    .where((subject) => subject.id == _selectedSubjectId)
                    .toList();
                final selectedPeriods = periods
                    .where((period) => period.id == _selectedGradingPeriodId)
                    .toList();
                final subjectId = selectedSubjects.isEmpty
                    ? subjects.first.id
                    : selectedSubjects.first.id;
                final gradingPeriodId = selectedPeriods.isEmpty
                    ? periods.first.id
                    : selectedPeriods.first.id;
                final query = AttendancePageQuery(
                  subjectId: subjectId,
                  gradingPeriodId: gradingPeriodId,
                  sessionDate: _sessionDate,
                  pageIndex: _pageIndex,
                  rowsPerPage: _rowsPerPage,
                );
                final dataAsync = ref.watch(attendancePageDataProvider(query));

                return Expanded(
                  child: Column(
                    children: [
                      _Filters(
                        subjects: subjects,
                        periods: periods,
                        selectedSubjectId: subjectId,
                        selectedGradingPeriodId: gradingPeriodId,
                        selectedDate: _selectedDate,
                        onSubjectChanged: (id) {
                          if (id == null) return;
                          setState(() {
                            _selectedSubjectId = id;
                            _pageIndex = 0;
                            _localCodes.clear();
                          });
                        },
                        onPeriodChanged: (id) {
                          if (id == null) return;
                          setState(() {
                            _selectedGradingPeriodId = id;
                            _pageIndex = 0;
                            _localCodes.clear();
                          });
                        },
                        onDateChanged: (date) {
                          setState(() {
                            _selectedDate = date;
                            _pageIndex = 0;
                            _localCodes.clear();
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: dataAsync.when(
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          error: (error, stack) => _ErrorMessage(
                            message: 'Unable to load attendance: $error',
                          ),
                          data: (data) => _AttendanceContent(
                            query: query,
                            data: data,
                            localCodes: _localCodes,
                            savingCells: _savingCells,
                            onStart: () => _startAttendance(query),
                            onCodeChanged: (studentId, code) =>
                                _saveCode(query, studentId, code),
                            onPageChanged: (pageIndex) =>
                                setState(() => _pageIndex = pageIndex),
                            onRowsPerPageChanged: (rowsPerPage) {
                              setState(() {
                                _rowsPerPage = rowsPerPage;
                                _pageIndex = 0;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _startAttendance(AttendancePageQuery query) async {
    try {
      final database = await ref.read(appDatabaseProvider.future);
      await database.getOrCreateAttendanceSession(
        subjectId: query.subjectId,
        gradingPeriodId: query.gradingPeriodId,
        sessionDate: query.sessionDate,
      );
      if (mounted) ref.invalidate(attendancePageDataProvider(query));
    } catch (error) {
      if (mounted) {
        _showMessage('Unable to start attendance: $error', isError: true);
      }
    }
  }

  Future<void> _saveCode(
    AttendancePageQuery query,
    int studentId,
    String? code,
  ) async {
    final cellKey = _AttendanceCellKey(
      query.subjectId,
      query.gradingPeriodId,
      query.sessionDate,
      studentId,
    );
    if (code == null || _savingCells.contains(cellKey)) return;
    setState(() {
      _localCodes[cellKey] = code;
      _savingCells.add(cellKey);
    });

    late final AppDatabase database;
    try {
      database = await ref.read(appDatabaseProvider.future);
      final sessions = await database.getAttendanceSessions(
        subjectId: query.subjectId,
        gradingPeriodId: query.gradingPeriodId,
      );
      AttendanceSession? session;
      for (final candidate in sessions) {
        if (candidate.sessionDate == query.sessionDate) {
          session = candidate;
          break;
        }
      }
      if (session == null) {
        throw StateError('Start attendance before marking students.');
      }
      await database.saveAttendanceCode(
        attendanceSessionId: session.id,
        studentId: studentId,
        code: code,
      );
    } catch (error) {
      if (mounted) {
        setState(() {
          _localCodes.remove(cellKey);
          _savingCells.remove(cellKey);
        });
        _showMessage('Unable to save attendance: $error', isError: true);
      }
      return;
    }

    if (mounted) {
      ref.invalidate(attendancePageDataProvider(query));
      setState(() {
        _localCodes.remove(cellKey);
        _savingCells.remove(cellKey);
      });
    }

    try {
      await const TermGradeCalculationService().computeAndSave(
        database: database,
        subjectId: query.subjectId,
        gradingPeriodId: query.gradingPeriodId,
      );
      if (mounted) {
        ref.invalidate(
          gradeSheetScoresProvider(
            GradeSheetQuery(
              subjectId: query.subjectId,
              gradingPeriodId: query.gradingPeriodId,
            ),
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        _showMessage(
          'Attendance was saved, but grades could not be recalculated: $error',
          isError: true,
        );
      }
    }
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? AppColors.red : AppColors.primary,
        ),
      );
  }
}

class _Filters extends StatelessWidget {
  const _Filters({
    required this.subjects,
    required this.periods,
    required this.selectedSubjectId,
    required this.selectedGradingPeriodId,
    required this.selectedDate,
    required this.onSubjectChanged,
    required this.onPeriodChanged,
    required this.onDateChanged,
  });

  final List<Subject> subjects;
  final List<GradingPeriod> periods;
  final int selectedSubjectId;
  final int selectedGradingPeriodId;
  final DateTime selectedDate;
  final ValueChanged<int?> onSubjectChanged;
  final ValueChanged<int?> onPeriodChanged;
  final ValueChanged<DateTime> onDateChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 16,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              width: 320,
              child: DropdownButtonFormField<int>(
                key: ValueKey(selectedSubjectId),
                initialValue: selectedSubjectId,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Subject',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                items: subjects
                    .map(
                      (subject) => DropdownMenuItem(
                        value: subject.id,
                        child: Text(
                          '${subject.code} — ${subject.name}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: onSubjectChanged,
              ),
            ),
            SizedBox(
              width: 190,
              child: DropdownButtonFormField<int>(
                key: ValueKey(selectedGradingPeriodId),
                initialValue: selectedGradingPeriodId,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Grading period',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                items: periods
                    .map(
                      (period) => DropdownMenuItem(
                        value: period.id,
                        child: Text(period.name),
                      ),
                    )
                    .toList(),
                onChanged: onPeriodChanged,
              ),
            ),
            OutlinedButton.icon(
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (date != null) onDateChanged(date);
              },
              icon: const Icon(Icons.calendar_today_outlined),
              label: Text(DateFormat('EEE, MMM d, yyyy').format(selectedDate)),
            ),
          ],
        ),
      ),
    );
  }
}

class _AttendanceContent extends StatelessWidget {
  const _AttendanceContent({
    required this.query,
    required this.data,
    required this.localCodes,
    required this.savingCells,
    required this.onStart,
    required this.onCodeChanged,
    required this.onPageChanged,
    required this.onRowsPerPageChanged,
  });

  final AttendancePageQuery query;
  final AttendancePageData data;
  final Map<_AttendanceCellKey, String?> localCodes;
  final Set<_AttendanceCellKey> savingCells;
  final VoidCallback onStart;
  final void Function(int studentId, String? code) onCodeChanged;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<int> onRowsPerPageChanged;

  @override
  Widget build(BuildContext context) {
    if (data.session == null) {
      return _EmptyState(
        icon: Icons.event_available_outlined,
        message:
            'No attendance session exists for ${query.sessionDate}. Start one to record attendance.',
        action: ElevatedButton.icon(
          onPressed: onStart,
          icon: const Icon(Icons.add),
          label: const Text('Start Attendance'),
        ),
      );
    }
    if (data.students.isEmpty) {
      return const _EmptyState(
        icon: Icons.people_outline,
        message: 'No students are enrolled in this subject.',
      );
    }

    final visibleStudentIds = data.students
        .map((student) => student.id)
        .toSet();
    final codes = Map<int, String>.from(data.attendanceByStudent);
    final totals = {
      for (final code in const ['P', 'L', 'A', 'E'])
        code: data.attendanceCounts[code] ?? 0,
    };
    for (final entry in localCodes.entries) {
      if (entry.key.subjectId != query.subjectId ||
          entry.key.gradingPeriodId != query.gradingPeriodId ||
          entry.key.sessionDate != query.sessionDate ||
          !visibleStudentIds.contains(entry.key.studentId)) {
        continue;
      }
      final oldCode = data.attendanceByStudent[entry.key.studentId];
      if (oldCode != null && totals.containsKey(oldCode)) {
        if (totals[oldCode]! > 0) totals[oldCode] = totals[oldCode]! - 1;
      }
      final newCode = entry.value;
      if (newCode != null && totals.containsKey(newCode)) {
        totals[newCode] = totals[newCode]! + 1;
        codes[entry.key.studentId] = newCode;
      }
    }

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16,
              runSpacing: 8,
              children: [
                Text(
                  'Attendance for ${DateFormat('MMMM d, yyyy').format(DateTime.parse(query.sessionDate))}',
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                _AttendanceTotal(
                  label: 'Present',
                  code: 'P',
                  value: totals['P']!,
                ),
                _AttendanceTotal(label: 'Late', code: 'L', value: totals['L']!),
                _AttendanceTotal(
                  label: 'Absent',
                  code: 'A',
                  value: totals['A']!,
                ),
                _AttendanceTotal(
                  label: 'Excused',
                  code: 'E',
                  value: totals['E']!,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: AppDataTable(
              columns: const [
                DataColumn(label: Text('No.')),
                DataColumn(label: Text('Student Number')),
                DataColumn(label: Text('Student Name')),
                DataColumn(label: Text('Attendance')),
                DataColumn(label: Text('Status')),
              ],
              rows: [
                for (var index = 0; index < data.students.length; index++)
                  _studentRow(
                    query.pageIndex * query.rowsPerPage + index,
                    data.students[index],
                    codes,
                  ),
              ],
              totalRecords: data.totalStudents,
              pageIndex: query.pageIndex,
              rowsPerPage: query.rowsPerPage,
              onPageChanged: onPageChanged,
              onRowsPerPageChanged: onRowsPerPageChanged,
              emptyMessage: 'No students enrolled in this subject.',
            ),
          ),
        ],
      ),
    );
  }

  DataRow _studentRow(int index, Student student, Map<int, String> codes) {
    final code = codes[student.id];
    final cellKey = _AttendanceCellKey(
      query.subjectId,
      query.gradingPeriodId,
      query.sessionDate,
      student.id,
    );
    final saving = savingCells.contains(cellKey);
    return DataRow(
      cells: [
        DataCell(Text('${index + 1}')),
        DataCell(Text(student.studentNumber)),
        DataCell(
          SizedBox(
            width: 260,
            child: Text(_studentName(student), overflow: TextOverflow.ellipsis),
          ),
        ),
        DataCell(
          SizedBox(
            width: 220,
            child: DropdownButtonFormField<String>(
              key: ValueKey((student.id, code)),
              initialValue: code == null || code.isEmpty ? null : code,
              isExpanded: true,
              isDense: true,
              decoration: InputDecoration(
                hintText: 'Select status',
                filled: true,
                fillColor: AppColors.paleGreen,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: AppColors.border),
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'P', child: Text('P — Present')),
                DropdownMenuItem(value: 'L', child: Text('L — Late')),
                DropdownMenuItem(value: 'A', child: Text('A — Absent')),
                DropdownMenuItem(value: 'E', child: Text('E — Excused')),
              ],
              onChanged: saving
                  ? null
                  : (value) => onCodeChanged(student.id, value),
            ),
          ),
        ),
        DataCell(
          saving
              ? const SizedBox(
                  width: 120,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      SizedBox(width: 8),
                      Text('Saving'),
                    ],
                  ),
                )
              : code == null || code.isEmpty
              ? const Text(
                  'Unmarked',
                  style: TextStyle(color: AppColors.textSecondary),
                )
              : const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 17,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 6),
                    Text('Saved'),
                  ],
                ),
        ),
      ],
    );
  }

  String _studentName(Student student) {
    final parts = [
      student.firstName,
      if (student.middleName.isNotEmpty) student.middleName,
      student.lastName,
      if (student.suffix.isNotEmpty) student.suffix,
    ];
    return parts.join(' ');
  }
}

class _AttendanceTotal extends StatelessWidget {
  const _AttendanceTotal({
    required this.label,
    required this.code,
    required this.value,
  });

  final String label;
  final String code;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: Row(
        children: [
          Text(
            '$code ',
            style: const TextStyle(
              color: AppColors.primaryDark,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text('$value'),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.icon, required this.message, this.action});

  final IconData icon;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 38, color: AppColors.textSecondary),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.textSecondary),
              ),
              if (action != null) ...[const SizedBox(height: 16), action!],
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  const _ErrorMessage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(message, style: const TextStyle(color: AppColors.red)),
    );
  }
}

class _AttendanceCellKey {
  const _AttendanceCellKey(
    this.subjectId,
    this.gradingPeriodId,
    this.sessionDate,
    this.studentId,
  );

  final int subjectId;
  final int gradingPeriodId;
  final String sessionDate;
  final int studentId;

  @override
  bool operator ==(Object other) =>
      other is _AttendanceCellKey &&
      other.subjectId == subjectId &&
      other.gradingPeriodId == gradingPeriodId &&
      other.sessionDate == sessionDate &&
      other.studentId == studentId;

  @override
  int get hashCode =>
      Object.hash(subjectId, gradingPeriodId, sessionDate, studentId);
}
