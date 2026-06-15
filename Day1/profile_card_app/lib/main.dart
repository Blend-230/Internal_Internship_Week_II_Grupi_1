import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Art Halili Profile',
      home: Scaffold(
        backgroundColor: const Color(0xFFEAF4F4),
        appBar: AppBar(
          title: const Text('Profile Card'),
          centerTitle: true,
          backgroundColor: const Color(0xFF0F766E),
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Container(
            width: 340,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 14,
                  color: Color(0x33000000),
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 48,
                  backgroundColor: Color(0xFF0F766E),
                  child: Icon(
                    Icons.code,
                    size: 52,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Art Halili',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF12312F),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Flutter Student Developer',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 22),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.email, color: Color(0xFF0F766E)),
                    SizedBox(width: 8),
                    Text('art.halili@bgt.school'),
                  ],
                ),
                const SizedBox(height: 12),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.school, color: Color(0xFF0F766E)),
                    SizedBox(width: 8),
                    Text('BGT Internal Internship'),
                  ],
                ),
                const SizedBox(height: 22),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on, color: Color(0xFF0F766E)),
                    SizedBox(width: 8),
                    Text('Prishtina, Kosovo'),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F766E),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Contact Art'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
