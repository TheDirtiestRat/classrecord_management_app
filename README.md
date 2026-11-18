# classrecord_management_app

An offline Flutter Windows Grade Management System for subject, student,
attendance, assessment, grade, ranking, and report management.

## Development status

- Phase 1: Desktop navigation and dashboard foundation completed.
- Phase 2: Drift/SQLite database foundation completed.
- Phase 3: Academic and subject management completed.
- Phase 4: Student management and subject enrollment completed.
- Phase 5: Grade sheet structure and score/attendance entry completed.
- Phase 6: Grade computation, configurable weights, term grades, and rankings completed.

## Database

The application stores its SQLite database in:

`%APPDATA%\GradeManagementSystem\grade_management.db`

Database backups use:

`%APPDATA%\GradeManagementSystem\backups\`

## Run and test

```powershell
flutter pub get
dart run build_runner build
flutter analyze
flutter test
flutter run -d windows
```
