import 'package:flutter/material.dart';

import 'screens/task_list_screen.dart';

void main() => runApp(const FinalTaskManagerApp());

class FinalTaskManagerApp extends StatelessWidget {
  const FinalTaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Final Task Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F46E5)),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        useMaterial3: true,
      ),
      home: const TaskListScreen(),
    );
  }
}
