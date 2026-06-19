import 'package:flutter/material.dart';

import '../models/task.dart';
import '../services/task_service.dart';
import 'task_detail_screen.dart';
import 'task_form_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final _service = TaskService.instance;
  bool _showCompleted = true;

  List<Task> get visibleTasks => _service.tasks
      .where((task) => _showCompleted || !task.isCompleted)
      .toList();

  Future<void> _openForm() async {
    final changed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const TaskFormScreen()),
    );
    if (changed == true) setState(() {});
  }

  Future<void> _openDetails(Task task) async {
    await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => TaskDetailScreen(task: task)),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final completed = _service.tasks.where((task) => task.isCompleted).length;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Task Manager'),
        actions: [
          IconButton(
            tooltip: _showCompleted ? 'Hide completed' : 'Show completed',
            onPressed: () => setState(() => _showCompleted = !_showCompleted),
            icon: Icon(
              _showCompleted ? Icons.visibility : Icons.visibility_off,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openForm,
        icon: const Icon(Icons.add),
        label: const Text('New task'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: ListTile(
                    leading: const Icon(Icons.insights),
                    title: Text('${_service.tasks.length} total tasks'),
                    subtitle: Text('$completed completed'),
                  ),
                ),
              ),
              Expanded(
                child: visibleTasks.isEmpty
                    ? const Center(child: Text('No tasks to display.'))
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                        itemCount: visibleTasks.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (_, index) {
                          final task = visibleTasks[index];
                          return Card(
                            child: ListTile(
                              onTap: () => _openDetails(task),
                              leading: Checkbox(
                                value: task.isCompleted,
                                onChanged: (_) {
                                  _service.toggleTask(task);
                                  setState(() {});
                                },
                              ),
                              title: Text(
                                task.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: task.isCompleted
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                              subtitle: Text(
                                '${task.priority.name.toUpperCase()} priority',
                              ),
                              trailing: const Icon(Icons.chevron_right),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
