import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      home: const ProfileCardPage(),
    );
  }
}

class ProfileCardPage extends StatelessWidget {
  const ProfileCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background with a subtle gradient
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0F0C1B), // Deep Space Blue/Purple
              Color(0xFF201335), // Dark Amethyst
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                elevation: 12,
                shadowColor: Colors.black.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                color: Colors.white.withOpacity(0.05), // Glassmorphism effect background
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                        width: 1.5,
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.08),
                          Colors.white.withOpacity(0.02),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                    width: 350,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // PROFILE PICTURE / AVATAR
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.deepPurpleAccent.shade200,
                              width: 3.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.deepPurpleAccent.withOpacity(0.3),
                                blurRadius: 15,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage('assets/images/profile_avatar.png'),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // NAME
                        const Text(
                          'Dones Ismaili',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),

                        // ROLE
                        Text(
                          'Flutter Developer Intern',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.deepPurpleAccent.shade100,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // DESCRIPTION / BIO
                        Text(
                          'Passionate about crafting beautiful, high-performance cross-platform mobile apps. Intern at BGT School.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.4,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // ROW OF SOCIALS/CONTACTS (Requirement: at least one Row)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildSocialIcon(
                              icon: Icons.email_rounded,
                              label: 'Email',
                              onPressed: () {},
                            ),
                            const SizedBox(width: 16),
                            _buildSocialIcon(
                              icon: Icons.code_rounded,
                              label: 'GitHub',
                              onPressed: () {},
                            ),
                            const SizedBox(width: 16),
                            _buildSocialIcon(
                              icon: Icons.business_center_rounded,
                              label: 'LinkedIn',
                              onPressed: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),

                        // STATS / SKILLS COLUMN (Requirement: at least one Column inside)
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Skills & Tech Stack',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 12),
                              _buildSkillRow('Dart & Flutter', 0.85),
                              const SizedBox(height: 8),
                              _buildSkillRow('C Language', 0.70),
                              const SizedBox(height: 8),
                              _buildSkillRow('UI/UX Design', 0.80),
                            ],
                          ),
                        ),
                        const SizedBox(height: 28),

                        // ELEVATED BUTTON
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.send_rounded, size: 18),
                          label: const Text('Contact Me'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurpleAccent.shade200,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                          ),
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
    );
  }

  // Helper widget to build social icons
  Widget _buildSocialIcon({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Tooltip(
      message: label,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white10),
        ),
        child: IconButton(
          icon: Icon(icon, color: Colors.white70),
          onPressed: onPressed,
        ),
      ),
    );
  }

  // Helper widget to build skill rows with progress bars
  Widget _buildSkillRow(String skill, double level) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          skill,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.white60,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: level,
              backgroundColor: Colors.white10,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent.shade100),
              minHeight: 6,
            ),
          ),
        ),
      ],
    );
  }
}
