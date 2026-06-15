import 'package:flutter/material.dart';

void main() {
  runApp(const ProfileCardApp());
}

class ProfileCardApp extends StatelessWidget {
  const ProfileCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile Card',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF365CF5),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F6FC),
        useMaterial3: true,
      ),
      home: const ProfileCardScreen(),
    );
  }
}

class ProfileCardScreen extends StatelessWidget {
  const ProfileCardScreen({super.key});

  void _showContactMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Thanks for reaching out to Andi!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Card'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 720;
            final cardWidth = isDesktop ? 680.0 : constraints.maxWidth;

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: cardWidth),
                  child: Card(
                    elevation: 0,
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFFFFFFF),
                            Color(0xFFE8EDFF),
                          ],
                        ),
                      ),
                      child: isDesktop
                          ? Row(
                              children: [
                                const ProfileAvatar(size: 180),
                                const SizedBox(width: 36),
                                Expanded(
                                  child: ProfileDetails(
                                    onContactPressed: () =>
                                        _showContactMessage(context),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                const ProfileAvatar(size: 140),
                                const SizedBox(height: 24),
                                ProfileDetails(
                                  onContactPressed: () =>
                                      _showContactMessage(context),
                                ),
                              ],
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

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({required this.size, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.person_rounded,
        size: size * 0.62,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({required this.onContactPressed, super.key});

  final VoidCallback onContactPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Andi Ademaj',
          style: textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Flutter Developer',
          style: textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'I enjoy building clean, responsive applications and turning ideas '
          'into useful digital experiences.',
          style: textTheme.bodyLarge?.copyWith(height: 1.5),
        ),
        const SizedBox(height: 22),
        const Wrap(
          spacing: 18,
          runSpacing: 12,
          children: [
            ContactItem(
              icon: Icons.email_outlined,
              label: 'aa212@bgt.school',
            ),
            ContactItem(
              icon: Icons.location_on_outlined,
              label: 'Tirane, Albania',
            ),
          ],
        ),
        const SizedBox(height: 26),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onContactPressed,
            icon: const Icon(Icons.chat_bubble_outline),
            label: const Text('Contact me'),
          ),
        ),
      ],
    );
  }
}

class ContactItem extends StatelessWidget {
  const ContactItem({
    required this.icon,
    required this.label,
    super.key,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}
