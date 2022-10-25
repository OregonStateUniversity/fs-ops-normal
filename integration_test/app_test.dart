import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ops_normal/app.dart';

void main() {
  group('App', () {
    testWidgets('Starts empty', (tester) async {
      await tester.pumpWidget(App());
      await tester.pumpAndSettle();
      var finder = find.text('Ops Normal');
      expect(finder, findsOneWidget);
      finder = find.text('No Engagements Created Yet');
      expect(finder, findsOneWidget);
    });
  });
}
