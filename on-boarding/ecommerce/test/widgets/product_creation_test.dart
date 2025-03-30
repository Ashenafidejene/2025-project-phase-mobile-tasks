import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';
import 'package:product3/addPage.dart';
import 'package:product3/detailspage.dart';
import 'package:product3/models/product.dart';

void main() {
  testWidgets('AddProductPage renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(child: AddProductPage()),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.check),
          ),
        ),
      ),
    );

    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
