# Final Task Manager

Flutter MVP for Internal Internship - Day 5.

## Target and MVP

- Target: mobile and web.
- View and filter a task list.
- Add and validate a new task.
- Open details, edit, complete, and delete a task.

## Structure

```text
lib/
  main.dart
  models/task.dart
  screens/
    task_list_screen.dart
    task_form_screen.dart
    task_detail_screen.dart
  services/task_service.dart
```

`TaskService` owns the in-memory list and CRUD operations. Screens use
`Navigator.push` to move between the list, form, and details. Each screen calls
`setState` after a change so Flutter rebuilds the visible data.

## Run

```bash
flutter pub get
flutter run
```

## Demo plan (2-3 minutes)

1. Show counters and hide/show completed tasks.
2. Create a task and demonstrate form validation.
3. Open details, edit the task, mark it complete, and delete it.
4. Briefly explain the model, service, navigation, and state updates.

## Technical reflection

The MVP separates data, business logic, and UI, which makes the project easier
to extend. Data currently lives in memory and resets when the app closes.
Local persistence with Hive/shared_preferences or a REST API is the clearest
next improvement.
