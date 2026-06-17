import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portal i Studentëve',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D0E15),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00ADB5),
          secondary: Color(0xFF393E46),
          surface: Color(0xFF1A1C29),
          background: Color(0xFF0D0E15),
          error: Color(0xFFFF2E93),
        ),
        useMaterial3: true,
        fontFamily: 'Inter',
        cardTheme: CardTheme(
          color: const Color(0xFF1A1C29),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFF2D3142), width: 1),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1A1C29),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF2D3142)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF00ADB5), width: 2),
          ),
        ),
      ),
      home: const StudentPortalScreen(),
    );
  }
}

class Student {
  final String id;
  final String name;
  final String email;
  final String department;
  final double gpa;

  const Student({
    required this.id,
    required this.name,
    required this.email,
    required this.department,
    required this.gpa,
  });
}

class StudentPortalScreen extends StatefulWidget {
  const StudentPortalScreen({super.key});

  @override
  State<StudentPortalScreen> createState() => _StudentPortalScreenState();
}

class _StudentPortalScreenState extends State<StudentPortalScreen> {
  final List<Student> _students = [
    const Student(
      id: "102345",
      name: "Dones Ismaili",
      email: "dones.ismaili@student.uni.edu",
      department: "Shkenca Kompjuterike",
      gpa: 9.6,
    ),
    const Student(
      id: "102890",
      name: "Arbenita Gashi",
      email: "arbenita.gashi@student.uni.edu",
      department: "Inxhinieri Softuerike",
      gpa: 8.9,
    ),
    const Student(
      id: "103112",
      name: "Valon Kastrati",
      email: "valon.kastrati@student.uni.edu",
      department: "Matematikë",
      gpa: 7.2,
    ),
    const Student(
      id: "104230",
      name: "Elsa Morina",
      email: "elsa.morina@student.uni.edu",
      department: "Fizikë",
      gpa: 9.1,
    ),
  ];

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _idController = TextEditingController();
  final _gpaController = TextEditingController();

  String? _selectedDepartment = "Shkenca Kompjuterike";
  final List<String> _departments = [
    "Shkenca Kompjuterike",
    "Inxhinieri Softuerike",
    "Matematikë",
    "Fizikë",
    "Elektroteknikë"
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _idController.dispose();
    _gpaController.dispose();
    super.dispose();
  }

