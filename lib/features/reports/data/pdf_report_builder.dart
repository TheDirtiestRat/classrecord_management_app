import 'dart:io';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../domain/report_document_data.dart';

class PdfReportBuilder {
  const PdfReportBuilder();

  Future<Uint8List> build(ReportDocumentData report) async {
    final document = pw.Document();
    final regular = pw.Font.ttf(
      ByteData.sublistView(
        await File(r'C:\Windows\Fonts\segoeui.ttf').readAsBytes(),
      ),
    );
    final bold = pw.Font.ttf(
      ByteData.sublistView(
        await File(r'C:\Windows\Fonts\segoeuib.ttf').readAsBytes(),
      ),
    );

    document.addPage(
      pw.MultiPage(
        pageFormat: report.landscape
            ? PdfPageFormat.a4.landscape
            : PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(28),
        header: (context) => pw.Container(
          alignment: pw.Alignment.centerRight,
          margin: const pw.EdgeInsets.only(bottom: 8),
          child: pw.Text(
            'Page ${context.pageNumber}',
            style: pw.TextStyle(
              font: regular,
              fontSize: 8,
              color: PdfColors.grey700,
            ),
          ),
        ),
        build: (context) => [
          pw.Text(
            report.metadata.isNotEmpty ? report.metadata.first : 'GradeBook',
            style: pw.TextStyle(
              font: bold,
              fontSize: 15,
              color: PdfColor.fromInt(0xFF0F9D58),
            ),
          ),
          pw.SizedBox(height: 4),
          pw.Text(report.title, style: pw.TextStyle(font: bold, fontSize: 13)),
          pw.SizedBox(height: 8),
          ...report.metadata
              .skip(1)
              .map(
                (line) => pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 2),
                  child: pw.Text(
                    line,
                    style: pw.TextStyle(font: regular, fontSize: 8),
                  ),
                ),
              ),
          pw.SizedBox(height: 12),
          if (report.headers.isNotEmpty)
            pw.TableHelper.fromTextArray(
              headers: report.headers,
              data: report.rows,
              headerStyle: pw.TextStyle(
                font: bold,
                fontSize: 8,
                color: PdfColors.white,
              ),
              cellStyle: pw.TextStyle(font: regular, fontSize: 7),
              headerDecoration: const pw.BoxDecoration(
                color: PdfColor.fromInt(0xFF0F9D58),
              ),
              border: pw.TableBorder.all(
                color: const PdfColor.fromInt(0xFFDADCE0),
                width: 0.5,
              ),
              cellPadding: const pw.EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 4,
              ),
              oddRowDecoration: const pw.BoxDecoration(
                color: PdfColor.fromInt(0xFFF8F9FA),
              ),
            ),
          if (report.rows.isEmpty)
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(vertical: 24),
              child: pw.Text(
                'No records available for this report.',
                style: pw.TextStyle(font: regular, fontSize: 10),
              ),
            ),
        ],
      ),
    );
    return document.save();
  }
}
