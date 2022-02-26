import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hose_jockey/screens/estimate_list_screen.dart';

void main() {
  Widget createWidgetForTesting({Widget? child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('main_screen with no engagements', (WidgetTester tester) async {
    await tester
        .pumpWidget(createWidgetForTesting(child: new EstimateListScreen()));
    await tester.pumpAndSettle(const Duration(seconds: 5));
    expect(find.text('Ops Normal'), findsOneWidget);
    expect(find.text('No Engagements Created Yet'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Archive'), findsOneWidget);
  });

  testWidgets('main_screen add engagement', (WidgetTester tester) async {
    await tester
        .pumpWidget(createWidgetForTesting(child: new EstimateListScreen()));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    print("Found text box");
    await tester.enterText(find.byType(TextField), "Test Fire");
    print("Found text box, typed in test fire");
    await tester.pumpAndSettle();
    await tester.tap(find.text("Create"));
    print("Clicked create");
    await tester.pumpAndSettle();
    expect(find.text('Test Fire'), findsOneWidget);
    expect(find.text('Ops Normal'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Archive'), findsOneWidget);
  });

  testWidgets('main_screen delete engagement', (WidgetTester tester) async {
    await tester
        .pumpWidget(createWidgetForTesting(child: new EstimateListScreen()));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), "Test Fire");
    await tester.pumpAndSettle();
    await tester.tap(find.text("Create"));
    await tester.pumpAndSettle();
  });
}
