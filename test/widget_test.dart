import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hose_jockey/app.dart';
import 'package:hose_jockey/screens/main_screen.dart';

void main() {
  testWidgets('Main Screen is empty', (WidgetTester tester) async {

    await tester.pumpWidget(MainScreen());

    final titleFinder = find.text('Ops Normal');
    final messageFinder = find.text('No Engagements Created Yet');
  });
}
