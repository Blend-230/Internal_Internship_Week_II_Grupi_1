import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_card_app/main.dart';

void main() {
  testWidgets('profile card shows details and contact SnackBar', (tester) async {
    await tester.pumpWidget(const ProfileCardApp());

    expect(find.text('Andi Ademaj'), findsOneWidget);
    expect(find.text('Flutter Developer'), findsOneWidget);
    expect(find.byIcon(Icons.person_rounded), findsOneWidget);

    await tester.ensureVisible(find.text('Contact me'));
    await tester.tap(find.text('Contact me'));
    await tester.pump();

    expect(find.text('Thanks for reaching out to Andi!'), findsOneWidget);
  });
}
