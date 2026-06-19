import '../models/task.dart';

class TaskService {
  TaskService._();

  static final TaskService instance = TaskService._();

  final List<Task> _tasks = [
    Task(
      id: 1,
      title: 'Prepare project demo',
      description: 'Explain the MVP, navigation, state, and main code.',
      priority: TaskPriority.high,
      createdAt: DateTime.now(),
    ),
    Task(
      id: 2,
      title: 'Write README',
      description: 'Document features, structure, and run commands.',
      priority: TaskPriority.medium,
      createdAt: DateTime.now(),
      isCompleted: true,
    ),
  ];

  int _nextId = 3;

  List<Task> get tasks => List.unmodifiable(_tasks);

  void addTask({
    required String title,
    required String description,
    required TaskPriority priority,
  }) {
    _tasks.add(
      Task(
        id: _nextId++,
        title: title,
        description: description,
        priority: priority,
        createdAt: DateTime.now(),
      ),
    );
  }

  void updateTask(
    Task task, {
    required String title,
    required String description,
    required TaskPriority priority,
  }) {
    task
      ..title = title
      ..description = description
      ..priority = priority;
  }

  void toggleTask(Task task) => task.isCompleted = !task.isCompleted;

  void deleteTask(Task task) => _tasks.remove(task);
}
