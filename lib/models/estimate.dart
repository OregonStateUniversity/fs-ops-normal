class Estimate {
  static const BASE_TRUNK_LINE_LENGTH = 1000;
  static const TRUNK_LINE_LENGTH_PER_ACRE = 200;

  final String name;
  final String timestamp;
  final int acres;

  Estimate({this.name, this.acres, this.timestamp});

  int get trunkLineLength => BASE_TRUNK_LINE_LENGTH + TRUNK_LINE_LENGTH_PER_ACRE * acres;

  int get latLineLength => trunkLineLength ~/ 2;

  int get toyLineLength => latLineLength ~/ 2;
}
