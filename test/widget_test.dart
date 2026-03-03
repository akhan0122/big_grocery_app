// import 'package:biggroceryapp/core/services/app_bindings.dart';
import 'package:biggroceryapp/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Splash loads then navigates to home', (
    WidgetTester tester,
  ) async {
    // AppBindings().dependencies();

    await tester.pumpWidget(const MyApp());

    expect(find.text('Big Grocery'), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.text('Welcome to Big Grocery'), findsOneWidget);
    expect(find.text('Items in cart: 0'), findsOneWidget);

    await tester.tap(find.text('Add Item'));
    await tester.pump();

    expect(find.text('Items in cart: 1'), findsOneWidget);
  });
}
