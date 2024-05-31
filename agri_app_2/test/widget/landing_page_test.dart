import 'package:agri_app_2/auth/presentation/pages/dash_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/mockito.dart';

// Mock class for SharedPreferences
class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  // Mock setup for SharedPreferences
  group('Dashboard Screen Widget Test', () {
    SharedPreferences mockSharedPreferences;

    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
      when(mockSharedPreferences.getString('role')).thenReturn('BUYER');
    });

    testWidgets('Widget Test', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(MaterialApp(
        home: DashBoardScreen(),
      ));

      // Verify that the initial widget renders correctly
      expect(find.byType(DashBoardScreen), findsOneWidget);

      expect(find.text('Categories'), findsOneWidget);
      expect(find.text('Exclusive deal'), findsOneWidget);
      expect(find.text('Top picks'), findsOneWidget);

      // Example of interaction testing (if applicable)
      // For example, tapping a button and verifying navigation
      // await tester.tap(find.byKey(Key('button_key')));
      // await tester.pumpAndSettle(); // Wait for animations to complete
      // expect(find.byType(NextScreen), findsOneWidget);
    });
  });
}
