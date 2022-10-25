// import 'package:test/test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ops_normal/models/engagement.dart';

void main() {
  group('An Engagement', () {
    test('Construction and attributes', () {
      final engagement = new Engagement(
          id: null,
          name: "Fake Engagement",
          createdAt: DateTime.now(),
          estimates: [],
          active: true);
      expect(engagement.id, isNull);
      expect(engagement.name, isNotNull);
      expect(engagement.createdAt, isNotNull);
      expect(engagement.estimates, isList);
      expect(engagement.active, isNotNull);
    });

    test('toString', () {
      final createdAt = DateTime.now();
      final engagement = new Engagement(
          id: 42,
          name: "Fake Engagement",
          createdAt: createdAt,
          estimates: [],
          active: true);
      String expected = "Engagement 42: Fake Engagement, $createdAt";
      expect(engagement.toString(), equals(expected));
    });
    group('isSaved', () {
      test('is false when the id is null', () {
        final engagement = new Engagement(
            id: null,
            name: "Fake Engagement",
            createdAt: DateTime.now(),
            estimates: [],
            active: true);
        expect(engagement.isSaved, isFalse);
      });
      test('is true when it has an id', () {
        final engagement = new Engagement(
            id: 42,
            name: "Fake Engagement",
            createdAt: DateTime.now(),
            estimates: [],
            active: true);
        expect(engagement.isSaved, isTrue);
      });
    });
  });
}
