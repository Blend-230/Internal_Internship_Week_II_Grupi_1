import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const GradeCalculatorApp());
}

class GradeCalculatorApp extends StatelessWidget {
  const GradeCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grade Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF635BFF),
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F5FA),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const GradeCalculatorScreen(),
    );
  }
}

class GradeCalculatorScreen extends StatefulWidget {
  const GradeCalculatorScreen({super.key});

  @override
  State<GradeCalculatorScreen> createState() => _GradeCalculatorScreenState();
}

class _GradeCalculatorScreenState extends State<GradeCalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _gradeControllers = List.generate(3, (_) => TextEditingController());

  double? _average;

  @override
  void dispose() {
    for (final controller in _gradeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String? _validateGrade(String? value) {
    final trimmedValue = value?.trim() ?? '';

    if (trimmedValue.isEmpty) {
      return 'Vendosni nje vlere';
    }

    final grade = double.tryParse(trimmedValue);
    if (grade == null) {
      return 'Vendosni nje numer valid';
    }

    if (grade < 0 || grade > 100) {
      return 'Vlera duhet te jete 0-100';
    }

    return null;
  }

  void _calculateAverage() {
    if (!_formKey.currentState!.validate()) {
      setState(() => _average = null);
      return;
    }

    final grades = _gradeControllers
        .map((controller) => double.parse(controller.text.trim()))
        .toList();

    setState(() {
      _average = grades.reduce((first, second) => first + second) / grades.length;
    });
  }

  void _clearValues() {
    for (final controller in _gradeControllers) {
      controller.clear();
    }
    setState(() => _average = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grade Calculator'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 760),
                  child: Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(28),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const CalculatorHeader(),
                            const SizedBox(height: 28),
                            GradeFields(
                              controllers: _gradeControllers,
                              validator: _validateGrade,
                              useHorizontalLayout: constraints.maxWidth >= 720,
                            ),
                            const SizedBox(height: 24),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                FilledButton.icon(
                                  onPressed: _calculateAverage,
                                  icon: const Icon(Icons.calculate_outlined),
                                  label: const Text('Llogarit mesataren'),
                                ),
                                OutlinedButton.icon(
                                  onPressed: _clearValues,
                                  icon: const Icon(Icons.refresh),
                                  label: const Text('Pastro'),
                                ),
                              ],
                            ),
                            if (_average case final average?) ...[
                              const SizedBox(height: 28),
                              ResultCard(average: average),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CalculatorHeader extends StatelessWidget {
  const CalculatorHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            Icons.school_outlined,
            color: Theme.of(context).colorScheme.primary,
            size: 32,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Llogarit mesataren',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              const Text('Vendosni tri nota ose pike nga 0 deri ne 100.'),
            ],
          ),
        ),
      ],
    );
  }
}

class GradeFields extends StatelessWidget {
  const GradeFields({
    required this.controllers,
    required this.validator,
    required this.useHorizontalLayout,
    super.key,
  });

  final List<TextEditingController> controllers;
  final String? Function(String?) validator;
  final bool useHorizontalLayout;

  @override
  Widget build(BuildContext context) {
    final fields = List.generate(
      controllers.length,
      (index) => GradeField(
        controller: controllers[index],
        label: 'Vlera ${index + 1}',
        validator: validator,
      ),
    );

    if (useHorizontalLayout) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var index = 0; index < fields.length; index++) ...[
            Expanded(child: fields[index]),
            if (index < fields.length - 1) const SizedBox(width: 14),
          ],
        ],
      );
    }

    return Column(
      children: [
        for (var index = 0; index < fields.length; index++) ...[
          fields[index],
          if (index < fields.length - 1) const SizedBox(height: 14),
        ],
      ],
    );
  }
}

class GradeField extends StatelessWidget {
  const GradeField({
    required this.controller,
    required this.label,
    required this.validator,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.numbers),
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      ],
      validator: validator,
    );
  }
}

class ResultCard extends StatelessWidget {
  const ResultCard({required this.average, super.key});

  final double average;

  @override
  Widget build(BuildContext context) {
    final hasPassed = average >= 50;
    final resultColor = hasPassed ? Colors.green : Colors.orange;
    final status = hasPassed ? 'Kalon' : 'Duhet permiresim';

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: resultColor.withOpacity(0.12),
        border: Border.all(color: resultColor),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(
            hasPassed ? Icons.check_circle_outline : Icons.trending_up,
            color: resultColor,
            size: 42,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mesatarja: ${average.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  status,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: resultColor,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
