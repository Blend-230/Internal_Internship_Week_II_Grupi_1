import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:registration_form_app/main.dart';

void main() {
  testWidgets('registration form validates fields and shows summary dialog',
      (tester) async {
    await tester.pumpWidget(const RegistrationFormApp());

    await tester.tap(find.byKey(const ValueKey('submit_button')));
    await tester.pump();

    expect(find.text('Enter your name'), findsOneWidget);
    expect(find.text('Enter your email'), findsOneWidget);
    expect(find.text('Enter your password'), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('name_field')),
      'Andi Ademaj',
    );
    await tester.enterText(
      find.byKey(const ValueKey('email_field')),
      'andi@example.com',
    );
    await tester.enterText(
      find.byKey(const ValueKey('password_field')),
      'flutter123',
    );

    await tester.tap(find.byKey(const ValueKey('submit_button')));
    await tester.pumpAndSettle();

    expect(find.text('Registration complete'), findsOneWidget);
    expect(find.text('Name: '), findsOneWidget);
    expect(find.text('Andi Ademaj'), findsOneWidget);
    expect(find.text('Email: '), findsOneWidget);
    expect(find.text('andi@example.com'), findsOneWidget);
    expect(find.text('Role: '), findsOneWidget);
    expect(find.text('Student'), findsWidgets);
  });
}
