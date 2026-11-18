import 'package:classrecord_management_app/core/database/app_database.dart';
import 'package:classrecord_management_app/features/academic_management/providers/academic_management_providers.dart';
import 'package:classrecord_management_app/features/subjects/presentation/subjects_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('loads and allows selecting a semester in the subject dialog', (
    tester,
  ) async {
    const academicYear = AcademicYear(
      id: 1,
      name: '2026-2027',
      isActive: true,
      createdAt: '2026-01-01',
    );
    const semesters = [
      Semester(
        id: 1,
        academicYearId: 1,
        name: 'First Semester',
        isActive: false,
        createdAt: '2026-01-01',
      ),
      Semester(
        id: 2,
        academicYearId: 1,
        name: 'Second Semester',
        isActive: true,
        createdAt: '2026-01-01',
      ),
    ];

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          academicYearsProvider.overrideWith((ref) async => [academicYear]),
          semestersProvider.overrideWith((ref, yearId) async => semesters),
          sectionsProvider.overrideWith((ref) async => const <Section>[]),
          instructorsProvider.overrideWith((ref) async => const <Instructor>[]),
          subjectsProvider.overrideWith((ref) async => const <Subject>[]),
        ],
        child: const MaterialApp(home: Scaffold(body: SubjectsPage())),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Add Subject'));
    await tester.pumpAndSettle();

    expect(find.text('Second Semester'), findsOneWidget);
    await tester.tap(find.text('Second Semester'));
    await tester.pumpAndSettle();

    expect(find.text('First Semester'), findsOneWidget);
    await tester.tap(find.text('First Semester'));
    await tester.pumpAndSettle();

    expect(find.text('First Semester'), findsOneWidget);
  });
}
