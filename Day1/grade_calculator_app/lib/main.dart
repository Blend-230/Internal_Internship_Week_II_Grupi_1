import 'package:flutter/material.dart';

void main() {
  runApp(const GradeCalculatorApp());
}

class GradeCalculatorApp extends StatelessWidget {
  const GradeCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Llogaritësi i Notave',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  // Global key for the form to handle validation
  final _formKey = GlobalKey<FormState>();

  // Text controllers for the grade inputs
  final TextEditingController _mathController = TextEditingController();
  final TextEditingController _progController = TextEditingController();
  final TextEditingController _physController = TextEditingController();

  // State variables for results
  double? _average;
  String? _status;
  Color? _statusColor;

  @override
  void dispose() {
    _mathController.dispose();
    _progController.dispose();
    _physController.dispose();
    super.dispose();
  }

  // Calculation Logic
  void _calculate() {
    if (_formKey.currentState!.validate()) {
      final double math = double.parse(_mathController.text);
      final double prog = double.parse(_progController.text);
      final double phys = double.parse(_physController.text);

      final double avg = (math + prog + phys) / 3.0;

      setState(() {
        _average = avg;
        if (avg >= 6.0) {
          _status = "Kalon";
          _statusColor = Colors.greenAccent.shade400;
        } else {
          _status = "Duhet përmirësim";
          _statusColor = Colors.orangeAccent.shade400;
        }
      });
    }
  }

  // Reset Logic
  void _reset() {
    _mathController.clear();
    _progController.clear();
    _physController.clear();
    setState(() {
      _average = null;
      _status = null;
      _statusColor = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0A192F), // Dark Teal/Navy
              Color(0xFF172A45), // Lighter Deep Blue
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 450),
                child: Card(
                  elevation: 16,
                  shadowColor: Colors.black.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  color: Colors.white.withOpacity(0.04), // Glassmorphism
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white.withOpacity(0.08),
                          width: 1.5,
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.07),
                            Colors.white.withOpacity(0.02),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // ICON & HEADER
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.calculate_rounded,
                                  size: 40,
                                  color: Colors.tealAccent,
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'Grade Calculator',
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Llogaritni mesataren e notave tuaja',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white60,
                              ),
                            ),
                            const SizedBox(height: 28),

                            // MATH FIELD
                            _buildGradeField(
                              controller: _mathController,
                              label: 'Matematikë (Nota 1-10)',
                              icon: Icons.functions_rounded,
                            ),
                            const SizedBox(height: 16),

                            // PROGRAMMING FIELD
                            _buildGradeField(
                              controller: _progController,
                              label: 'Programim (Nota 1-10)',
                              icon: Icons.code_rounded,
                            ),
                            const SizedBox(height: 16),

                            // PHYSICS FIELD
                            _buildGradeField(
                              controller: _physController,
                              label: 'Fizikë (Nota 1-10)',
                              icon: Icons.science_rounded,
                            ),
                            const SizedBox(height: 28),

                            // ACTION BUTTONS (Row containing Calculate and Reset)
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: ElevatedButton(
                                    onPressed: _calculate,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.tealAccent.shade400,
                                      foregroundColor: Colors.black,
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 4,
                                    ),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.query_stats_rounded, size: 20),
                                        SizedBox(width: 8),
                                        Text(
                                          'Llogarit',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  flex: 1,
                                  child: OutlinedButton(
                                    onPressed: _reset,
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.white70,
                                      side: BorderSide(color: Colors.white.withOpacity(0.12)),
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      'Fshi',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // RESULTS AREA WITH MICRO-ANIMATION
                            AnimatedOpacity(
                              opacity: _average != null ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 400),
                              child: _average != null
                                  ? Column(
                                      children: [
                                        const SizedBox(height: 28),
                                        const Divider(color: Colors.white10),
                                        const SizedBox(height: 20),
                                        Container(
                                          padding: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            color: Colors.black26,
                                            borderRadius: BorderRadius.circular(16),
                                            border: Border.all(
                                              color: _statusColor!.withOpacity(0.15),
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              const Text(
                                                'MESATARJA JUAJ',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w800,
                                                  letterSpacing: 1.5,
                                                  color: Colors.white60,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                _average!.toStringAsFixed(2),
                                                style: const TextStyle(
                                                  fontSize: 48,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.white,
                                                  letterSpacing: -1,
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              // STATUS BADGE
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                  vertical: 8,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: _statusColor!.withOpacity(0.12),
                                                  borderRadius: BorderRadius.circular(20),
                                                  border: Border.all(
                                                    color: _statusColor!.withOpacity(0.4),
                                                  ),
                                                ),
                                                child: Text(
                                                  _status!,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: _statusColor,
                                                    letterSpacing: 0.5,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Textfield Builder Helper with Validation logic
  Widget _buildGradeField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white50, fontSize: 14),
        prefixIcon: Icon(icon, color: Colors.tealAccent.shade200, size: 20),
        filled: true,
        fillColor: Colors.black26,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.tealAccent, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.redAccent.shade200),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.redAccent.shade200, width: 1.5),
        ),
        errorStyle: TextStyle(color: Colors.redAccent.shade100),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Kjo fushë nuk mund të jetë e zbrazët';
        }
        final double? grade = double.tryParse(value);
        if (grade == null) {
          return 'Ju lutem shkruani një numër të vlefshëm';
        }
        if (grade < 1.0 || grade > 10.0) {
          return 'Nota duhet të jetë ndërmjet 1.0 dhe 10.0';
        }
        return null;
      },
    );
  }
}
