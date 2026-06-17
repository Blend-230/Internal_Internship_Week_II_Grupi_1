import 'package:flutter/material.dart';

void main() {
  runApp(const TaskTrackerApp());
}

class TaskTrackerApp extends StatelessWidget {
  const TaskTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
        ),
        useMaterial3: true,
      ),
      home: const TaskTrackerScreen(),
    );
  }
}

class TaskItem {
  TaskItem({
    required this.title,
    required this.description,
    this.isDone = false,
  });

  final String title;
  final String description;
  bool isDone;
}

class TaskTrackerScreen extends StatefulWidget {
  const TaskTrackerScreen({super.key});

  @override
  State<TaskTrackerScreen> createState() => _TaskTrackerScreenState();
}

class _TaskTrackerScreenState extends State<TaskTrackerScreen> {
  final List<TaskItem> tasks = [
    TaskItem(
      title: 'Read Day 3 material',
      description: 'Review state management and navigation examples.',
      isDone: true,
    ),
    TaskItem(
      title: 'Build tracker UI',
      description: 'Create add, complete, delete, and count features.',
    ),
  ];

  int get completedTasks => tasks.where((task) => task.isDone).length;
  int get activeTasks => tasks.length - completedTasks;

  void showAddTaskDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Add New Task'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Task title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Title is required.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: descriptionController,
                  minLines: 2,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton.icon(
              onPressed: () {
                final isValid = formKey.currentState?.validate() ?? false;
                if (!isValid) return;

                setState(() {
                  tasks.add(
                    TaskItem(
                      title: titleController.text.trim(),
                      description: descriptionController.text.trim().isEmpty
                          ? 'No description added.'
                          : descriptionController.text.trim(),
                    ),
                  );
                });

                Navigator.of(dialogContext).pop();
                showMessage('Task added successfully.');
              },
              icon: const Icon(Icons.add),
              label: const Text('Add'),
            ),
          ],
        );
      },
    ).whenComplete(() {
      titleController.dispose();
      descriptionController.dispose();
    });
  }

  void toggleTaskStatus(int index) {
    setState(() {
      tasks[index].isDone = !tasks[index].isDone;
    });

    showMessage(
      tasks[index].isDone ? 'Task marked as done.' : 'Task marked as active.',
    );
  }

  void deleteTask(int index) {
    final deletedTask = tasks[index];

    setState(() {
      tasks.removeAt(index);
    });

    showMessage('${deletedTask.title} deleted.');
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Task Tracker'),
        centerTitle: true,
        backgroundColor: const Color(0xFF2563EB),
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showAddTaskDialog,
        icon: const Icon(Icons.add_task),
        label: const Text('Add Task'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 820),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      TrackerStat(label: 'Total', value: tasks.length),
                      TrackerStat(label: 'Active', value: activeTasks),
                      TrackerStat(label: 'Done', value: completedTasks),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: tasks.isEmpty
                        ? const EmptyTaskView()
                        : ListView.separated(
                            itemCount: tasks.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 10),
                            itemBuilder: (context, index) {
                              final task = tasks[index];
                              return TaskTile(
                                task: task,
                                onToggle: () => toggleTaskStatus(index),
                                onDelete: () => deleteTask(index),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TrackerStat extends StatelessWidget {
  const TrackerStat({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$value',
                style: const TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
  });

  final TaskItem task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Checkbox(
          value: task.isDone,
          onChanged: (_) => onToggle(),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            decoration: task.isDone ? TextDecoration.lineThrough : null,
            color: task.isDone ? const Color(0xFF64748B) : null,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(task.description),
        ),
        trailing: IconButton(
          tooltip: 'Delete task',
          onPressed: onDelete,
          icon: const Icon(Icons.delete_outline),
        ),
      ),
    );
  }
}

class EmptyTaskView extends StatelessWidget {
  const EmptyTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.task_alt, size: 64, color: Color(0xFF94A3B8)),
          SizedBox(height: 12),
          Text(
            'No tasks yet.',
            style: TextStyle(
              color: Color(0xFF475569),
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
