import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:temp_conversion_app/screens/temp_converter.dart';

void main() {
  testWidgets('Temperature conversion test: F to C', (WidgetTester tester) async {
    // Build the TempConverterScreen widget
    await tester.pumpWidget(
      const MaterialApp(
        home: TempConverterScreen(),
      ),
    );

    // Enter a Fahrenheit value
    await tester.enterText(find.byType(TextField), '212');

    // Press the Convert button
    await tester.tap(find.text('Convert'));
    await tester.pump();

    // Verify the result (100.00 °C)
    expect(find.textContaining('100.00'), findsOneWidget);
    expect(find.textContaining('F to C: 212.0 => 100.00'), findsOneWidget);
  });
}
