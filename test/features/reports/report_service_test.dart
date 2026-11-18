import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:classrecord_management_app/core/database/app_database.dart';
import 'package:classrecord_management_app/features/reports/data/pdf_report_builder.dart';
import 'package:classrecord_management_app/features/reports/data/report_service.dart';
import 'package:classrecord_management_app/features/reports/domain/report_document_data.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() => database.close());

  test(
    'builds a grade sheet and incomplete assessment report from records',
    () async {
      final yearId = await database.createAcademicYear('2026-2027');
      final semesterId = await database.createSemester(
        academicYearId: yearId,
        name: 'First Semester',
      );
      await database.saveSchoolSetting(
        schoolName: 'Example College',
        address: 'Example address',
      );
      final subjectId = await database.createSubject(
        code: 'IT101',
        name: 'Introduction to Computing',
        academicYearId: yearId,
        semesterId: semesterId,
      );
      final studentId = await database.createStudent(
        studentNumber: '2026-001',
        firstName: 'Ana',
        lastName: 'Reyes',
      );
      await database.enrollStudent(subjectId: subjectId, studentId: studentId);
      final period = (await database.getGradingPeriods()).first;
      final assessmentId = await database.createAssessment(
        subjectId: subjectId,
        gradingPeriodId: period.id,
        name: 'Quiz 1',
        type: 'Quiz',
        totalPossibleScore: 20,
      );
      await database.saveAssessmentScore(
        assessmentId: assessmentId,
        studentId: studentId,
        score: 18,
      );
      await database.createAssessment(
        subjectId: subjectId,
        gradingPeriodId: period.id,
        name: 'Major Exam',
        type: 'Major Exam',
        totalPossibleScore: 100,
      );

      const reportService = ReportService();
      final gradeSheet = await reportService.buildReport(
        database: database,
        type: ReportType.gradeSheetPeriod,
        subjectId: subjectId,
        gradingPeriodId: period.id,
      );
      final incomplete = await reportService.buildReport(
        database: database,
        type: ReportType.incomplete,
        subjectId: subjectId,
        gradingPeriodId: period.id,
      );

      expect(gradeSheet.metadata, contains('Example College'));
      expect(gradeSheet.headers, contains('Quiz 1'));
      expect(gradeSheet.rows.single[2], '18.0');
      expect(incomplete.rows.single.last, 'Major Exam');

      final pdf = await const PdfReportBuilder().build(gradeSheet);
      expect(String.fromCharCodes(pdf.take(4)), '%PDF');
    },
  );
}
