import 'dart:convert';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../shared/widgets/app_data_table.dart';
import '../../academic_management/providers/academic_management_providers.dart';
import '../../grade_sheets/providers/grade_sheet_providers.dart';
import '../data/pdf_report_builder.dart';
import '../data/report_service.dart';
import '../domain/report_document_data.dart';

class ReportsPage extends ConsumerStatefulWidget {
  const ReportsPage({super.key});

  @override
  ConsumerState<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends ConsumerState<ReportsPage> {
  ReportType _type = ReportType.gradeSheetPeriod;
  int? _subjectId;
  int? _periodId;
  bool _working = false;
  ReportDocumentData? _lastReport;

  @override
  Widget build(BuildContext context) {
    final subjectsAsync = ref.watch(subjectsProvider);
    final periodsAsync = ref.watch(gradingPeriodsProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Reports and Printing',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          const Text(
            'Generate reports from your offline academic records.',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 22),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Report Options',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 18),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isWide = constraints.maxWidth >= 900;
                      if (isWide) {
                        return Row(
                          children: [
                            Expanded(child: _reportTypeDropdown()),
                            const SizedBox(width: 12),
                            Expanded(child: _subjectDropdown(subjectsAsync)),
                            const SizedBox(width: 12),
                            Expanded(child: _periodDropdown(periodsAsync)),
                          ],
                        );
                      }
                      return Column(
                        children: [
                          _reportTypeDropdown(),
                          const SizedBox(height: 12),
                          _subjectDropdown(subjectsAsync),
                          const SizedBox(height: 12),
                          _periodDropdown(periodsAsync),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 18),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _working ? null : _preview,
                        icon: const Icon(Icons.preview_outlined),
                        label: const Text('Preview and Print'),
                      ),
                      OutlinedButton.icon(
                        onPressed: _working ? null : _savePdf,
                        icon: const Icon(Icons.picture_as_pdf_outlined),
                        label: const Text('Save as PDF'),
                      ),
                      OutlinedButton.icon(
                        onPressed: _working ? null : _exportCsv,
                        icon: const Icon(Icons.table_view_outlined),
                        label: const Text('Export CSV'),
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
              child: _lastReport == null
                  ? const SizedBox(
                      height: 190,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.description_outlined,
                              size: 42,
                              color: AppColors.primary,
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Choose a report and generate a preview.',
                              style: TextStyle(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _lastReport!.title,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${_lastReport!.rows.length} records',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const Divider(height: 24),
                        ..._lastReport!.metadata.map(
                          (line) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              line,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (_lastReport!.headers.isNotEmpty)
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: AppTableTheme(
                              child: DataTable(
                                columns: _lastReport!.headers
                                    .map(
                                      (header) => DataColumn(
                                        label: SizedBox(
                                          width: 150,
                                          child: Text(
                                            header,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                rows: _lastReport!.rows
                                    .take(8)
                                    .map(
                                      (row) => DataRow(
                                        cells: row
                                            .map(
                                              (cell) => DataCell(
                                                SizedBox(
                                                  width: 150,
                                                  child: Text(
                                                    cell,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        if (_lastReport!.rows.length > 8)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              'Showing first 8 of ${_lastReport!.rows.length} records. Full data is included in exports.',
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Future<ReportDocumentData> _buildReport() async {
    if (_subjectId == null || _periodId == null) {
      throw StateError('Create a subject and grading period first.');
    }
    final database = await ref.read(appDatabaseProvider.future);
    return const ReportService().buildReport(
      database: database,
      type: _type,
      subjectId: _subjectId!,
      gradingPeriodId: _periodId!,
    );
  }

  Widget _reportTypeDropdown() => DropdownButtonFormField<ReportType>(
    initialValue: _type,
    decoration: const InputDecoration(labelText: 'Report Type'),
    items: ReportType.values
        .map((type) => DropdownMenuItem(value: type, child: Text(type.label)))
        .toList(),
    onChanged: (type) {
      if (type != null) setState(() => _type = type);
    },
  );

  Widget _subjectDropdown(AsyncValue<List<Subject>> subjectsAsync) {
    return subjectsAsync.when(
      loading: () => const LinearProgressIndicator(),
      error: (error, stack) => Text('Unable to load subjects: $error'),
      data: (subjects) {
        if (_subjectId == null ||
            !subjects.any((subject) => subject.id == _subjectId)) {
          _subjectId = subjects.isEmpty ? null : subjects.first.id;
        }
        return DropdownButtonFormField<int>(
          initialValue: _subjectId,
          decoration: const InputDecoration(labelText: 'Subject'),
          items: subjects
              .map(
                (subject) => DropdownMenuItem<int>(
                  value: subject.id,
                  child: Text(
                    '${subject.code} - ${subject.name}',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
              .toList(),
          onChanged: (value) => setState(() => _subjectId = value),
        );
      },
    );
  }

  Widget _periodDropdown(AsyncValue<List<GradingPeriod>> periodsAsync) {
    return periodsAsync.when(
      loading: () => const LinearProgressIndicator(),
      error: (error, stack) => Text('Unable to load periods: $error'),
      data: (periods) {
        if (_periodId == null ||
            !periods.any((period) => period.id == _periodId)) {
          _periodId = periods.isEmpty ? null : periods.first.id;
        }
        return DropdownButtonFormField<int>(
          initialValue: _periodId,
          decoration: const InputDecoration(labelText: 'Grading Period'),
          items: periods
              .map(
                (period) => DropdownMenuItem<int>(
                  value: period.id,
                  child: Text(period.name),
                ),
              )
              .toList(),
          onChanged: (value) => setState(() => _periodId = value),
        );
      },
    );
  }

  Future<Uint8List> _buildPdf(ReportDocumentData report) =>
      const PdfReportBuilder().build(report);

  Future<void> _preview() async {
    setState(() => _working = true);
    try {
      final report = await _buildReport();
      final bytes = await _buildPdf(report);
      if (!mounted) return;
      setState(() {
        _lastReport = report;
      });
      await Printing.layoutPdf(
        onLayout: (_) async => bytes,
        name: report.title,
        format: report.landscape
            ? PdfPageFormat.a4.landscape
            : PdfPageFormat.a4,
      );
    } catch (error) {
      _showError('Unable to preview report: $error');
    } finally {
      if (mounted) setState(() => _working = false);
    }
  }

  Future<void> _savePdf() async {
    setState(() => _working = true);
    try {
      final report = await _buildReport();
      final bytes = await _buildPdf(report);
      final filename =
          '${_fileName(report.title)}_${DateTime.now().toIso8601String().substring(0, 10)}.pdf';
      final result = await FilePicker.saveFile(
        dialogTitle: 'Save Report PDF',
        fileName: filename,
        bytes: bytes,
        mimeType: 'application/pdf',
      );
      if (!mounted) return;
      if (result != null) {
        setState(() {
          _lastReport = report;
        });
        _showMessage('PDF saved successfully.');
      }
    } catch (error) {
      _showError('Unable to save PDF: $error');
    } finally {
      if (mounted) setState(() => _working = false);
    }
  }

  Future<void> _exportCsv() async {
    setState(() => _working = true);
    try {
      final report = await _buildReport();
      final rows = <List<dynamic>>[report.headers, ...report.rows];
      final bytes = Uint8List.fromList(utf8.encode(Csv().encode(rows)));
      final filename =
          '${_fileName(report.title)}_${DateTime.now().toIso8601String().substring(0, 10)}.csv';
      final result = await FilePicker.saveFile(
        dialogTitle: 'Export Report CSV',
        fileName: filename,
        bytes: bytes,
        mimeType: 'text/csv',
      );
      if (!mounted) return;
      if (result != null) {
        setState(() => _lastReport = report);
        _showMessage('CSV exported successfully.');
      }
    } catch (error) {
      _showError('Unable to export CSV: $error');
    } finally {
      if (mounted) setState(() => _working = false);
    }
  }

  String _fileName(String value) => value
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
      .replaceAll(RegExp(r'^_|_$'), '');

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
