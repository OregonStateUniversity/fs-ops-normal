import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hose_jockey/app.dart';
import 'package:hose_jockey/screens/main_screen.dart';

void main() {

  Widget createWidgetForTesting({Widget child}){
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('main_screen empty', (WidgetTester tester) async {

    await tester.pumpWidget(createWidgetForTesting(child: new MainScreen()));

    final titleFinder = find.text('Ops Normal');
    final messageFinder = find.text('No Engagements Created Yet');
    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
    await tester.pumpAndSettle();

  });
}