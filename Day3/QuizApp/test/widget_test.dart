import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/main.dart';

void main() {
  testWidgets('quiz answers questions, navigates to result, and restarts',
      (tester) async {
    await tester.pumpWidget(const QuizApp());

    expect(find.text('Question 1 of 5'), findsOneWidget);

    await tester.tap(find.text('Column'));
    await tester.pumpAndSettle();
    expect(find.text('Question 2 of 5'), findsOneWidget);

    await tester.tap(find.text('Navigator'));
    await tester.pumpAndSettle();
    expect(find.text('Question 3 of 5'), findsOneWidget);

    await tester.tap(find.text('setState'));
    await tester.pumpAndSettle();
    expect(find.text('Question 4 of 5'), findsOneWidget);

    await tester.tap(find.text('List<QuizQuestion>'));
    await tester.pumpAndSettle();
    expect(find.text('Question 5 of 5'), findsOneWidget);

    await tester.tap(find.text('Navigator.push'));
    await tester.pumpAndSettle();

    expect(find.text('Final score'), findsOneWidget);
    expect(find.text('5 / 5'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('restart_button')));
    await tester.pumpAndSettle();

    expect(find.text('Question 1 of 5'), findsOneWidget);
    expect(find.text('Current score: 0'), findsOneWidget);
  });
}
