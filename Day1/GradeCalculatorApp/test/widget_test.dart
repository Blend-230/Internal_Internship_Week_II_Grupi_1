import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grade_calculator_app/main.dart';

void main() {
  testWidgets('valid grades show the average and passing status', (tester) async {
    await tester.pumpWidget(const GradeCalculatorApp());

    final fields = find.byType(TextFormField);
    expect(fields, findsNWidgets(3));

    await tester.enterText(fields.at(0), '70');
    await tester.enterText(fields.at(1), '80');
    await tester.enterText(fields.at(2), '90');

    final calculateButton = find.widgetWithText(
      FilledButton,
      'Llogarit mesataren',
    );
    await tester.ensureVisible(calculateButton);
    await tester.tap(calculateButton);
    await tester.pump();

    expect(find.text('Mesatarja: 80.00'), findsOneWidget);
    expect(find.text('Kalon'), findsOneWidget);
  });

  testWidgets('empty fields show validation errors', (tester) async {
    await tester.pumpWidget(const GradeCalculatorApp());

    final calculateButton = find.widgetWithText(
      FilledButton,
      'Llogarit mesataren',
    );
    await tester.ensureVisible(calculateButton);
    await tester.tap(calculateButton);
    await tester.pump();

    expect(find.text('Vendosni nje vlere'), findsNWidgets(3));
  });
}
