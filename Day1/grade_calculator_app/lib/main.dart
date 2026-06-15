import 'package:flutter/material.dart';

void main() {
  runApp(const GradeCalculatorApp());
}

class GradeCalculatorApp extends StatelessWidget {
  const GradeCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grade Calculator',
      home: GradeCalculatorScreen(),
    );
  }
}

class GradeCalculatorScreen extends StatefulWidget {
  const GradeCalculatorScreen({super.key});

  @override
  State<GradeCalculatorScreen> createState() => _GradeCalculatorScreenState();
}

class _GradeCalculatorScreenState extends State<GradeCalculatorScreen> {
  final firstGradeController = TextEditingController();
  final secondGradeController = TextEditingController();
  final thirdGradeController = TextEditingController();

  String resultText = 'Enter three grades to calculate the average.';
  String statusText = '';
  bool hasError = false;

  @override
  void dispose() {
    firstGradeController.dispose();
    secondGradeController.dispose();
    thirdGradeController.dispose();
    super.dispose();
  }

  void calculateAverage() {
    final firstGrade = double.tryParse(firstGradeController.text.trim());
    final secondGrade = double.tryParse(secondGradeController.text.trim());
    final thirdGrade = double.tryParse(thirdGradeController.text.trim());

    if (firstGrade == null || secondGrade == null || thirdGrade == null) {
      setState(() {
        hasError = true;
        resultText = 'Please fill all fields with valid numbers.';
        statusText = '';
      });
      return;
    }

    final average = (firstGrade + secondGrade + thirdGrade) / 3;
    final passed = average >= 50;

    setState(() {
      hasError = false;
      resultText = 'Average: ${average.toStringAsFixed(2)}';
      statusText = passed ? 'Kalon' : 'Duhet permiresim';
    });
  }

  void clearFields() {
    firstGradeController.clear();
    secondGradeController.clear();
    thirdGradeController.clear();

    setState(() {
      hasError = false;
      resultText = 'Enter three grades to calculate the average.';
      statusText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final panelWidth = screenWidth < 520 ? screenWidth - 32 : 460.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F7FB),
      appBar: AppBar(
        title: const Text('Grade Calculator'),
        centerTitle: true,
        backgroundColor: const Color(0xFF1D4ED8),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              width: panelWidth,
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.calculate,
                    size: 56,
                    color: Color(0xFF1D4ED8),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Average Grade',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF172554),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Write three numeric grades or points.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 24),
                  GradeInputField(
                    controller: firstGradeController,
                    label: 'First grade',
                  ),
                  const SizedBox(height: 14),
                  GradeInputField(
                    controller: secondGradeController,
                    label: 'Second grade',
                  ),
                  const SizedBox(height: 14),
                  GradeInputField(
                    controller: thirdGradeController,
                    label: 'Third grade',
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: calculateAverage,
                          icon: const Icon(Icons.check),
                          label: const Text('Calculate'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1D4ED8),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      IconButton.filledTonal(
                        onPressed: clearFields,
                        icon: const Icon(Icons.refresh),
                        tooltip: 'Clear fields',
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: hasError
                          ? const Color(0xFFFEE2E2)
                          : const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: hasError
                            ? const Color(0xFFDC2626)
                            : const Color(0xFF93C5FD),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          resultText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: hasError
                                ? const Color(0xFF991B1B)
                                : const Color(0xFF1E3A8A),
                          ),
                        ),
                        if (statusText.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Status: $statusText',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: statusText == 'Kalon'
                                  ? const Color(0xFF15803D)
                                  : const Color(0xFFB45309),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ],
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

class GradeInputField extends StatelessWidget {
  const GradeInputField({
    super.key,
    required this.controller,
    required this.label,
  });

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.grade),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
