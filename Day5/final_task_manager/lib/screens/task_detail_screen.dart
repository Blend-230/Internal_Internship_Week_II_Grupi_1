import 'package:flutter/material.dart';

import '../models/task.dart';
import '../services/task_service.dart';
import 'task_form_screen.dart';

class TaskDetailScreen extends StatefulWidget {
  const TaskDetailScreen({super.key, required this.task});

  final Task task;

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  Future<void> _edit() async {
    final changed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => TaskFormScreen(task: widget.task)),
    );
    if (changed == true) setState(() {});
  }

  void _toggle() {
    TaskService.instance.toggleTask(widget.task);
    setState(() {});
  }

  void _delete() {
    TaskService.instance.deleteTask(widget.task);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task details'),
        actions: [
          IconButton(onPressed: _edit, icon: const Icon(Icons.edit_outlined)),
          IconButton(onPressed: _delete, icon: const Icon(Icons.delete_outline)),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Icon(
                task.isCompleted ? Icons.task_alt : Icons.pending_actions,
                size: 72,
                color: task.isCompleted ? Colors.green : Colors.indigo,
              ),
              const SizedBox(height: 20),
              Text(
                task.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(task.description),
                      const Divider(height: 32),
                      Text('Priority: ${task.priority.name.toUpperCase()}'),
                      const SizedBox(height: 8),
                      Text(
                        'Status: ${task.isCompleted ? 'Completed' : 'Active'}',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _toggle,
                icon: Icon(task.isCompleted ? Icons.undo : Icons.check),
                label: Text(
                  task.isCompleted ? 'Mark as active' : 'Mark as completed',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
