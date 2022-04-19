import 'package:test/test.dart';
import 'package:hose_jockey/models/xengagement.dart';

void main() {
  group('An Engagement', () {
    test('Construction and attributes', () {
      final engagement = new Xengagement(
        id: null, name: "Fake Engagement", timeStamp: DateTime.now(),
        estimates: [], active: true);
      expect(engagement.id, isNull);
      expect(engagement.name, isNotNull);
      expect(engagement.timeStamp, isNotNull);
      expect(engagement.estimates, isList);
      expect(engagement.active, isNotNull);
    });

    test('toString', () {
      final timeStamp = DateTime.now();
      final engagement = new Xengagement(id: 42, name: "Fake Engagement",
        timeStamp: timeStamp, estimates: [], active: true);
      String expected = "Engagement 42: Fake Engagement, $timeStamp";
      expect(engagement.toString(), equals(expected));
    });
    group('isSaved', () {
      test('is false when the id is null', () {
        final engagement = new Xengagement(id: null, name: "Fake Engagement",
          timeStamp: DateTime.now(), estimates: [], active: true);
          expect(engagement.isSaved, isFalse);
      });
      test('is true when it has an id', () {
        final engagement = new Xengagement(id: 42, name: "Fake Engagement",
          timeStamp: DateTime.now(), estimates: [], active: true);
          expect(engagement.isSaved, isTrue);
      });
    });

  });
}
