import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product3/addPage.dart';

void main() {
  testWidgets('Product creation with valid input', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AddProductPage(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.check),
          ),
        ),
      ),
    );

    // Verify initial state
    expect(find.byType(TextField), findsNWidgets(2)); // Assuming 2 text fields
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
