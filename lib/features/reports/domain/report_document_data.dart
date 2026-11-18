enum ReportType {
  gradeSheetPeriod('Grade Sheet per Grading Period'),
  attendance('Attendance Report'),
  studentProfile('Student Profile Report'),
  quiz('Quiz Report of Students'),
  gradeSheet('Gradesheet'),
  incomplete('List of IC'),
  studentSummary('Student Grade Summary'),
  ranking('Subject Ranking Report');

  const ReportType(this.label);

  final String label;
}

class ReportDocumentData {
  const ReportDocumentData({
    required this.title,
    required this.metadata,
    required this.headers,
    required this.rows,
    required this.landscape,
  });

  final String title;
  final List<String> metadata;
  final List<String> headers;
  final List<List<String>> rows;
  final bool landscape;
}
