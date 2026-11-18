import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

const appTablePageSizes = [10, 20, 50, 100];

class AppTableTheme extends StatelessWidget {
  const AppTableTheme({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DataTableTheme(
      data: DataTableThemeData(
        headingRowHeight: 44,
        dataRowMinHeight: 48,
        dataRowMaxHeight: 48,
        horizontalMargin: 12,
        columnSpacing: 24,
        dividerThickness: 1,
        headingRowColor: const WidgetStatePropertyAll(AppColors.primaryLight),
        dataRowColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLight.withValues(alpha: 0.65);
          }
          return AppColors.white;
        }),
        headingTextStyle: const TextStyle(
          color: AppColors.primaryDark,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
        dataTextStyle: const TextStyle(color: AppColors.text, fontSize: 13),
      ),
      child: child,
    );
  }
}

class AppDataTable extends StatefulWidget {
  const AppDataTable({
    required this.columns,
    required this.rows,
    required this.totalRecords,
    required this.pageIndex,
    required this.rowsPerPage,
    required this.onPageChanged,
    required this.onRowsPerPageChanged,
    this.onSelectAll,
    this.showCheckboxColumn = false,
    this.isLoading = false,
    this.emptyMessage = 'No records found',
    super.key,
  });

  final List<DataColumn> columns;
  final List<DataRow> rows;
  final int totalRecords;
  final int pageIndex;
  final int rowsPerPage;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<int> onRowsPerPageChanged;
  final ValueChanged<bool?>? onSelectAll;
  final bool showCheckboxColumn;
  final bool isLoading;
  final String emptyMessage;

  @override
  State<AppDataTable> createState() => _AppDataTableState();
}

class _AppDataTableState extends State<AppDataTable> {
  final _verticalController = ScrollController();
  final _horizontalController = ScrollController();

  @override
  void dispose() {
    _verticalController.dispose();
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalPages = math.max(
      1,
      (widget.totalRecords + widget.rowsPerPage - 1) ~/ widget.rowsPerPage,
    );
    final pageIndex = widget.pageIndex.clamp(0, totalPages - 1);
    final firstRecord = widget.totalRecords == 0
        ? 0
        : pageIndex * widget.rowsPerPage + 1;
    final lastRecord = math.min(
      widget.totalRecords,
      pageIndex * widget.rowsPerPage + widget.rows.length,
    );

    return Column(
      children: [
        Expanded(
          child: widget.isLoading
              ? const Center(child: CircularProgressIndicator())
              : widget.totalRecords == 0
              ? Center(
                  child: Text(
                    widget.emptyMessage,
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                )
              : LayoutBuilder(
                  builder: (context, constraints) => Scrollbar(
                    controller: _verticalController,
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      controller: _verticalController,
                      child: Scrollbar(
                        controller: _horizontalController,
                        thumbVisibility: true,
                        notificationPredicate: (notification) =>
                            notification.metrics.axis == Axis.horizontal,
                        child: SingleChildScrollView(
                          controller: _horizontalController,
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: constraints.maxWidth,
                            ),
                            child: AppTableTheme(
                              child: DataTable(
                                showCheckboxColumn: widget.showCheckboxColumn,
                                onSelectAll: widget.onSelectAll,
                                columns: widget.columns,
                                rows: widget.rows,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 16,
            runSpacing: 4,
            children: [
              Text(
                'Showing $firstRecord–$lastRecord of ${widget.totalRecords} records',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                children: [
                  const Text(
                    'Rows per page:',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  DropdownButton<int>(
                    value: widget.rowsPerPage,
                    isDense: true,
                    underline: const SizedBox.shrink(),
                    items: appTablePageSizes
                        .map(
                          (size) => DropdownMenuItem(
                            value: size,
                            child: Text('$size'),
                          ),
                        )
                        .toList(),
                    onChanged: (size) {
                      if (size != null) widget.onRowsPerPageChanged(size);
                    },
                  ),
                  IconButton(
                    tooltip: 'Previous page',
                    visualDensity: VisualDensity.compact,
                    onPressed: pageIndex == 0
                        ? null
                        : () => widget.onPageChanged(pageIndex - 1),
                    icon: const Icon(Icons.chevron_left),
                  ),
                  Text(
                    'Page ${pageIndex + 1} of $totalPages',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Next page',
                    visualDensity: VisualDensity.compact,
                    onPressed: pageIndex >= totalPages - 1
                        ? null
                        : () => widget.onPageChanged(pageIndex + 1),
                    icon: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
