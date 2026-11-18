import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../providers/academic_management_providers.dart';

class AcademicManagementPage extends ConsumerStatefulWidget {
  const AcademicManagementPage({super.key});

  @override
  ConsumerState<AcademicManagementPage> createState() =>
      _AcademicManagementPageState();
}

class _AcademicManagementPageState
    extends ConsumerState<AcademicManagementPage> {
  int? _selectedYearId;

  @override
  Widget build(BuildContext context) {
    final yearsAsync = ref.watch(academicYearsProvider);
    final schoolAsync = ref.watch(schoolSettingProvider);
    final instructorsAsync = ref.watch(instructorsProvider);
    final sectionsAsync = ref.watch(sectionsProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Academic Information',
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _addAcademicYear,
                icon: const Icon(Icons.add),
                label: const Text('Academic Year'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 1050;
              final left = _schoolCard(schoolAsync);
              final right = _instructorCard(instructorsAsync);
              if (wide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: left),
                    const SizedBox(width: 16),
                    Expanded(child: right),
                  ],
                );
              }
              return Column(
                children: [left, const SizedBox(height: 16), right],
              );
            },
          ),
          const SizedBox(height: 16),
          _academicCard(yearsAsync),
          const SizedBox(height: 16),
          _sectionsCard(sectionsAsync),
        ],
      ),
    );
  }

  Widget _schoolCard(AsyncValue<SchoolSetting?> schoolAsync) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: schoolAsync.when(
          loading: () => const SizedBox(
            height: 150,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (error, stack) =>
              Text('Unable to load school information: $error'),
          data: (school) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'School Information',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Edit school information',
                    onPressed: () => _editSchool(school),
                    icon: const Icon(Icons.edit_outlined),
                  ),
                ],
              ),
              const Divider(),
              Text(
                school?.schoolName.isEmpty != false
                    ? 'School name not set'
                    : school!.schoolName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                school?.address.isEmpty != false
                    ? 'Address not set'
                    : school!.address,
                style: const TextStyle(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _instructorCard(AsyncValue<List<Instructor>> instructorsAsync) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Instructors',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
                TextButton.icon(
                  onPressed: _addInstructor,
                  icon: const Icon(Icons.add),
                  label: const Text('Add'),
                ),
              ],
            ),
            const Divider(),
            SizedBox(
              height: 150,
              child: instructorsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) =>
                    Text('Unable to load instructors: $error'),
                data: (instructors) => instructors.isEmpty
                    ? const Center(
                        child: Text(
                          'No instructors added',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      )
                    : ListView.separated(
                        itemCount: instructors.length,
                        separatorBuilder: (_, _) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final instructor = instructors[index];
                          final name = [
                            instructor.firstName,
                            instructor.middleName,
                            instructor.lastName,
                            instructor.suffix,
                          ].where((part) => part.isNotEmpty).join(' ');
                          return ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: Text(name),
                            subtitle: Text(
                              instructor.email?.isNotEmpty == true
                                  ? instructor.email!
                                  : 'Instructor',
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  tooltip: 'Edit',
                                  onPressed: () => _editInstructor(instructor),
                                  icon: const Icon(Icons.edit_outlined),
                                ),
                                IconButton(
                                  tooltip: 'Delete',
                                  onPressed: () =>
                                      _deleteInstructor(instructor),
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    color: AppColors.red,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _academicCard(AsyncValue<List<AcademicYear>> yearsAsync) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: yearsAsync.when(
          loading: () => const SizedBox(
            height: 180,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (error, stack) =>
              Text('Unable to load academic years: $error'),
          data: (years) {
            if (_selectedYearId == null ||
                !years.any((year) => year.id == _selectedYearId)) {
              final active = years.where((year) => year.isActive).toList();
              _selectedYearId = active.isNotEmpty ? active.first.id : null;
              if (_selectedYearId == null && years.isNotEmpty) {
                _selectedYearId = years.first.id;
              }
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Academic Years and Semesters',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const Divider(),
                if (years.isEmpty)
                  const SizedBox(
                    height: 120,
                    child: Center(
                      child: Text(
                        'No academic years created',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    ),
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: DataTable(
                          headingRowHeight: 38,
                          dataRowMinHeight: 42,
                          dataRowMaxHeight: 42,
                          columns: const [
                            DataColumn(label: Text('Academic Year')),
                            DataColumn(label: Text('Status')),
                            DataColumn(label: Text('Actions')),
                          ],
                          rows: years
                              .map(
                                (year) => DataRow(
                                  selected: year.id == _selectedYearId,
                                  onSelectChanged: (_) =>
                                      setState(() => _selectedYearId = year.id),
                                  cells: [
                                    DataCell(Text(year.name)),
                                    DataCell(
                                      Text(
                                        year.isActive ? 'Active' : 'Inactive',
                                        style: TextStyle(
                                          color: year.isActive
                                              ? AppColors.primaryDark
                                              : AppColors.textSecondary,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            tooltip: 'Edit',
                                            onPressed: () =>
                                                _editAcademicYear(year),
                                            icon: const Icon(
                                              Icons.edit_outlined,
                                              size: 18,
                                            ),
                                          ),
                                          IconButton(
                                            tooltip: 'Delete',
                                            onPressed: () =>
                                                _deleteAcademicYear(year),
                                            icon: const Icon(
                                              Icons.delete_outline,
                                              size: 18,
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
                      const SizedBox(width: 16),
                      Expanded(flex: 3, child: _semesterPanel()),
                    ],
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _semesterPanel() {
    if (_selectedYearId == null) {
      return const SizedBox();
    }
    final semestersAsync = ref.watch(semestersProvider(_selectedYearId!));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Semesters',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            TextButton.icon(
              onPressed: () => _addSemester(_selectedYearId!),
              icon: const Icon(Icons.add),
              label: const Text('Add'),
            ),
          ],
        ),
        const Divider(),
        semestersAsync.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(20),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (error, stack) => Text('Unable to load semesters: $error'),
          data: (semesters) => semesters.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      'No semesters created',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                )
              : Column(
                  children: semesters
                      .map(
                        (semester) => ListTile(
                          dense: true,
                          title: Text(semester.name),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (semester.isActive)
                                const Chip(
                                  label: Text('Active'),
                                  backgroundColor: AppColors.primaryLight,
                                ),
                              IconButton(
                                tooltip: 'Edit',
                                onPressed: () =>
                                    _editSemester(_selectedYearId!, semester),
                                icon: const Icon(Icons.edit_outlined),
                              ),
                              IconButton(
                                tooltip: 'Delete',
                                onPressed: () => _deleteSemester(semester),
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: AppColors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
        ),
      ],
    );
  }

  Widget _sectionsCard(AsyncValue<List<Section>> sectionsAsync) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Sections',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
                TextButton.icon(
                  onPressed: _addSection,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Section'),
                ),
              ],
            ),
            const Divider(),
            sectionsAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(20),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, stack) => Text('Unable to load sections: $error'),
              data: (sections) => sections.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          'No sections created',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      ),
                    )
                  : DataTable(
                      columns: const [
                        DataColumn(label: Text('Section')),
                        DataColumn(label: Text('Course')),
                        DataColumn(label: Text('Year Level')),
                        DataColumn(label: Text('Actions')),
                      ],
                      rows: sections
                          .map(
                            (section) => DataRow(
                              cells: [
                                DataCell(Text(section.name)),
                                DataCell(Text(section.course)),
                                DataCell(
                                  Text(section.yearLevel?.toString() ?? '-'),
                                ),
                                DataCell(
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        tooltip: 'Edit',
                                        onPressed: () => _editSection(section),
                                        icon: const Icon(
                                          Icons.edit_outlined,
                                          size: 18,
                                        ),
                                      ),
                                      IconButton(
                                        tooltip: 'Delete',
                                        onPressed: () =>
                                            _deleteSection(section),
                                        icon: const Icon(
                                          Icons.delete_outline,
                                          size: 18,
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
          ],
        ),
      ),
    );
  }

  Future<void> _refreshAcademic() async {
    ref.invalidate(academicYearsProvider);
  }

  Future<bool> _confirm(String title, String message) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
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
  }

  Future<void> _addAcademicYear() async {
    final controller = TextEditingController();
    var isActive = false;
    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Add Academic Year'),
          content: SizedBox(
            width: 420,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Academic year',
                    hintText: '2026-2027',
                  ),
                ),
                const SizedBox(height: 8),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Set as active'),
                  value: isActive,
                  onChanged: (value) => setDialogState(() => isActive = value),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
    if (saved != true || controller.text.trim().isEmpty) {
      controller.dispose();
      return;
    }
    final database = await ref.read(appDatabaseProvider.future);
    await database.createAcademicYear(
      controller.text.trim(),
      isActive: isActive,
    );
    controller.dispose();
    await _refreshAcademic();
  }

  Future<void> _editAcademicYear(AcademicYear year) async {
    final controller = TextEditingController(text: year.name);
    var isActive = year.isActive;
    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Edit Academic Year'),
          content: SizedBox(
            width: 420,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(labelText: 'Academic year'),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Set as active'),
                  value: isActive,
                  onChanged: (value) => setDialogState(() => isActive = value),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
    if (saved != true || controller.text.trim().isEmpty) {
      controller.dispose();
      return;
    }
    final database = await ref.read(appDatabaseProvider.future);
    await database.updateAcademicYear(
      year.id,
      controller.text.trim(),
      isActive,
    );
    controller.dispose();
    await _refreshAcademic();
  }

  Future<void> _deleteAcademicYear(AcademicYear year) async {
    if (!await _confirm(
      'Delete Academic Year',
      'Delete ${year.name}? Its related semesters and subjects may also be deleted.',
    )) {
      return;
    }
    final database = await ref.read(appDatabaseProvider.future);
    await database.deleteAcademicYear(year.id);
    await _refreshAcademic();
  }

  Future<void> _addSemester(int yearId) => _editSemesterDialog(yearId: yearId);

  Future<void> _editSemester(int yearId, Semester semester) =>
      _editSemesterDialog(yearId: yearId, semester: semester);

  Future<void> _editSemesterDialog({
    required int yearId,
    Semester? semester,
  }) async {
    final controller = TextEditingController(text: semester?.name ?? '');
    var isActive = semester?.isActive ?? false;
    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(semester == null ? 'Add Semester' : 'Edit Semester'),
          content: SizedBox(
            width: 420,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Semester',
                    hintText: 'First Semester',
                  ),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Set as active'),
                  value: isActive,
                  onChanged: (value) => setDialogState(() => isActive = value),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
    if (saved != true || controller.text.trim().isEmpty) {
      controller.dispose();
      return;
    }
    final database = await ref.read(appDatabaseProvider.future);
    if (semester == null) {
      await database.createSemester(
        academicYearId: yearId,
        name: controller.text.trim(),
        isActive: isActive,
      );
    } else {
      await database.updateSemester(
        id: semester.id,
        academicYearId: yearId,
        name: controller.text.trim(),
        isActive: isActive,
      );
    }
    controller.dispose();
    ref.invalidate(semestersProvider(yearId));
  }

  Future<void> _deleteSemester(Semester semester) async {
    if (!await _confirm(
      'Delete Semester',
      'Delete ${semester.name}? Related subjects may also be deleted.',
    )) {
      return;
    }
    final database = await ref.read(appDatabaseProvider.future);
    await database.deleteSemester(semester.id);
    ref.invalidate(semestersProvider(semester.academicYearId));
  }

  Future<void> _editSchool(SchoolSetting? school) async {
    final nameController = TextEditingController(
      text: school?.schoolName ?? '',
    );
    final addressController = TextEditingController(
      text: school?.address ?? '',
    );
    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('School Information'),
        content: SizedBox(
          width: 460,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'School name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: addressController,
                minLines: 2,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Address'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (saved != true) {
      nameController.dispose();
      addressController.dispose();
      return;
    }
    final database = await ref.read(appDatabaseProvider.future);
    await database.saveSchoolSetting(
      schoolName: nameController.text.trim(),
      address: addressController.text.trim(),
    );
    nameController.dispose();
    addressController.dispose();
    ref.invalidate(schoolSettingProvider);
  }

  Future<void> _addInstructor() => _editInstructorDialog();

  Future<void> _editInstructor(Instructor instructor) =>
      _editInstructorDialog(instructor: instructor);

  Future<void> _editInstructorDialog({Instructor? instructor}) async {
    final firstController = TextEditingController(
      text: instructor?.firstName ?? '',
    );
    final middleController = TextEditingController(
      text: instructor?.middleName ?? '',
    );
    final lastController = TextEditingController(
      text: instructor?.lastName ?? '',
    );
    final suffixController = TextEditingController(
      text: instructor?.suffix ?? '',
    );
    final employeeController = TextEditingController(
      text: instructor?.employeeNumber ?? '',
    );
    final emailController = TextEditingController(
      text: instructor?.email ?? '',
    );
    final contactController = TextEditingController(
      text: instructor?.contactNumber ?? '',
    );
    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(instructor == null ? 'Add Instructor' : 'Edit Instructor'),
        content: SizedBox(
          width: 520,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: employeeController,
                  decoration: const InputDecoration(
                    labelText: 'Employee Number',
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
                        decoration: const InputDecoration(labelText: 'Suffix'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: contactController,
                  decoration: const InputDecoration(
                    labelText: 'Contact Number',
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (saved != true ||
        firstController.text.trim().isEmpty ||
        lastController.text.trim().isEmpty) {
      firstController.dispose();
      middleController.dispose();
      lastController.dispose();
      suffixController.dispose();
      employeeController.dispose();
      emailController.dispose();
      contactController.dispose();
      return;
    }
    final database = await ref.read(appDatabaseProvider.future);
    final employee = employeeController.text.trim();
    final email = emailController.text.trim();
    final contact = contactController.text.trim();
    if (instructor == null) {
      await database.createInstructor(
        firstName: firstController.text.trim(),
        middleName: middleController.text.trim(),
        lastName: lastController.text.trim(),
        suffix: suffixController.text.trim(),
        employeeNumber: employee.isEmpty ? null : employee,
        email: email.isEmpty ? null : email,
        contactNumber: contact.isEmpty ? null : contact,
      );
    } else {
      await database.updateInstructor(
        id: instructor.id,
        firstName: firstController.text.trim(),
        middleName: middleController.text.trim(),
        lastName: lastController.text.trim(),
        suffix: suffixController.text.trim(),
        employeeNumber: employee.isEmpty ? null : employee,
        email: email.isEmpty ? null : email,
        contactNumber: contact.isEmpty ? null : contact,
      );
    }
    firstController.dispose();
    middleController.dispose();
    lastController.dispose();
    suffixController.dispose();
    employeeController.dispose();
    emailController.dispose();
    contactController.dispose();
    ref.invalidate(instructorsProvider);
  }

  Future<void> _deleteInstructor(Instructor instructor) async {
    final name = '${instructor.firstName} ${instructor.lastName}';
    if (!await _confirm('Delete Instructor', 'Delete $name?')) {
      return;
    }
    final database = await ref.read(appDatabaseProvider.future);
    await database.deleteInstructor(instructor.id);
    ref.invalidate(instructorsProvider);
  }

  Future<void> _addSection() => _editSectionDialog();

  Future<void> _editSection(Section section) =>
      _editSectionDialog(section: section);

  Future<void> _editSectionDialog({Section? section}) async {
    final nameController = TextEditingController(text: section?.name ?? '');
    final courseController = TextEditingController(text: section?.course ?? '');
    final yearController = TextEditingController(
      text: section?.yearLevel?.toString() ?? '',
    );
    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(section == null ? 'Add Section' : 'Edit Section'),
        content: SizedBox(
          width: 420,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Section Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: courseController,
                decoration: const InputDecoration(labelText: 'Course'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: yearController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Year Level'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (saved != true || nameController.text.trim().isEmpty) {
      nameController.dispose();
      courseController.dispose();
      yearController.dispose();
      return;
    }
    final yearLevel = int.tryParse(yearController.text.trim());
    final database = await ref.read(appDatabaseProvider.future);
    if (section == null) {
      await database.createSection(
        name: nameController.text.trim(),
        course: courseController.text.trim(),
        yearLevel: yearLevel,
      );
    } else {
      await database.updateSection(
        id: section.id,
        name: nameController.text.trim(),
        course: courseController.text.trim(),
        yearLevel: yearLevel,
      );
    }
    nameController.dispose();
    courseController.dispose();
    yearController.dispose();
    ref.invalidate(sectionsProvider);
  }

  Future<void> _deleteSection(Section section) async {
    if (!await _confirm('Delete Section', 'Delete section ${section.name}?')) {
      return;
    }
    final database = await ref.read(appDatabaseProvider.future);
    await database.deleteSection(section.id);
    ref.invalidate(sectionsProvider);
  }
}
