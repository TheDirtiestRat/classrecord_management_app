import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../shared/widgets/app_data_table.dart';
import '../../academic_management/providers/academic_management_providers.dart';
import '../providers/students_providers.dart';

class StudentsPage extends ConsumerStatefulWidget {
  const StudentsPage({super.key});

  @override
  ConsumerState<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends ConsumerState<StudentsPage> {
  final _searchController = TextEditingController();
  Timer? _searchDebounce;
  String _search = '';
  String _courseFilter = 'All';
  String _statusFilter = 'All';
  int? _yearFilter;
  int _pageIndex = 0;
  int _rowsPerPage = 10;
  final Set<int> _selectedStudentIds = {};

  static const _studentColumns = [
    DataColumn(label: Text('Student Number')),
    DataColumn(label: Text('Student Name')),
    DataColumn(label: Text('Course')),
    DataColumn(label: Text('Year')),
    DataColumn(label: Text('Status')),
    DataColumn(label: Text('Actions')),
  ];

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final coursesAsync = ref.watch(studentCourseOptionsProvider);
    final courseFilter =
        _courseFilter == 'All' ||
            (coursesAsync.value ?? const <String>[]).contains(_courseFilter)
        ? _courseFilter
        : 'All';
    final query = StudentDirectoryQuery(
      search: _search,
      course: courseFilter == 'All' ? null : courseFilter,
      status: _statusFilter == 'All' ? null : _statusFilter,
      yearLevel: _yearFilter,
      pageIndex: _pageIndex,
      rowsPerPage: _rowsPerPage,
    );
    final studentsAsync = ref.watch(studentDirectoryPageProvider(query));
    final sectionsAsync = ref.watch(sectionsProvider);
    final subjectsAsync = ref.watch(subjectsProvider);

    return Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: [
              const Text(
                'Students',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => _importCsv(context),
                    icon: const Icon(Icons.upload_outlined),
                    label: const Text('Import CSV'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => _exportCsv(context),
                    icon: const Icon(Icons.download_outlined),
                    label: const Text('Export CSV'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _openStudentDialog(
                      context,
                      ref,
                      sectionsAsync: sectionsAsync,
                    ),
                    icon: const Icon(Icons.person_add_alt_1),
                    label: const Text('Add Student'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          Expanded(
            child: Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    if (_selectedStudentIds.isNotEmpty) ...[
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 12,
                        runSpacing: 8,
                        children: [
                          Text(
                            '${_selectedStudentIds.length} students selected',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          TextButton(
                            onPressed: () =>
                                setState(_selectedStudentIds.clear),
                            child: const Text('Clear selection'),
                          ),
                          ElevatedButton.icon(
                            onPressed: () => _openBatchUpdateDialog(context),
                            icon: const Icon(Icons.edit_outlined),
                            label: const Text('Batch Update'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                    ],
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final searchWidth = constraints.maxWidth < 760
                            ? constraints.maxWidth
                            : 320.0;
                        return Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            SizedBox(
                              width: searchWidth,
                              child: TextField(
                                controller: _searchController,
                                onChanged: _onSearchChanged,
                                decoration: const InputDecoration(
                                  hintText: 'Search student number or name',
                                  prefixIcon: Icon(Icons.search),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 180,
                              child: coursesAsync.when(
                                loading: () => const LinearProgressIndicator(),
                                error: (error, stack) => Text(
                                  'Unable to load courses: $error',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                data: (courses) {
                                  final courseValue =
                                      courses.contains(_courseFilter)
                                      ? _courseFilter
                                      : 'All';
                                  return DropdownButtonFormField<String>(
                                    key: ValueKey(courseValue),
                                    initialValue: courseValue,
                                    isExpanded: true,
                                    decoration: const InputDecoration(
                                      labelText: 'Course',
                                    ),
                                    items: [
                                      const DropdownMenuItem(
                                        value: 'All',
                                        child: Text('All'),
                                      ),
                                      ...courses.map(
                                        (course) => DropdownMenuItem(
                                          value: course,
                                          child: Text(
                                            course,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _courseFilter = value ?? 'All';
                                        _pageIndex = 0;
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              width: 140,
                              child: DropdownButtonFormField<String>(
                                initialValue: _statusFilter,
                                isExpanded: true,
                                decoration: const InputDecoration(
                                  labelText: 'Status',
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'All',
                                    child: Text('All'),
                                  ),
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
                                  setState(() {
                                    _statusFilter = value ?? 'All';
                                    _pageIndex = 0;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: DropdownButtonFormField<int?>(
                                initialValue: _yearFilter,
                                isExpanded: true,
                                decoration: const InputDecoration(
                                  labelText: 'Year',
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: null,
                                    child: Text('All'),
                                  ),
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text('Year 1'),
                                  ),
                                  DropdownMenuItem(
                                    value: 2,
                                    child: Text('Year 2'),
                                  ),
                                  DropdownMenuItem(
                                    value: 3,
                                    child: Text('Year 3'),
                                  ),
                                  DropdownMenuItem(
                                    value: 4,
                                    child: Text('Year 4'),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _yearFilter = value;
                                    _pageIndex = 0;
                                  });
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: studentsAsync.when(
                        loading: () => AppDataTable(
                          columns: _studentColumns,
                          rows: const [],
                          totalRecords: 0,
                          pageIndex: _pageIndex,
                          rowsPerPage: _rowsPerPage,
                          onPageChanged: (_) {},
                          onRowsPerPageChanged: (_) {},
                          isLoading: true,
                        ),
                        error: (error, stack) => Center(
                          child: Text('Unable to load students: $error'),
                        ),
                        data: (page) => AppDataTable(
                          columns: _studentColumns,
                          rows: page.records
                              .map(
                                (student) => _studentRow(
                                  student,
                                  subjectsAsync,
                                  sectionsAsync,
                                ),
                              )
                              .toList(),
                          totalRecords: page.totalRecords,
                          pageIndex: _pageIndex,
                          rowsPerPage: _rowsPerPage,
                          onPageChanged: (pageIndex) =>
                              setState(() => _pageIndex = pageIndex),
                          onRowsPerPageChanged: (rowsPerPage) {
                            setState(() {
                              _rowsPerPage = rowsPerPage;
                              _pageIndex = 0;
                            });
                          },
                          onSelectAll: (selected) =>
                              _toggleSelectAll(query, selected),
                          showCheckboxColumn: true,
                          emptyMessage: 'No students found',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onSearchChanged(String value) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 250), () {
      if (!mounted) return;
      setState(() {
        _search = value;
        _pageIndex = 0;
      });
    });
  }

  Future<void> _toggleSelectAll(
    StudentDirectoryQuery query,
    bool? selected,
  ) async {
    try {
      final database = await ref.read(appDatabaseProvider.future);
      final ids = await database.getStudentIds(
        search: query.search,
        course: query.course,
        status: query.status,
        yearLevel: query.yearLevel,
      );
      if (!mounted) return;
      setState(() {
        if (selected == true) {
          _selectedStudentIds.addAll(ids);
        } else {
          _selectedStudentIds.removeAll(ids);
        }
      });
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to update student selection: $error'),
          backgroundColor: AppColors.red,
        ),
      );
    }
  }

  DataRow _studentRow(
    Student student,
    AsyncValue<List<Subject>> subjectsAsync,
    AsyncValue<List<Section>> sectionsAsync,
  ) {
    final name = [
      student.firstName,
      student.middleName,
      student.lastName,
      student.suffix,
    ].where((part) => part.isNotEmpty).join(' ');
    return DataRow(
      selected: _selectedStudentIds.contains(student.id),
      onSelectChanged: (selected) {
        setState(() {
          if (selected == true) {
            _selectedStudentIds.add(student.id);
          } else {
            _selectedStudentIds.remove(student.id);
          }
        });
      },
      cells: [
        DataCell(
          Text(
            student.studentNumber,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        DataCell(
          SizedBox(
            width: 220,
            child: Text(name, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
        ),
        DataCell(
          SizedBox(
            width: 150,
            child: Text(
              student.course,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        DataCell(Text(student.yearLevel?.toString() ?? '-')),
        DataCell(
          Chip(
            label: Text(student.status),
            backgroundColor: student.status == 'Active'
                ? AppColors.primaryLight
                : AppColors.background,
          ),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                tooltip: 'Assign subjects',
                onPressed: () =>
                    _openEnrollmentDialog(context, student, subjectsAsync),
                icon: const Icon(Icons.assignment_ind_outlined),
              ),
              IconButton(
                tooltip: 'Edit',
                onPressed: () => _openStudentDialog(
                  context,
                  ref,
                  student: student,
                  sectionsAsync: sectionsAsync,
                ),
                icon: const Icon(Icons.edit_outlined),
              ),
              IconButton(
                tooltip: 'Delete',
                onPressed: () => _deleteStudent(context, student),
                icon: const Icon(Icons.delete_outline, color: AppColors.red),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _openBatchUpdateDialog(BuildContext context) async {
    var updateCourse = false;
    var course = '';
    var updateYearLevel = false;
    var updateSection = false;
    var updateStatus = false;
    var addSubjects = false;
    int? yearLevel;
    int? sectionId;
    var status = 'Active';
    String? courseError;
    final selectedSubjectIds = <int>{};

    bool hasChanges() =>
        updateCourse ||
        updateYearLevel ||
        updateSection ||
        updateStatus ||
        (addSubjects && selectedSubjectIds.isNotEmpty);

    final saved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) {
          final screenSize = MediaQuery.sizeOf(dialogContext);
          return AlertDialog(
            title: Text('Update ${_selectedStudentIds.length} Students'),
            content: SizedBox(
              width: screenSize.width > 684 ? 620 : screenSize.width - 64,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: screenSize.height * 0.72,
                ),
                child: SingleChildScrollView(
                  child: Consumer(
                    builder: (context, dialogRef, _) {
                      final sectionsAsync = dialogRef.watch(sectionsProvider);
                      final subjectsAsync = dialogRef.watch(subjectsProvider);
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            value: updateCourse,
                            title: const Text('Update course'),
                            onChanged: (value) => setDialogState(() {
                              updateCourse = value ?? false;
                              courseError = null;
                            }),
                          ),
                          TextField(
                            enabled: updateCourse,
                            onChanged: (value) {
                              course = value;
                              if (courseError != null) {
                                setDialogState(() => courseError = null);
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Course',
                              errorText: courseError,
                            ),
                          ),
                          const SizedBox(height: 8),
                          CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            value: updateYearLevel,
                            title: const Text('Update year level'),
                            onChanged: (value) => setDialogState(
                              () => updateYearLevel = value ?? false,
                            ),
                          ),
                          DropdownButtonFormField<int?>(
                            initialValue: yearLevel,
                            decoration: const InputDecoration(
                              labelText: 'Year level',
                            ),
                            items: [
                              const DropdownMenuItem<int?>(
                                value: null,
                                child: Text('Unspecified'),
                              ),
                              ...[1, 2, 3, 4].map(
                                (year) => DropdownMenuItem<int?>(
                                  value: year,
                                  child: Text('Year $year'),
                                ),
                              ),
                            ],
                            onChanged: updateYearLevel
                                ? (value) =>
                                      setDialogState(() => yearLevel = value)
                                : null,
                          ),
                          const SizedBox(height: 8),
                          CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            value: updateSection,
                            title: const Text('Update section'),
                            onChanged: (value) => setDialogState(
                              () => updateSection = value ?? false,
                            ),
                          ),
                          sectionsAsync.when(
                            loading: () => const LinearProgressIndicator(),
                            error: (error, stack) =>
                                Text('Unable to load sections: $error'),
                            data: (sections) => DropdownButtonFormField<int?>(
                              initialValue: sectionId,
                              decoration: const InputDecoration(
                                labelText: 'Section',
                              ),
                              items: [
                                const DropdownMenuItem<int?>(
                                  value: null,
                                  child: Text('No section (clear assignment)'),
                                ),
                                ...sections.map(
                                  (section) => DropdownMenuItem<int?>(
                                    value: section.id,
                                    child: Text(section.name),
                                  ),
                                ),
                              ],
                              onChanged: updateSection
                                  ? (value) =>
                                        setDialogState(() => sectionId = value)
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 8),
                          CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            value: updateStatus,
                            title: const Text('Update status'),
                            onChanged: (value) => setDialogState(
                              () => updateStatus = value ?? false,
                            ),
                          ),
                          DropdownButtonFormField<String>(
                            initialValue: status,
                            decoration: const InputDecoration(
                              labelText: 'Status',
                            ),
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
                            onChanged: updateStatus
                                ? (value) {
                                    if (value != null) {
                                      setDialogState(() => status = value);
                                    }
                                  }
                                : null,
                          ),
                          const SizedBox(height: 8),
                          CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            value: addSubjects,
                            title: const Text('Add subjects'),
                            subtitle: const Text(
                              'Existing subject enrollments will be kept.',
                            ),
                            onChanged: (value) => setDialogState(
                              () => addSubjects = value ?? false,
                            ),
                          ),
                          subjectsAsync.when(
                            loading: () => const LinearProgressIndicator(),
                            error: (error, stack) =>
                                Text('Unable to load subjects: $error'),
                            data: (subjects) => subjects.isEmpty
                                ? const Text('No subjects available.')
                                : Column(
                                    children: subjects
                                        .map(
                                          (subject) => CheckboxListTile(
                                            contentPadding: EdgeInsets.zero,
                                            dense: true,
                                            value: selectedSubjectIds.contains(
                                              subject.id,
                                            ),
                                            title: Text(subject.name),
                                            subtitle: Text(subject.code),
                                            onChanged: addSubjects
                                                ? (selected) => setDialogState(
                                                    () {
                                                      if (selected == true) {
                                                        selectedSubjectIds.add(
                                                          subject.id,
                                                        );
                                                      } else {
                                                        selectedSubjectIds
                                                            .remove(subject.id);
                                                      }
                                                    },
                                                  )
                                                : null,
                                          ),
                                        )
                                        .toList(),
                                  ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: hasChanges()
                    ? () {
                        if (updateCourse && course.trim().isEmpty) {
                          setDialogState(
                            () => courseError = 'Enter a course name.',
                          );
                          return;
                        }
                        Navigator.pop(dialogContext, true);
                      }
                    : null,
                child: const Text('Apply'),
              ),
            ],
          );
        },
      ),
    );
    if (saved != true) {
      return;
    }

    final selectedStudentCount = _selectedStudentIds.length;
    final courseValue = course.trim();
    final subjectIdsToAdd = addSubjects
        ? selectedSubjectIds.toList()
        : const <int>[];
    await applyStudentBatchUpdate(
      ref,
      studentIds: _selectedStudentIds.toList(),
      updateCourse: updateCourse,
      course: courseValue,
      updateYearLevel: updateYearLevel,
      yearLevel: yearLevel,
      updateSection: updateSection,
      sectionId: sectionId,
      updateStatus: updateStatus,
      status: status,
      subjectIdsToAdd: subjectIdsToAdd,
    );
    if (!context.mounted) {
      return;
    }
    setState(_selectedStudentIds.clear);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Updated $selectedStudentCount students.')),
    );
  }

  Future<void> _openStudentDialog(
    BuildContext context,
    WidgetRef ref, {
    Student? student,
    required AsyncValue<List<Section>> sectionsAsync,
  }) async {
    final sections = sectionsAsync.value ?? const <Section>[];
    final numberController = TextEditingController(
      text: student?.studentNumber ?? '',
    );
    final firstController = TextEditingController(
      text: student?.firstName ?? '',
    );
    final middleController = TextEditingController(
      text: student?.middleName ?? '',
    );
    final lastController = TextEditingController(text: student?.lastName ?? '');
    final suffixController = TextEditingController(text: student?.suffix ?? '');
    final genderController = TextEditingController(text: student?.gender ?? '');
    final emailController = TextEditingController(text: student?.email ?? '');
    final contactController = TextEditingController(
      text: student?.contactNumber ?? '',
    );
    final courseController = TextEditingController(text: student?.course ?? '');
    final yearController = TextEditingController(
      text: student?.yearLevel?.toString() ?? '',
    );
    var sectionId = student?.sectionId;
    var status = student?.status ?? 'Active';

    final saved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) => AlertDialog(
          title: Text(student == null ? 'Add Student' : 'Edit Student'),
          content: SizedBox(
            width: 620,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: numberController,
                    decoration: const InputDecoration(
                      labelText: 'Student Number',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: firstController,
                          decoration: const InputDecoration(
                            labelText: 'First Name',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: middleController,
                          decoration: const InputDecoration(
                            labelText: 'Middle Name',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: lastController,
                          decoration: const InputDecoration(
                            labelText: 'Last Name',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 110,
                        child: TextField(
                          controller: suffixController,
                          decoration: const InputDecoration(
                            labelText: 'Suffix',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: genderController,
                          decoration: const InputDecoration(
                            labelText: 'Gender',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: yearController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Year Level',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: courseController,
                    decoration: const InputDecoration(labelText: 'Course'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: contactController,
                    decoration: const InputDecoration(
                      labelText: 'Contact Number',
                    ),
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
                  DropdownButtonFormField<String>(
                    initialValue: status,
                    decoration: const InputDecoration(labelText: 'Status'),
                    items: const [
                      DropdownMenuItem(value: 'Active', child: Text('Active')),
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
        ),
      ),
    );

    if (saved != true ||
        numberController.text.trim().isEmpty ||
        firstController.text.trim().isEmpty ||
        lastController.text.trim().isEmpty) {
      numberController.dispose();
      firstController.dispose();
      middleController.dispose();
      lastController.dispose();
      suffixController.dispose();
      genderController.dispose();
      emailController.dispose();
      contactController.dispose();
      courseController.dispose();
      yearController.dispose();
      if (saved == true && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Student number, first name, and last name are required.',
            ),
          ),
        );
      }
      return;
    }

    final database = await ref.read(appDatabaseProvider.future);
    final yearLevel = int.tryParse(yearController.text.trim());
    final gender = genderController.text.trim();
    final email = emailController.text.trim();
    final contact = contactController.text.trim();
    if (student == null) {
      await database.createStudent(
        studentNumber: numberController.text.trim(),
        firstName: firstController.text.trim(),
        middleName: middleController.text.trim(),
        lastName: lastController.text.trim(),
        suffix: suffixController.text.trim(),
        gender: gender.isEmpty ? null : gender,
        email: email.isEmpty ? null : email,
        contactNumber: contact.isEmpty ? null : contact,
        course: courseController.text.trim(),
        yearLevel: yearLevel,
        sectionId: sectionId,
        status: status,
      );
    } else {
      await database.updateStudent(
        id: student.id,
        studentNumber: numberController.text.trim(),
        firstName: firstController.text.trim(),
        middleName: middleController.text.trim(),
        lastName: lastController.text.trim(),
        suffix: suffixController.text.trim(),
        gender: gender.isEmpty ? null : gender,
        email: email.isEmpty ? null : email,
        contactNumber: contact.isEmpty ? null : contact,
        course: courseController.text.trim(),
        yearLevel: yearLevel,
        sectionId: sectionId,
        status: status,
      );
    }
    numberController.dispose();
    firstController.dispose();
    middleController.dispose();
    lastController.dispose();
    suffixController.dispose();
    genderController.dispose();
    emailController.dispose();
    contactController.dispose();
    courseController.dispose();
    yearController.dispose();
    ref.invalidate(studentsProvider);
    ref.invalidate(studentDirectoryPageProvider);
    ref.invalidate(studentCourseOptionsProvider);
    if (mounted) setState(() => _pageIndex = 0);
  }

  Future<void> _deleteStudent(BuildContext context, Student student) async {
    final confirmed =
        await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Student'),
            content: Text(
              'Delete ${student.firstName} ${student.lastName}? '
              'This also removes their subject enrollments and grades.',
            ),
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
    await database.deleteStudent(student.id);
    ref.invalidate(studentsProvider);
    ref.invalidate(studentDirectoryPageProvider);
    ref.invalidate(studentCourseOptionsProvider);
    if (mounted) {
      setState(() {
        _selectedStudentIds.remove(student.id);
        _pageIndex = 0;
      });
    }
  }

  Future<void> _openEnrollmentDialog(
    BuildContext context,
    Student student,
    AsyncValue<List<Subject>> subjectsAsync,
  ) async {
    final subjects = subjectsAsync.value ?? const <Subject>[];
    if (subjects.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Create a subject before enrollment.')),
      );
      return;
    }
    final database = await ref.read(appDatabaseProvider.future);
    if (!context.mounted) {
      return;
    }
    final enrolled = await Future.wait(
      subjects.map((subject) async {
        final students = await database.getEnrolledStudents(subject.id);
        return MapEntry(
          subject.id,
          students.any((item) => item.id == student.id),
        );
      }),
    );
    if (!context.mounted) {
      return;
    }
    final selected = Map<int, bool>.fromEntries(enrolled);

    final saved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) => AlertDialog(
          title: Text('Enroll ${student.firstName} ${student.lastName}'),
          content: SizedBox(
            width: 500,
            height: 360,
            child: ListView.builder(
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                final subject = subjects[index];
                return CheckboxListTile(
                  value: selected[subject.id] ?? false,
                  title: Text(subject.name),
                  subtitle: Text(subject.code),
                  onChanged: (value) => setDialogState(
                    () => selected[subject.id] = value ?? false,
                  ),
                );
              },
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
      ),
    );
    if (saved != true) {
      return;
    }
    await database.transaction(() async {
      for (final subject in subjects) {
        if (selected[subject.id] == true) {
          await database.enrollStudent(
            subjectId: subject.id,
            studentId: student.id,
          );
        } else {
          await database.unenrollStudent(
            subjectId: subject.id,
            studentId: student.id,
          );
        }
      }
    });
  }

  Future<void> _importCsv(BuildContext context) async {
    final files = await FilePicker.pickFiles(
      dialogTitle: 'Import Students CSV',
      type: FileType.custom,
      allowedExtensions: const ['csv'],
    );
    if (files.isEmpty) {
      return;
    }
    final selectedFile = files.first;
    final bytes = selectedFile.path == null
        ? null
        : await File(selectedFile.path!).readAsBytes();
    if (bytes == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to read the selected file.')),
        );
      }
      return;
    }
    final rows = Csv().decode(utf8.decode(bytes, allowMalformed: true));
    if (rows.isEmpty) {
      return;
    }
    final headers = rows.first
        .map((value) => value.toString().trim().toLowerCase())
        .toList();
    int indexOf(List<String> names) {
      for (final name in names) {
        final index = headers.indexOf(name);
        if (index >= 0) {
          return index;
        }
      }
      return -1;
    }

    final numberIndex = indexOf([
      'student number',
      'student_number',
      'studentnumber',
    ]);
    final firstIndex = indexOf(['first name', 'firstname', 'first']);
    final middleIndex = indexOf(['middle name', 'middlename', 'middle']);
    final lastIndex = indexOf(['last name', 'lastname', 'last']);
    final suffixIndex = indexOf(['suffix']);
    final courseIndex = indexOf(['course']);
    final yearIndex = indexOf(['year level', 'yearlevel', 'year']);
    if (numberIndex < 0 || firstIndex < 0 || lastIndex < 0) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'CSV requires Student Number, First Name, and Last Name columns.',
            ),
          ),
        );
      }
      return;
    }

    final database = await ref.read(appDatabaseProvider.future);
    var imported = 0;
    await database.transaction(() async {
      for (final row in rows.skip(1)) {
        String valueAt(int index) => index >= 0 && index < row.length
            ? row[index].toString().trim()
            : '';
        final number = valueAt(numberIndex);
        final firstName = valueAt(firstIndex);
        final lastName = valueAt(lastIndex);
        if (number.isEmpty || firstName.isEmpty || lastName.isEmpty) {
          continue;
        }
        final yearLevel = int.tryParse(valueAt(yearIndex));
        await database.findOrCreateStudentFromCsv(
          studentNumber: number,
          firstName: firstName,
          middleName: valueAt(middleIndex),
          lastName: lastName,
          suffix: valueAt(suffixIndex),
          course: valueAt(courseIndex),
          yearLevel: yearLevel,
        );
        imported++;
      }
    });
    ref.invalidate(studentsProvider);
    ref.invalidate(studentDirectoryPageProvider);
    ref.invalidate(studentCourseOptionsProvider);
    if (mounted) setState(() => _pageIndex = 0);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$imported student rows processed.')),
      );
    }
  }

  Future<void> _exportCsv(BuildContext context) async {
    final database = await ref.read(appDatabaseProvider.future);
    final students = await database.getAllStudents();
    final rows = <List<dynamic>>[
      [
        'Student Number',
        'First Name',
        'Middle Name',
        'Last Name',
        'Suffix',
        'Gender',
        'Email',
        'Contact Number',
        'Course',
        'Year Level',
        'Status',
      ],
      ...students.map(
        (student) => [
          student.studentNumber,
          student.firstName,
          student.middleName,
          student.lastName,
          student.suffix,
          student.gender ?? '',
          student.email ?? '',
          student.contactNumber ?? '',
          student.course,
          student.yearLevel?.toString() ?? '',
          student.status,
        ],
      ),
    ];
    final csv = Csv().encode(rows);
    final path = await FilePicker.saveFile(
      dialogTitle: 'Export Students CSV',
      fileName: 'students.csv',
      bytes: utf8.encode(csv),
    );
    if (path != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Student CSV exported successfully.')),
      );
    }
  }
}
