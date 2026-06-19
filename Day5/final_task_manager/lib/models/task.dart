enum TaskPriority { low, medium, high }

class Task {
  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.createdAt,
    this.isCompleted = false,
  });

  final int id;
  String title;
  String description;
  TaskPriority priority;
  final DateTime createdAt;
  bool isCompleted;
}
