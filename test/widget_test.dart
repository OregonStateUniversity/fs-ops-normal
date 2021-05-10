import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hose_jockey/app.dart';
import 'package:hose_jockey/app.dart';
import 'package:hose_jockey/screens/main_screen.dart';

void main() {

  Widget createWidgetForTesting({Widget child}){
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('main_screen with no engagements', (WidgetTester tester) async {

    await tester.pumpWidget(createWidgetForTesting(child: new MainScreen()) );
    await tester.pumpAndSettle(const Duration(seconds: 5));
    expect(find.text('Ops Normal'), findsOneWidget);
    expect(find.text('No Engagements Created Yet'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Archive'), findsOneWidget);
  });
}