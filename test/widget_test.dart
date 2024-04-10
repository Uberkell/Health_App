import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:int_to_win_it/pages/notification_page.dart'; // Adjust import path based on your project structure

void main() {
  group('NotificationPage Widget Tests', () {
    testWidgets('Widget renders correctly', (WidgetTester tester) async {
      // Build our widget and trigger a frame
      await tester.pumpWidget(const MaterialApp(
        home: NotificationPage(),
      ));

      // Verify that the text 'Show Notification' is present
      expect(find.text('Show Notification'), findsOneWidget);

      // Verify that the switch for recurring notifications is present
      expect(find.byType(Switch), findsOneWidget);

      // Verify that the button for activating water drinking reminder is present
      expect(find.text('Activate Water Drinking Reminder'), findsOneWidget);
    });

    testWidgets('Toggling recurring notifications switch', (WidgetTester tester) async {
      // Build our widget
      await tester.pumpWidget(const MaterialApp(
        home: NotificationPage(),
      ));

      // Find the switch widget
      final switchFinder = find.byType(Switch);

      // Toggle the switch to enable recurring notifications
      await tester.tap(switchFinder);
      await tester.pump();

      // Verify that the switch is toggled and recurring notifications are enabled
      expect(tester.widget<Switch>(switchFinder).value, isTrue);

      // Toggle the switch to disable recurring notifications
      await tester.tap(switchFinder);
      await tester.pump();

      // Verify that the switch is toggled and recurring notifications are disabled
      expect(tester.widget<Switch>(switchFinder).value, isFalse);
    });
  });
}
