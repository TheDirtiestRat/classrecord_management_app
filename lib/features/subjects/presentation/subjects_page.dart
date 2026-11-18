import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../academic_management/providers/academic_management_providers.dart';

class SubjectsPage extends ConsumerWidget {
  const SubjectsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjectsAsync = ref.watch(subjectsProvider);
    final yearsAsync = ref.watch(academicYearsProvider);
    final sectionsAsync = ref.watch(sectionsProvider);
    final instructorsAsync = ref.watch(instructorsProvider);

    return Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Subjects',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _openSubjectDialog(
                  context,
                  ref,
                  yearsAsync: yearsAsync,
                  sectionsAsync: sectionsAsync,
                  instructorsAsync: instructorsAsync,
                ),
                icon: const Icon(Icons.add),
                label: const Text('Add Subject'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: subjectsAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) =>
                      Text('Unable to load subjects: $error'),
                  data: (subjects) {
                    if (subjects.isEmpty) {
                      return const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.menu_book_outlined,
                              size: 44,
                              color: AppColors.textSecondary,
                            ),
                            SizedBox(height: 12),
                            Text(
                              'No subjects created',
                              style: TextStyle(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      );
                    }
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        child: DataTable(
                          headingRowHeight: 44,
                          dataRowMinHeight: 48,
                          dataRowMaxHeight: 48,
                          columns: const [
                            DataColumn(label: Text('Code')),
                            DataColumn(label: Text('Subject')),
                            DataColumn(label: Text('Units')),
                            DataColumn(label: Text('Section')),
                            DataColumn(label: Text('Status')),
                            DataColumn(label: Text('Actions')),
                          ],
                          rows: subjects
                              .map(
                                (subject) => DataRow(
                                  cells: [
                                    DataCell(
                                      Text(
                                        subject.code,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      SizedBox(
                                        width: 220,
                                        child: Text(subject.name),
                                      ),
                                    ),
                                    DataCell(Text(subject.units.toString())),
                                    DataCell(
                                      Text(
                                        subject.sectionId?.toString() ?? '-',
                                      ),
                                    ),
                                    DataCell(
                                      Chip(
                                        label: Text(subject.status),
                                        backgroundColor:
                                            subject.status == 'Active'
                                            ? AppColors.primaryLight
                                            : AppColors.background,
                                      ),
                                    ),
                                    DataCell(
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            tooltip: 'Edit',
                                            onPressed: () => _openSubjectDialog(
                                              context,
                                              ref,
                                              subject: subject,
                                              yearsAsync: yearsAsync,
                                              sectionsAsync: sectionsAsync,
                                              instructorsAsync:
                                                  instructorsAsync,
                                            ),
                                            icon: const Icon(
                                              Icons.edit_outlined,
                                            ),
                                          ),
                                          IconButton(
                                            tooltip: 'Delete',
                                            onPressed: () => _deleteSubject(
                                              context,
                                              ref,
                                              subject,
                                            ),
                                            icon: const Icon(
                                              Icons.delete_outline,
                                              color: AppColors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openSubjectDialog(
    BuildContext context,
    WidgetRef ref, {
    Subject? subject,
    required AsyncValue<List<AcademicYear>> yearsAsync,
    required AsyncValue<List<Section>> sectionsAsync,
    required AsyncValue<List<Instructor>> instructorsAsync,
  }) async {
    final years = yearsAsync.value ?? const <AcademicYear>[];
    final sections = sectionsAsync.value ?? const <Section>[];
    final instructors = instructorsAsync.value ?? const <Instructor>[];
    if (years.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Create an academic year before adding a subject.'),
        ),
      );
      return;
    }

    var yearId =
        subject?.academicYearId ??
        (years.where((year) => year.isActive).isNotEmpty
            ? years.firstWhere((year) => year.isActive).id
            : years.first.id);
    var semesterId = subject?.semesterId;
    var sectionId = subject?.sectionId;
    var instructorId = subject?.instructorId;
    var status = subject?.status ?? 'Active';

    final codeController = TextEditingController(text: subject?.code ?? '');
    final nameController = TextEditingController(text: subject?.name ?? '');
    final descriptionController = TextEditingController(
      text: subject?.description ?? '',
    );
    final unitsController = TextEditingController(
      text: subject?.units.toString() ?? '3',
    );

    final saved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) {
          final semestersAsync = ref.watch(semestersProvider(yearId));
          return AlertDialog(
            title: Text(subject == null ? 'Add Subject' : 'Edit Subject'),
            content: SizedBox(
              width: 620,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: codeController,
                            decoration: const InputDecoration(
                              labelText: 'Subject Code',
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: unitsController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Units',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Subject Name',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: descriptionController,
                      minLines: 2,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<int>(
                      initialValue: yearId,
                      decoration: const InputDecoration(
                        labelText: 'Academic Year',
                      ),
                      items: years
                          .map(
                            (year) => DropdownMenuItem(
                              value: year.id,
                              child: Text(year.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setDialogState(() {
                            yearId = value;
                            semesterId = null;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    semestersAsync.when(
                      loading: () => const LinearProgressIndicator(),
                      error: (error, stack) =>
                          Text('Unable to load semesters: $error'),
                      data: (semesters) {
                        if (semesterId != null &&
                            !semesters.any((item) => item.id == semesterId)) {
                          semesterId = semesters.isEmpty
                              ? null
                              : semesters.first.id;
                        }
                        return DropdownButtonFormField<int>(
                          initialValue: semesterId,
                          decoration: const InputDecoration(
                            labelText: 'Semester',
                          ),
                          items: semesters
                              .map(
                                (semester) => DropdownMenuItem(
                                  value: semester.id,
                                  child: Text(semester.name),
                                ),
                              )
                              .toList(),
                          onChanged: (value) =>
                              setDialogState(() => semesterId = value),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<int?>(
                      initialValue: sectionId,
                      decoration: const InputDecoration(labelText: 'Section'),
                      items: [
                        const DropdownMenuItem<int?>(
                          value: null,
                          child: Text('No section'),
                        ),
                        ...sections.map(
                          (section) => DropdownMenuItem<int?>(
                            value: section.id,
                            child: Text(section.name),
                          ),
                        ),
                      ],
                      onChanged: (value) =>
                          setDialogState(() => sectionId = value),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<int?>(
                      initialValue: instructorId,
                      decoration: const InputDecoration(
                        labelText: 'Instructor',
                      ),
                      items: [
                        const DropdownMenuItem<int?>(
                          value: null,
                          child: Text('No instructor'),
                        ),
                        ...instructors.map(
                          (instructor) => DropdownMenuItem<int?>(
                            value: instructor.id,
                            child: Text(
                              '${instructor.firstName} ${instructor.lastName}',
                            ),
                          ),
                        ),
                      ],
                      onChanged: (value) =>
                          setDialogState(() => instructorId = value),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: status,
                      decoration: const InputDecoration(labelText: 'Status'),
                      items: const [
                        DropdownMenuItem(
                          value: 'Active',
                          child: Text('Active'),
                        ),
                        DropdownMenuItem(
                          value: 'Inactive',
                          child: Text('Inactive'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setDialogState(() => status = value);
                        }
                      },
                    ),
                  ],
                ),
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
          );
        },
      ),
    );
    if (saved != true ||
        codeController.text.trim().isEmpty ||
        nameController.text.trim().isEmpty ||
        semesterId == null) {
      codeController.dispose();
      nameController.dispose();
      descriptionController.dispose();
      unitsController.dispose();
      if (saved == true && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Enter subject code, name, and semester.'),
          ),
        );
      }
      return;
    }
    final units = double.tryParse(unitsController.text.trim()) ?? 3;
    final database = await ref.read(appDatabaseProvider.future);
    if (subject == null) {
      await database.createSubject(
        code: codeController.text.trim(),
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        academicYearId: yearId,
        semesterId: semesterId!,
        sectionId: sectionId,
        instructorId: instructorId,
        units: units,
        status: status,
      );
    } else {
      await database.updateSubject(
        id: subject.id,
        code: codeController.text.trim(),
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        academicYearId: yearId,
        semesterId: semesterId!,
        sectionId: sectionId,
        instructorId: instructorId,
        units: units,
        status: status,
      );
    }
    codeController.dispose();
    nameController.dispose();
    descriptionController.dispose();
    unitsController.dispose();
    ref.invalidate(subjectsProvider);
  }

  Future<void> _deleteSubject(
    BuildContext context,
    WidgetRef ref,
    Subject subject,
  ) async {
    final confirmed =
        await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Subject'),
            content: Text('Delete ${subject.code} - ${subject.name}?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
        ) ??
        false;
    if (!confirmed) {
      return;
    }
    final database = await ref.read(appDatabaseProvider.future);
    await database.deleteSubject(subject.id);
    ref.invalidate(subjectsProvider);
  }
}
