import 'package:classrecord_management_app/shared/widgets/app_data_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('paginates rows and updates the page size', (tester) async {
    var pageIndex = 0;
    var rowsPerPage = 10;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              final records = List.generate(25, (index) => 'Student $index');
              final start = pageIndex * rowsPerPage;
              final pageRows = records.skip(start).take(rowsPerPage).toList();
              return SizedBox(
                width: 540,
                height: 360,
                child: AppDataTable(
                  columns: const [DataColumn(label: Text('Student'))],
                  rows: pageRows
                      .map((name) => DataRow(cells: [DataCell(Text(name))]))
                      .toList(),
                  totalRecords: records.length,
                  pageIndex: pageIndex,
                  rowsPerPage: rowsPerPage,
                  onPageChanged: (value) => setState(() => pageIndex = value),
                  onRowsPerPageChanged: (value) => setState(() {
                    rowsPerPage = value;
                    pageIndex = 0;
                  }),
                ),
              );
            },
          ),
        ),
      ),
    );

    expect(find.text('Page 1 of 3'), findsOneWidget);
    expect(find.text('Student 0'), findsOneWidget);
    expect(find.text('Student 10'), findsNothing);

    await tester.tap(find.byTooltip('Next page'));
    await tester.pumpAndSettle();
    expect(find.text('Page 2 of 3'), findsOneWidget);
    expect(find.text('Student 10'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.byType(DropdownButton<int>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('20').last);
    await tester.pumpAndSettle();
    expect(find.text('Page 1 of 2'), findsOneWidget);
    expect(find.text('Showing 1–20 of 25 records'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('keeps wide tables scrollable at compact desktop widths', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 320,
            height: 360,
            child: AppDataTable(
              columns: const [
                DataColumn(label: Text('Student Number')),
                DataColumn(label: Text('Student Name')),
                DataColumn(label: Text('Course')),
              ],
              rows: List.generate(
                3,
                (index) => DataRow(
                  cells: [
                    DataCell(Text('Student number $index')),
                    DataCell(Text('Student name $index')),
                    DataCell(Text('Course $index')),
                  ],
                ),
              ),
              totalRecords: 3,
              pageIndex: 0,
              rowsPerPage: 10,
              onPageChanged: (_) {},
              onRowsPerPageChanged: (_) {},
            ),
          ),
        ),
      ),
    );

    expect(find.byType(Scrollbar), findsNWidgets(2));
    expect(tester.takeException(), isNull);
  });
}
