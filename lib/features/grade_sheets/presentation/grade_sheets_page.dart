import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/services/grade_computation_service.dart';
import '../../../core/services/term_grade_calculation_service.dart';
import '../../academic_management/providers/academic_management_providers.dart';
import '../../students/providers/students_providers.dart';
import '../providers/grade_sheet_providers.dart';

class GradeSheetsPage extends ConsumerStatefulWidget {
  const GradeSheetsPage({super.key});

  @override
  ConsumerState<GradeSheetsPage> createState() => _GradeSheetsPageState();
}

class _GradeSheetsPageState extends ConsumerState<GradeSheetsPage> {
  int? subjectId;
  int periodIndex = 0;

  @override
  Widget build(BuildContext context) {
    final subjectsAsync = ref.watch(subjectsProvider);
    final periodsAsync = ref.watch(gradingPeriodsProvider);

    return Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final subjectSelector = subjectsAsync.when(
                loading: () => const SizedBox(
                  height: 56,
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, stack) => const Text('Unable to load subjects'),
                data: (subjects) {
                  if (subjects.isEmpty) {
                    return const Text(
                      'Create a subject first',
                      style: TextStyle(color: AppColors.textSecondary),
                    );
                  }
                  if (subjectId == null ||
                      !subjects.any((item) => item.id == subjectId)) {
                    subjectId = subjects.first.id;
                  }
                  return DropdownButtonFormField<int>(
                    initialValue: subjectId,
                    isExpanded: true,
                    decoration: const InputDecoration(labelText: 'Subject'),
                    items: subjects
                        .map(
                          (subject) => DropdownMenuItem(
                            value: subject.id,
                            child: Text(
                              '${subject.code} - ${subject.name}',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => subjectId = value);
                      }
                    },
                  );
                },
              );
              const title = Text(
                'Grade Sheets',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              );
              if (constraints.maxWidth < 720) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    title,
                    const SizedBox(height: 12),
                    subjectSelector,
                  ],
                );
              }
              return Row(
                children: [
                  Expanded(child: title),
                  SizedBox(width: 320, child: subjectSelector),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          periodsAsync.when(
            loading: () => const LinearProgressIndicator(),
            error: (error, stack) => Text('Unable to load periods: $error'),
            data: (periods) {
              if (periods.isEmpty || subjectId == null) {
                return const Expanded(
                  child: Center(
                    child: Text(
                      'Select a subject to open a grade sheet',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                );
              }
              if (periodIndex >= periods.length) periodIndex = 0;
              return Expanded(
                child: DefaultTabController(
                  length: periods.length,
                  initialIndex: periodIndex,
                  child: Column(
                    children: [
                      Card(
                        margin: EdgeInsets.zero,
                        clipBehavior: Clip.antiAlias,
                        child: TabBar(
                          isScrollable: false,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorWeight: 3,
                          labelColor: AppColors.primary,
                          unselectedLabelColor: AppColors.textSecondary,
                          onTap: (index) => setState(() => periodIndex = index),
                          tabs: [
                            for (final period in periods)
                              Tab(
                                text:
                                    period.name.toString().toLowerCase() ==
                                        'final'
                                    ? 'Finals'
                                    : period.name,
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: TabBarView(
                          children: [
                            for (final period in periods)
                              GradeSheetGrid(
                                key: ValueKey((subjectId, period.id)),
                                query: GradeSheetQuery(
                                  subjectId: subjectId!,
                                  gradingPeriodId: period.id,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class GradeSheetGrid extends ConsumerStatefulWidget {
  const GradeSheetGrid({required this.query, super.key});

  final GradeSheetQuery query;

  @override
  ConsumerState<GradeSheetGrid> createState() => _GradeSheetGridState();
}

class _GradeSheetGridState extends ConsumerState<GradeSheetGrid>
    with AutomaticKeepAliveClientMixin {
  final _tableScrollController = ScrollController();
  final _tableVerticalScrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _tableScrollController.dispose();
    _tableVerticalScrollController.dispose();
    super.dispose();
  }

  void _showSaveError(Object error) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Unable to save grade sheet entry: $error'),
        backgroundColor: AppColors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final query = widget.query;
    final studentsAsync = ref.watch(enrolledStudentsProvider(query.subjectId));
    final assessmentsAsync = ref.watch(gradeSheetAssessmentsProvider(query));
    final attendanceAsync = ref.watch(gradeSheetAttendanceProvider(query));
    final independentAsync = ref.watch(gradeSheetIndependentProvider(query));
    final scoresAsync = ref.watch(gradeSheetScoresProvider(query));
    final databaseAsync = ref.watch(appDatabaseProvider);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: studentsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Text('Unable to load students: $error'),
          data: (students) {
            if (students.isEmpty) {
              return const Center(
                child: Text(
                  'No students enrolled in this subject',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              );
            }
            return assessmentsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) =>
                  Text('Unable to load assessments: $error'),
              data: (assessments) => attendanceAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) =>
                    Text('Unable to load attendance: $error'),
                data: (attendance) => independentAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) =>
                      Text('Unable to load independent learning: $error'),
                  data: (independent) => scoresAsync.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stack) =>
                        Text('Unable to load saved scores: $error'),
                    data: (scores) => databaseAsync.when(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, stack) =>
                          Text('Unable to open database: $error'),
                      data: (database) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () =>
                                    addAssessment(context, ref, query),
                                icon: const Icon(Icons.add, size: 18),
                                label: const Text('Assessment'),
                              ),
                              OutlinedButton.icon(
                                onPressed: () =>
                                    addAttendance(context, ref, query),
                                icon: const Icon(
                                  Icons.event_available,
                                  size: 18,
                                ),
                                label: const Text('Attendance Session'),
                              ),
                              OutlinedButton.icon(
                                onPressed: () =>
                                    addIndependent(context, ref, query),
                                icon: const Icon(
                                  Icons.auto_stories_outlined,
                                  size: 18,
                                ),
                                label: const Text('Independent Learning'),
                              ),
                              OutlinedButton.icon(
                                onPressed: () =>
                                    configureWeights(context, ref, query),
                                icon: const Icon(Icons.tune, size: 18),
                                label: const Text('Grading Weights'),
                              ),
                              OutlinedButton.icon(
                                onPressed: () =>
                                    configureAttendance(context, ref),
                                icon: const Icon(
                                  Icons.fact_check_outlined,
                                  size: 18,
                                ),
                                label: const Text('Attendance Scoring'),
                              ),
                              ElevatedButton.icon(
                                onPressed: () =>
                                    computeGrades(context, ref, query),
                                icon: const Icon(
                                  Icons.calculate_outlined,
                                  size: 18,
                                ),
                                label: const Text('Compute Grades'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Expanded(
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                const studentWidth = 210.0;
                                const assessmentWidth = 128.0;
                                const attendanceWidth = 92.0;
                                const independentWidth = 138.0;
                                final minimumTableWidth =
                                    studentWidth +
                                    assessments.length * assessmentWidth +
                                    attendance.length * attendanceWidth +
                                    independent.length * independentWidth;
                                final tableWidth =
                                    constraints.maxWidth > minimumTableWidth
                                    ? constraints.maxWidth
                                    : minimumTableWidth;

                                return Scrollbar(
                                  controller: _tableScrollController,
                                  thumbVisibility: true,
                                  notificationPredicate: (notification) =>
                                      notification.metrics.axis ==
                                      Axis.horizontal,
                                  child: SingleChildScrollView(
                                    controller: _tableScrollController,
                                    scrollDirection: Axis.horizontal,
                                    child: SizedBox(
                                      width: tableWidth,
                                      child: Scrollbar(
                                        controller:
                                            _tableVerticalScrollController,
                                        thumbVisibility: true,
                                        notificationPredicate: (notification) =>
                                            notification.metrics.axis ==
                                            Axis.vertical,
                                        child: SingleChildScrollView(
                                          controller:
                                              _tableVerticalScrollController,
                                          child: DataTable(
                                            showCheckboxColumn: false,
                                            horizontalMargin: 0,
                                            columnSpacing: 0,
                                            headingRowHeight: 58,
                                            dataRowMinHeight: 44,
                                            dataRowMaxHeight: 44,
                                            dividerThickness: 0,
                                            border: TableBorder.all(
                                              color: AppColors.border,
                                              width: 0.6,
                                            ),
                                            columns: [
                                              const DataColumn(
                                                label: SizedBox(
                                                  width: studentWidth,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 8,
                                                        ),
                                                    child: Text('Student'),
                                                  ),
                                                ),
                                              ),
                                              for (final assessment
                                                  in assessments)
                                                DataColumn(
                                                  label: SizedBox(
                                                    width: assessmentWidth,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                          ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            assessment.name,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          Text(
                                                            '${assessment.type} / ${assessment.totalPossibleScore}',
                                                            style: const TextStyle(
                                                              fontSize: 11,
                                                              color: AppColors
                                                                  .textSecondary,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              for (final session in attendance)
                                                DataColumn(
                                                  label: SizedBox(
                                                    width: attendanceWidth,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                          ),
                                                      child: Text(
                                                        session.sessionDate,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              for (final record in independent)
                                                DataColumn(
                                                  label: SizedBox(
                                                    width: independentWidth,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                          ),
                                                      child: Text(
                                                        record.activityName,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                            rows: [
                                              for (final student in students)
                                                DataRow(
                                                  key: ValueKey(student.id),
                                                  cells: [
                                                    DataCell(
                                                      SizedBox(
                                                        width: studentWidth,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                horizontal: 8,
                                                              ),
                                                          child: Text(
                                                            '${student.lastName}, ${student.firstName}',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    for (final assessment
                                                        in assessments)
                                                      DataCell(
                                                        SizedBox(
                                                          width:
                                                              assessmentWidth,
                                                          height: 40,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets.symmetric(
                                                                  horizontal: 4,
                                                                ),
                                                            child: _GradeScoreInput(
                                                              key: ValueKey(
                                                                'assessment-${assessment.id}-${student.id}',
                                                              ),
                                                              initialScore:
                                                                  scores
                                                                      .assessmentScores[(
                                                                    assessment
                                                                        .id,
                                                                    student.id,
                                                                  )],
                                                              maximum: assessment
                                                                  .totalPossibleScore,
                                                              onSave: (score) =>
                                                                  database.saveAssessmentScore(
                                                                    assessmentId:
                                                                        assessment
                                                                            .id,
                                                                    studentId:
                                                                        student
                                                                            .id,
                                                                    score:
                                                                        score,
                                                                  ),
                                                              onSaveError:
                                                                  _showSaveError,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    for (final session
                                                        in attendance)
                                                      DataCell(
                                                        SizedBox(
                                                          width:
                                                              attendanceWidth,
                                                          height: 40,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets.symmetric(
                                                                  horizontal: 4,
                                                                ),
                                                            child: _AttendanceCodeInput(
                                                              key: ValueKey(
                                                                'attendance-${session.id}-${student.id}',
                                                              ),
                                                              initialCode:
                                                                  scores
                                                                      .attendanceCodes[(
                                                                    session.id,
                                                                    student.id,
                                                                  )],
                                                              onSave: (code) =>
                                                                  database.saveAttendanceCode(
                                                                    attendanceSessionId:
                                                                        session
                                                                            .id,
                                                                    studentId:
                                                                        student
                                                                            .id,
                                                                    code: code,
                                                                  ),
                                                              onSaveError:
                                                                  _showSaveError,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    for (final record
                                                        in independent)
                                                      DataCell(
                                                        SizedBox(
                                                          width:
                                                              independentWidth,
                                                          height: 40,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets.symmetric(
                                                                  horizontal: 4,
                                                                ),
                                                            child: _GradeScoreInput(
                                                              key: ValueKey(
                                                                'independent-${record.id}-${student.id}',
                                                              ),
                                                              initialScore:
                                                                  scores
                                                                      .independentLearningScores[(
                                                                    record.id,
                                                                    student.id,
                                                                  )],
                                                              maximum: record
                                                                  .totalPossibleScore,
                                                              onSave: (score) =>
                                                                  database.saveIndependentLearningScore(
                                                                    recordId:
                                                                        record
                                                                            .id,
                                                                    studentId:
                                                                        student
                                                                            .id,
                                                                    score:
                                                                        score,
                                                                  ),
                                                              onSaveError:
                                                                  _showSaveError,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _GradeScoreInput extends StatefulWidget {
  const _GradeScoreInput({
    required this.initialScore,
    required this.maximum,
    required this.onSave,
    required this.onSaveError,
    super.key,
  });

  final double? initialScore;
  final double maximum;
  final Future<void> Function(double? score) onSave;
  final void Function(Object error) onSaveError;

  @override
  State<_GradeScoreInput> createState() => _GradeScoreInputState();
}

class _GradeScoreInputState extends State<_GradeScoreInput> {
  late final TextEditingController _controller;
  Future<void> _saveQueue = Future<void>.value();
  Timer? _debounceTimer;
  double? _lastSaved;
  double? _latestScheduledValue;
  bool _isDirty = false;
  bool _hasInvalidInput = false;
  bool _saveFailed = false;
  int _savingCount = 0;

  @override
  void initState() {
    super.initState();
    _lastSaved = widget.initialScore;
    _controller = TextEditingController(
      text: _formatScore(widget.initialScore),
    );
  }

  @override
  void didUpdateWidget(covariant _GradeScoreInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialScore != oldWidget.initialScore &&
        !_isDirty &&
        _savingCount == 0) {
      _lastSaved = widget.initialScore;
      _controller.text = _formatScore(widget.initialScore);
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    if (_isDirty && !_hasInvalidInput) {
      unawaited(_saveValue(_readValue(), updateUi: false));
    }
    _controller.dispose();
    super.dispose();
  }

  String _formatScore(double? score) {
    if (score == null) return '';
    return score == score.roundToDouble()
        ? score.toStringAsFixed(0)
        : score.toString();
  }

  double? _readValue() {
    final text = _controller.text.trim();
    return text.isEmpty ? null : double.tryParse(text);
  }

  bool _isValid(String text) {
    if (text.trim().isEmpty) return true;
    final score = double.tryParse(text);
    return score != null &&
        score.isFinite &&
        score >= 0 &&
        score <= widget.maximum;
  }

  void _handleChange(String text) {
    _debounceTimer?.cancel();
    setState(() {
      _hasInvalidInput = !_isValid(text);
      _isDirty =
          !_hasInvalidInput &&
          _readValue() !=
              (_savingCount > 0 ? _latestScheduledValue : _lastSaved);
      _saveFailed = false;
    });
    if (!_hasInvalidInput && _isDirty) {
      _debounceTimer = Timer(
        const Duration(milliseconds: 450),
        () => unawaited(_saveValue(_readValue())),
      );
    }
  }

  Future<void> _saveValue(double? value, {bool updateUi = true}) async {
    _debounceTimer?.cancel();
    final latestValue = _savingCount > 0 ? _latestScheduledValue : _lastSaved;
    if (_hasInvalidInput || value == latestValue) {
      if (updateUi && mounted && !_hasInvalidInput) {
        setState(() => _isDirty = false);
      }
      return;
    }

    _latestScheduledValue = value;
    if (updateUi && mounted) setState(() => _savingCount++);
    final save = _saveQueue.then(
      (_) => widget.onSave(value),
      onError: (Object _) => widget.onSave(value),
    );
    _saveQueue = save;

    try {
      await save;
      _lastSaved = value;
      if (updateUi && mounted) {
        setState(() {
          _saveFailed = false;
          _isDirty = !_hasInvalidInput && _readValue() != _lastSaved;
        });
      }
    } catch (error) {
      if (updateUi && mounted) setState(() => _saveFailed = true);
      widget.onSaveError(error);
    } finally {
      if (updateUi && mounted) setState(() => _savingCount--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textAlign: TextAlign.center,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
      ],
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: AppColors.paleGreen,
        hintText: 'Missing',
        contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
        suffixIconConstraints: const BoxConstraints(
          minWidth: 22,
          minHeight: 22,
        ),
        suffixIcon: _savingCount > 0
            ? const Padding(
                padding: EdgeInsets.all(4),
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : _hasInvalidInput || _saveFailed
            ? Tooltip(
                message: _hasInvalidInput
                    ? 'Enter a score from 0 to ${widget.maximum}.'
                    : 'This value could not be saved.',
                child: const Icon(
                  Icons.error_outline,
                  size: 16,
                  color: AppColors.red,
                ),
              )
            : null,
      ),
      onChanged: _handleChange,
      onEditingComplete: () {
        unawaited(_saveValue(_readValue()));
        FocusScope.of(context).nextFocus();
      },
    );
  }
}

class _AttendanceCodeInput extends StatefulWidget {
  const _AttendanceCodeInput({
    required this.initialCode,
    required this.onSave,
    required this.onSaveError,
    super.key,
  });

  final String? initialCode;
  final Future<void> Function(String code) onSave;
  final void Function(Object error) onSaveError;

  @override
  State<_AttendanceCodeInput> createState() => _AttendanceCodeInputState();
}

class _AttendanceCodeInputState extends State<_AttendanceCodeInput> {
  String? _value;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _value = widget.initialCode;
  }

  @override
  void didUpdateWidget(covariant _AttendanceCodeInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialCode != oldWidget.initialCode && !_saving) {
      _value = widget.initialCode;
    }
  }

  Future<void> _save(String? code) async {
    if (code == null || code == _value) return;
    final previousValue = _value;
    setState(() {
      _value = code;
      _saving = true;
    });
    try {
      await widget.onSave(code);
    } catch (error) {
      if (mounted) setState(() => _value = previousValue);
      widget.onSaveError(error);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      key: ValueKey(_value),
      initialValue: _value,
      isExpanded: true,
      isDense: true,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: AppColors.paleGreen,
        contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
        suffixIcon: _saving
            ? const Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : null,
      ),
      items: const [
        DropdownMenuItem(value: 'P', child: Text('P')),
        DropdownMenuItem(value: 'L', child: Text('L')),
        DropdownMenuItem(value: 'A', child: Text('A')),
        DropdownMenuItem(value: 'E', child: Text('E')),
      ],
      onChanged: _saving ? null : _save,
    );
  }
}

Future<void> addAssessment(
  BuildContext context,
  WidgetRef ref,
  GradeSheetQuery query,
) async {
  final name = TextEditingController();
  final max = TextEditingController(text: '100');
  var type = 'Quiz';
  final saved = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => StatefulBuilder(
      builder: (dialogContext, setState) => AlertDialog(
        title: const Text('Add Assessment'),
        content: SizedBox(
          width: 460,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: type,
                decoration: const InputDecoration(labelText: 'Type'),
                items: const [
                  DropdownMenuItem(value: 'Quiz', child: Text('Quiz')),
                  DropdownMenuItem(value: 'Seatwork', child: Text('Seatwork')),
                  DropdownMenuItem(
                    value: 'Assignment',
                    child: Text('Assignment'),
                  ),
                  DropdownMenuItem(value: 'Activity', child: Text('Activity')),
                  DropdownMenuItem(value: 'Project', child: Text('Project')),
                  DropdownMenuItem(
                    value: 'Major Exam',
                    child: Text('Major Exam'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) setState(() => type = value);
                },
              ),
              const SizedBox(height: 12),
              TextField(
                controller: max,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Total Possible Score',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Add'),
          ),
        ],
      ),
    ),
  );
  if (saved == true &&
      name.text.trim().isNotEmpty &&
      (double.tryParse(max.text.trim()) ?? 0) > 0 &&
      context.mounted) {
    final database = await ref.read(appDatabaseProvider.future);
    await database.createAssessment(
      subjectId: query.subjectId,
      gradingPeriodId: query.gradingPeriodId,
      name: name.text.trim(),
      type: type,
      totalPossibleScore: double.parse(max.text.trim()),
    );
    ref.invalidate(gradeSheetAssessmentsProvider(query));
  }
  name.dispose();
  max.dispose();
}

Future<void> addAttendance(
  BuildContext context,
  WidgetRef ref,
  GradeSheetQuery query,
) async {
  final date = TextEditingController(
    text: DateTime.now().toIso8601String().substring(0, 10),
  );
  final saved = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Add Attendance Session'),
      content: TextField(
        controller: date,
        decoration: const InputDecoration(
          labelText: 'Date',
          hintText: 'YYYY-MM-DD',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(dialogContext, true),
          child: const Text('Add'),
        ),
      ],
    ),
  );
  if (saved == true && date.text.trim().isNotEmpty && context.mounted) {
    final database = await ref.read(appDatabaseProvider.future);
    await database.createAttendanceSession(
      subjectId: query.subjectId,
      gradingPeriodId: query.gradingPeriodId,
      sessionDate: date.text.trim(),
    );
    ref.invalidate(gradeSheetAttendanceProvider(query));
  }
  date.dispose();
}

Future<void> addIndependent(
  BuildContext context,
  WidgetRef ref,
  GradeSheetQuery query,
) async {
  final name = TextEditingController();
  final description = TextEditingController();
  final max = TextEditingController(text: '100');
  final saved = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Add Independent Learning'),
      content: SizedBox(
        width: 460,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(labelText: 'Activity Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: description,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: max,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Total Possible Score',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(dialogContext, true),
          child: const Text('Add'),
        ),
      ],
    ),
  );
  if (saved == true &&
      name.text.trim().isNotEmpty &&
      (double.tryParse(max.text.trim()) ?? 0) > 0 &&
      context.mounted) {
    final database = await ref.read(appDatabaseProvider.future);
    await database.createIndependentLearningRecord(
      subjectId: query.subjectId,
      gradingPeriodId: query.gradingPeriodId,
      activityName: name.text.trim(),
      description: description.text.trim(),
      totalPossibleScore: double.parse(max.text.trim()),
    );
    ref.invalidate(gradeSheetIndependentProvider(query));
  }
  name.dispose();
  description.dispose();
  max.dispose();
}

Future<void> configureWeights(
  BuildContext context,
  WidgetRef ref,
  GradeSheetQuery query,
) async {
  final database = await ref.read(appDatabaseProvider.future);
  final config = await database.getActiveGradingConfiguration(query.subjectId);
  if (!context.mounted) return;
  final quiz = TextEditingController(
    text: (config?.quizWeight ?? 20).toStringAsFixed(0),
  );
  final attendance = TextEditingController(
    text: (config?.attendanceWeight ?? 10).toStringAsFixed(0),
  );
  final work = TextEditingController(
    text: (config?.workWeight ?? 20).toStringAsFixed(0),
  );
  final exam = TextEditingController(
    text: (config?.majorExamWeight ?? 40).toStringAsFixed(0),
  );
  final independent = TextEditingController(
    text: (config?.independentLearningWeight ?? 10).toStringAsFixed(0),
  );
  final saved = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Grading Weights'),
      content: SizedBox(
        width: 420,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: quiz,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quizzes %'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: attendance,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Attendance %'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: work,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Seatwork / Work / Activities / Projects %',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: exam,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Major Exams %'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: independent,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Independent Learning %',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(dialogContext, true),
          child: const Text('Save'),
        ),
      ],
    ),
  );
  if (saved == true && context.mounted) {
    final weights = GradeWeights(
      quizzes: double.tryParse(quiz.text.trim()) ?? -1,
      attendance: double.tryParse(attendance.text.trim()) ?? -1,
      work: double.tryParse(work.text.trim()) ?? -1,
      majorExams: double.tryParse(exam.text.trim()) ?? -1,
      independentLearning: double.tryParse(independent.text.trim()) ?? -1,
    );
    if (weights.isValid && context.mounted) {
      await database.saveGradingConfiguration(
        subjectId: query.subjectId,
        quizWeight: weights.quizzes,
        attendanceWeight: weights.attendance,
        workWeight: weights.work,
        majorExamWeight: weights.majorExams,
        independentLearningWeight: weights.independentLearning,
        decimalPlaces: config?.decimalPlaces ?? 2,
      );
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Grading weights saved.')));
    } else if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Grading weights must total exactly 100%.'),
        ),
      );
    }
  }
  quiz.dispose();
  attendance.dispose();
  work.dispose();
  exam.dispose();
  independent.dispose();
}

Future<void> configureAttendance(BuildContext context, WidgetRef ref) async {
  final database = await ref.read(appDatabaseProvider.future);
  final values = AttendanceValues.decode(
    await database.getApplicationSetting('attendance_scoring'),
  );
  if (!context.mounted) return;

  final present = TextEditingController(text: values.present?.toString() ?? '');
  final late = TextEditingController(text: values.late?.toString() ?? '');
  final absent = TextEditingController(text: values.absent?.toString() ?? '');
  final excused = TextEditingController(text: values.excused?.toString() ?? '');
  final saved = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Attendance Scoring Values'),
      content: SizedBox(
        width: 420,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Set each attendance code value from 0 to 100. '
              'These values are not assumed by the application.',
            ),
            const SizedBox(height: 12),
            for (final item in [
              ('P - Present', present),
              ('L - Late', late),
              ('A - Absent', absent),
              ('E - Excused', excused),
            ]) ...[
              TextField(
                controller: item.$2,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(labelText: item.$1),
              ),
              const SizedBox(height: 8),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(dialogContext, true),
          child: const Text('Save'),
        ),
      ],
    ),
  );
  final updatedValues = AttendanceValues(
    present: double.tryParse(present.text.trim()),
    late: double.tryParse(late.text.trim()),
    absent: double.tryParse(absent.text.trim()),
    excused: double.tryParse(excused.text.trim()),
  );
  if (saved == true && updatedValues.isConfigured) {
    await database.saveApplicationSetting(
      'attendance_scoring',
      updatedValues.encode(),
    );
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Attendance scoring values saved.')),
      );
    }
  } else if (saved == true && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Enter a valid value from 0 to 100 for each code.'),
      ),
    );
  }
  present.dispose();
  late.dispose();
  absent.dispose();
  excused.dispose();
}

Future<void> computeGrades(
  BuildContext context,
  WidgetRef ref,
  GradeSheetQuery query,
) async {
  try {
    final database = await ref.read(appDatabaseProvider.future);
    final result = await const TermGradeCalculationService().computeAndSave(
      database: database,
      subjectId: query.subjectId,
      gradingPeriodId: query.gradingPeriodId,
    );
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Grades computed: ${result.completedGrades} complete, '
          '${result.incompleteGrades} incomplete.',
        ),
      ),
    );
  } catch (error) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Unable to compute grades: $error'),
        backgroundColor: AppColors.red,
      ),
    );
  }
}
