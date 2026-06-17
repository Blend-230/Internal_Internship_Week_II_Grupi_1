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
  // Hardcoded mockup data for Commit 1
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

  @override
  Widget build(BuildContext context) {
    // Basic stats calculations
    final int totalStudents = _students.length;
    final double avgGpa = _students.isEmpty
        ? 0.0
        : _students.map((s) => s.gpa).reduce((a, b) => a + b) / totalStudents;

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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isDesktop = constraints.maxWidth > 768;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top dashboard stats
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
          );
        },
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