  // ── Validators (Commit 3) ──────────────────────────────────────────────────

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Emri nuk mund të jetë bosh.';
    }
    if (value.trim().length < 3) {
      return 'Emri duhet të ketë të paktën 3 karaktere.';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email-i nuk mund të jetë bosh.';
    }
    final emailRegex = RegExp(r'^[\w.+-]+@[\w-]+\.[a-z]{2,}$', caseSensitive: false);
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Shkruani një email të vlefshëm (p.sh. emri@domain.com).';
    }
    return null;
  }

  String? _validateStudentId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'ID e studentit nuk mund të jetë bosh.';
    }
    final idRegex = RegExp(r'^\d{6}$');
    if (!idRegex.hasMatch(value.trim())) {
      return 'ID duhet të jetë saktësisht 6 shifra (p.sh. 104523).';
    }
    return null;
  }

  String? _validateGpa(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'GPA nuk mund të jetë bosh.';
    }
    final gpa = double.tryParse(value.trim());
    if (gpa == null) {
      return 'Shkruani një numër të vlefshëm (p.sh. 8.5).';
    }
    if (gpa < 1.0 || gpa > 10.0) {
      return 'GPA duhet të jetë ndërmjet 1.0 dhe 10.0.';
    }
    return null;
  }

  // ── Submit (Commit 3) ──────────────────────────────────────────────────────

  void _submitForm({required bool isBottomSheet}) {
    // Trigger all field validators via the Form key
    if (!_formKey.currentState!.validate()) {
      return; // Validators already display inline error messages
    }

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final id = _idController.text.trim();
    final gpa = double.parse(_gpaController.text.trim());

    setState(() {
      _students.add(Student(
        id: id,
        name: name,
        email: email,
        department: _selectedDepartment ?? 'Shkenca Kompjuterike',
        gpa: gpa,
      ));
      _nameController.clear();
      _emailController.clear();
      _idController.clear();
      _gpaController.clear();
      _selectedDepartment = 'Shkenca Kompjuterike';
    });

    if (isBottomSheet) Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Studenti $name u regjistrua me sukses! ✓'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _openAddStudentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1C29),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: SingleChildScrollView(
          child: _buildStudentForm(isBottomSheet: true),
        ),
      ),
    );
  }

  Widget _buildStudentForm({required bool isBottomSheet}) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                Icons.person_add_alt_1_outlined,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                "Shto Student të Ri",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _nameController,
            textCapitalization: TextCapitalization.words,
            validator: _validateName,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: 'Emri dhe Mbiemri',
              hintText: 'p.sh. Valon Kastrati',
              prefixIcon: const Icon(Icons.person_outline),
              errorStyle: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: _validateEmail,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: 'Email Adresa',
              hintText: 'emri@student.uni.edu',
              prefixIcon: const Icon(Icons.email_outlined),
              errorStyle: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _idController,
            keyboardType: TextInputType.number,
            validator: _validateStudentId,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLength: 6,
            decoration: InputDecoration(
              labelText: 'ID e Studentit (6 shifra)',
              hintText: 'p.sh. 104523',
              prefixIcon: const Icon(Icons.badge_outlined),
              counterText: '',
              errorStyle: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _selectedDepartment,
            decoration: const InputDecoration(
              labelText: 'Departamenti',
              prefixIcon: Icon(Icons.account_balance_outlined),
            ),
            dropdownColor: const Color(0xFF1A1C29),
            items: _departments.map((dept) {
              return DropdownMenuItem(
                value: dept,
                child: Text(dept),
              );
            }).toList(),
            onChanged: (val) {
              setState(() => _selectedDepartment = val);
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _gpaController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: _validateGpa,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: 'GPA / Nota Mesatare',
              hintText: '1.0 – 10.0',
              prefixIcon: const Icon(Icons.grade_outlined),
              errorStyle: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => _submitForm(isBottomSheet: isBottomSheet),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, size: 20),
                SizedBox(width: 8),
                Text(
                  "Regjistro Studentin",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int totalStudents = _students.length;
    final double avgGpa = _students.isEmpty
        ? 0.0
        : _students.map((s) => s.gpa).reduce((a, b) => a + b) / totalStudents;
    final bool isDesktop = MediaQuery.of(context).size.width > 768;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.school_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Portal i Studentëve',
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.8),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: !isDesktop
          ? FloatingActionButton(
              onPressed: () => _openAddStudentBottomSheet(context),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.black,
              child: const Icon(Icons.add),
            )
          : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDashboardStats(totalStudents, avgGpa),
                  const SizedBox(height: 30),
                  Text(
                    'Regjistri i Studentëve',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(height: 15),
                  isDesktop
                      ? _buildStudentGrid(_students)
                      : _buildStudentList(_students),
                ],
              ),
            ),
          ),
          if (isDesktop) ...[
            const VerticalDivider(width: 1, color: Color(0xFF2D3142)),
            Container(
              width: 360,
              height: double.infinity,
              padding: const EdgeInsets.all(24),
              color: const Color(0xFF141520),
              child: SingleChildScrollView(
                child: _buildStudentForm(isBottomSheet: false),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDashboardStats(int total, double avgGpa) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final int crossAxisCount = width > 600 ? 3 : 1;
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: width > 600 ? 2.5 : 3.5,
          children: [
            _buildStatCard(
              "Totali i Studentëve",
              total.toString(),
              Icons.people_alt_rounded,
              const Color(0xFF00ADB5),
            ),
            _buildStatCard(
              "GPA Mesatare",
              avgGpa.toStringAsFixed(2),
              Icons.analytics_rounded,
              const Color(0xFFFF2E93),
            ),
            _buildStatCard(
              "Departamenti Kryesor",
              "SHK",
              Icons.account_balance_rounded,
              const Color(0xFFFFC045),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color highlightColor) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1C29),
              highlightColor.withOpacity(0.04),
            ],
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: highlightColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: highlightColor, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF9E9E9E),
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentGrid(List<Student> students) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 2.2,
      ),
      itemCount: students.length,
      itemBuilder: (context, index) {
        return _buildStudentCard(students[index]);
      },
    );
  }

  Widget _buildStudentList(List<Student> students) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: students.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: _buildStudentCard(students[index]),
        );
      },
    );
  }

  Widget _buildStudentCard(Student student) {
    final Color badgeColor = student.gpa >= 9.0
        ? const Color(0xFF00ADB5)
        : student.gpa >= 8.0
            ? const Color(0xFFFFC045)
            : const Color(0xFFFF2E93);

    final String badgeText = student.gpa >= 9.0
        ? "Shkëlqyeshëm"
        : student.gpa >= 8.0
            ? "Shumë Mirë"
            : "Mirë";

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              child: Text(
                student.name.isNotEmpty ? student.name[0].toUpperCase() : 'S',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          student.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: badgeColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.solid(color: badgeColor, width: 0.5),
                        ),
                        child: Text(
                          badgeText,
                          style: TextStyle(
                            fontSize: 10,
                            color: badgeColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    student.email,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF9E9E9E),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "DEPARTAMENTI",
                            style: TextStyle(
                              fontSize: 9,
                              color: Color(0xFF6E7182),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            student.department,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "NOTAT (GPA)",
                            style: TextStyle(
                              fontSize: 9,
                              color: Color(0xFF6E7182),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            student.gpa.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 13,
                              color: badgeColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
