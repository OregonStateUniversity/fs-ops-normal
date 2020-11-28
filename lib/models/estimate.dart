class Estimate{
  static const BASE_TRUNK_LINE_LENGTH = 1000;
  static const TRUNK_LINE_LENGTH_PER_ACRE = 200;

  final name;
  final String timeStamp;
  final int acres;

  Estimate({this.name, this.acres, this.timeStamp});

  int get trunkLineLength => BASE_TRUNK_LINE_LENGTH + TRUNK_LINE_LENGTH_PER_ACRE * acres;

  int get latLineLength => trunkLineLength ~/ 2;

  int get toyLineLength => latLineLength ~/ 2;
}


class Estimate2{
  static const BASE_TRUNK_LINE_LENGTH = 1000;
  static const TRUNK_LINE_LENGTH_PER_ACRE = 200;

  final name;
  final String timeStamp;
  int acres;

  int _trunkLineLength;
  int _latLineLength;
  int _toyLineLength;

  Estimate2({this.name, this.acres, this.timeStamp});

  void initialLineCalculation(){
    _trunkLineLength = BASE_TRUNK_LINE_LENGTH + TRUNK_LINE_LENGTH_PER_ACRE * acres;
    _latLineLength = trunkLineLength ~/ 2;
    _toyLineLength = latLineLength ~/ 2;
  }

  int get trunkLineLength => _trunkLineLength;
  int get latLineLength => _latLineLength;
  int get toyLineLength => _toyLineLength;

  set trunkLineLength(int length) => _trunkLineLength;
  set latLineLength(int length) => _latLineLength;
  set toyLineLength(int length) => _toyLineLength;

}
