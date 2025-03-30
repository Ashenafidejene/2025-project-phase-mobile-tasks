import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';
import 'package:product3/models/product.dart';
import 'package:product3/supplemental/product_show.dart';

class MockGoRouter extends Mock implements GoRouter {}

void main() {
  const testProduct = Product(
    id: 45,
    productName: 'Test Product',
    price: 19.99,
    category: Category.all, // Updated to match actual display
    level: 4.5,
    sizes: ['S', 'M'],
    images: [],
    description: 'Test description',
  );

  testWidgets('CardDisplay shows correct product info',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CardsDisplay(
            product: testProduct,
            onDeleteResult: (product, success) {
              if (success) {
                print("Deleted successfully");
              } else {
                print("Deletion canceled");
              }
            },
          ),
        ),
      ),
    );

    // Verify product information is displayed correctly
    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('\$19.99'), findsOneWidget);
    expect(find.text('All'),
        findsOneWidget); // Matches the actual display for Category.all
    expect(find.byIcon(Icons.star), findsOneWidget);
  });

  testWidgets('CardDisplay taps navigate to details',
      (WidgetTester tester) async {
    // Create a mock GoRouter
    final mockRouter = MockGoRouter();

    // Mock the push method to return a Future
    when(mockRouter.push('/home')).thenAnswer((_) async => null);

    // Inject the mock GoRouter into the widget tree
    await tester.pumpWidget(
      MaterialApp.router(
        routerDelegate: mockRouter.routerDelegate,
        routeInformationParser: mockRouter.routeInformationParser,
      ),
    );

    // Build the CardsDisplay widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CardsDisplay(
            product: testProduct,
            onDeleteResult: (product, success) {
              if (success) {
                print("Deleted successfully");
              } else {
                print("Deletion canceled");
              }
            },
          ),
        ),
      ),
    );

    // Simulate tapping the card
    await tester.tap(find.byType(CardsDisplay));
    await tester.pump();

    // Verify that the mockRouter.push method was called
    verify(() => mockRouter.push('/home')).called(1);
  });
}
