import 'package:flutter/material.dart';

void main() {
  runApp(const RegistrationFormApp());
}

class RegistrationFormApp extends StatelessWidget {
  const RegistrationFormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Registration Form',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F766E),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _selectedRole = 'Student';
  bool _isActive = true;

  static final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  static const _roles = ['Student', 'Mentor', 'Developer', 'Guest'];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    final name = value?.trim() ?? '';

    if (name.isEmpty) {
      return 'Enter your name';
    }

    if (name.length < 2) {
      return 'Name must have at least 2 characters';
    }

    return null;
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) {
      return 'Enter your email';
    }

    if (!_emailPattern.hasMatch(email)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    final password = value ?? '';

    if (password.isEmpty) {
      return 'Enter your password';
    }

    if (password.length < 8) {
      return 'Password must have at least 8 characters';
    }

    return null;
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final summary = RegistrationSummary(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      role: _selectedRole,
      status: _isActive ? 'Active' : 'Pending',
    );

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Registration complete'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SummaryRow(label: 'Name', value: summary.name),
              SummaryRow(label: 'Email', value: summary.email),
              SummaryRow(label: 'Role', value: summary.role),
              SummaryRow(label: 'Status', value: summary.status),
            ],
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }

  void _clearForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    setState(() {
      _selectedRole = 'Student';
      _isActive = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Form'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final useTwoColumns = constraints.maxWidth >= 760;

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 820),
                  child: Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(28),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const RegistrationHeader(),
                            const SizedBox(height: 28),
                            RegistrationFields(
                              nameController: _nameController,
                              emailController: _emailController,
                              passwordController: _passwordController,
                              selectedRole: _selectedRole,
                              roles: _roles,
                              isActive: _isActive,
                              useTwoColumns: useTwoColumns,
                              onRoleChanged: (role) {
                                if (role == null) {
                                  return;
                                }
                                setState(() => _selectedRole = role);
                              },
                              onStatusChanged: (value) {
                                setState(() => _isActive = value);
                              },
                              validateName: _validateName,
                              validateEmail: _validateEmail,
                              validatePassword: _validatePassword,
                            ),
                            const SizedBox(height: 24),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                FilledButton.icon(
                                  key: const ValueKey('submit_button'),
                                  onPressed: _submitForm,
                                  icon: const Icon(Icons.check_circle_outline),
                                  label: const Text('Create account'),
                                ),
                                OutlinedButton.icon(
                                  onPressed: _clearForm,
                                  icon: const Icon(Icons.refresh),
                                  label: const Text('Clear'),
                                ),
                              ],
                            ),
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

class RegistrationHeader extends StatelessWidget {
  const RegistrationHeader({super.key});

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
            Icons.person_add_alt_1_outlined,
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
                'Create a new account',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              const Text('Complete the fields and submit the form.'),
            ],
          ),
        ),
      ],
    );
  }
}

class RegistrationFields extends StatelessWidget {
  const RegistrationFields({
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.selectedRole,
    required this.roles,
    required this.isActive,
    required this.useTwoColumns,
    required this.onRoleChanged,
    required this.onStatusChanged,
    required this.validateName,
    required this.validateEmail,
    required this.validatePassword,
    super.key,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String selectedRole;
  final List<String> roles;
  final bool isActive;
  final bool useTwoColumns;
  final ValueChanged<String?> onRoleChanged;
  final ValueChanged<bool> onStatusChanged;
  final String? Function(String?) validateName;
  final String? Function(String?) validateEmail;
  final String? Function(String?) validatePassword;

  @override
  Widget build(BuildContext context) {
    final firstColumn = [
      TextFormField(
        key: const ValueKey('name_field'),
        controller: nameController,
        decoration: const InputDecoration(
          labelText: 'Full name',
          prefixIcon: Icon(Icons.badge_outlined),
        ),
        textInputAction: TextInputAction.next,
        validator: validateName,
      ),
      TextFormField(
        key: const ValueKey('email_field'),
        controller: emailController,
        decoration: const InputDecoration(
          labelText: 'Email',
          prefixIcon: Icon(Icons.email_outlined),
        ),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        validator: validateEmail,
      ),
    ];

    final secondColumn = [
      TextFormField(
        key: const ValueKey('password_field'),
        controller: passwordController,
        decoration: const InputDecoration(
          labelText: 'Password',
          prefixIcon: Icon(Icons.lock_outline),
          helperText: 'Minimum 8 characters',
        ),
        obscureText: true,
        validator: validatePassword,
      ),
      DropdownButtonFormField<String>(
        key: const ValueKey('role_field'),
        value: selectedRole,
        decoration: const InputDecoration(
          labelText: 'Role',
          prefixIcon: Icon(Icons.work_outline),
        ),
        items: [
          for (final role in roles)
            DropdownMenuItem(
              value: role,
              child: Text(role),
            ),
        ],
        onChanged: onRoleChanged,
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: SwitchListTile(
          key: const ValueKey('status_field'),
          value: isActive,
          onChanged: onStatusChanged,
          title: const Text('Active status'),
          subtitle: Text(isActive ? 'Ready to join' : 'Waiting approval'),
          secondary: const Icon(Icons.verified_user_outlined),
        ),
      ),
    ];

    if (useTwoColumns) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: FieldColumn(fields: firstColumn)),
          const SizedBox(width: 16),
          Expanded(child: FieldColumn(fields: secondColumn)),
        ],
      );
    }

    return FieldColumn(fields: [...firstColumn, ...secondColumn]);
  }
}

class FieldColumn extends StatelessWidget {
  const FieldColumn({required this.fields, super.key});

  final List<Widget> fields;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var index = 0; index < fields.length; index++) ...[
          fields[index],
          if (index < fields.length - 1) const SizedBox(height: 16),
        ],
      ],
    );
  }
}

class RegistrationSummary {
  const RegistrationSummary({
    required this.name,
    required this.email,
    required this.role,
    required this.status,
  });

  final String name;
  final String email;
  final String role;
  final String status;
}

class SummaryRow extends StatelessWidget {
  const SummaryRow({
    required this.label,
    required this.value,
    super.key,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
