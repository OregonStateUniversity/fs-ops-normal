class Estimate {
  static const BASE_TRUNK_LINE_LENGTH = 1000;
  static const TRUNK_LINE_LENGTH_PER_ACRE = 200;

  int? name;
  String? timeStamp;
  int? acres;
  String? shape;
  String? type;
  int? structures;
  int? _trunkLineLength;
  int? _latLineLength;
  int? _toyLineLength;
  int? _fittings;

  Estimate({this.name = -1, this.acres, this.timeStamp, this.structures});

  String calculateTrunkLineLength() {
    if (acres! > 0) {
      // BASE_TRUNK_LINE_LENGTH + TRUNK_LINE_LENGTH_PER_ACRE * acres!;
      return (BASE_TRUNK_LINE_LENGTH + TRUNK_LINE_LENGTH_PER_ACRE * acres!)
          .toString();
    } else {
      return '0';
    }
  }

  Estimate.jsonConvF(
      name, acres, shape, type, structures, timeStamp, trunk, lat, toy,
      [fittings = 0]) {
    this.name = name;
    this.acres = acres;
    this.shape = shape;
    this.type = type;
    this.structures = structures;
    this.timeStamp = timeStamp;
    _trunkLineLength = trunk;
    _latLineLength = lat;
    _toyLineLength = toy;
    _fittings = fittings;
  }

  Estimate.loadSavedEstimate(
      name, acres, timeStamp, structures, trunk, lat, toy,
      [fittings = 0]) {
    this.name = name;
    this.acres = acres;
    this.timeStamp = timeStamp;
    this.structures = structures;
    _trunkLineLength = trunk;
    _latLineLength = lat;
    _toyLineLength = toy;
    _fittings = fittings;
  }

  int? get trunkLineLength => _trunkLineLength;
  int? get latLineLength => _latLineLength;
  int? get toyLineLength => _toyLineLength;
  int? get fittings => _fittings;

  set trunkLineLength(int? length) => _trunkLineLength;
  set latLineLength(int? length) => _latLineLength;
  set toyLineLength(int? length) => _toyLineLength;
  set fittings(int? count) => _fittings;

  String toCopyString() {
    String str = "Trunk Line: ${this.trunkLineLength} ft.\n"
        "Lat Line: ${this.latLineLength} ft.\n"
        "Toy Hose: ${this.toyLineLength} ft.\n\n";

    if (this.fittings! >= 0) {
      str += "1.5\" Gated Wye: ${this.fittings}\n"
          "1.5\" Reducers: ${this.fittings}\n"
          "1\"-3/4\" Reducers: ${this.fittings}\n"
          "Forester Nozzles: ${this.fittings}\n"
          "Toy Nozzles: ${this.fittings}\n"
          "Toy Wye: ${this.fittings}\n\n";
    }
    if (this.acres! >= 10) {
      var mark3s = acres! ~/ 10;
      str += "Folda-tank: ${acres! ~/ 5}\n"
          "Mark 3 + Kits: $mark3s\n"
          "Pump Mix (Cans): ${mark3s * 6}\n\n"; //one mark 3 for every 30 gallons of pump mix or 6 cans

      //Old calculation : "Pump Mix (Cans): ${((acres ~/ 5) ~/ 2) * 3}\n\n";
    }
    if (this.acres! >= 20) {
      str += "Water (Pallets): ${acres! ~/ 20}\n"
          "Gatorade (Pallets): ${acres! ~/ 20}\n"
          "MRE (Pallets): ${acres! ~/ 20}\n"
          "Port-a-Potties: ${acres! ~/ 10}\n\n";
    }
    return str;
  }

  void initialLineCalculation() {
    _trunkLineLength =
        BASE_TRUNK_LINE_LENGTH + TRUNK_LINE_LENGTH_PER_ACRE * acres!;
    _latLineLength = trunkLineLength! ~/ 2;
    _toyLineLength = latLineLength! ~/ 2;
    _fittings = latLineLength! ~/ 100;
  }

  factory Estimate.fromJson(Map<String, dynamic> json) => Estimate.jsonConvF(
      json["name"],
      json["acres"],
      json["shape"],
      json["type"],
      json["structures"],
      json["timeStamp"],
      json["trunkLineLength"],
      json["latLineLength"],
      json["toyLineLength"],
      json["fittings"] == null ? 0 : json["fittings"]);

  Map<String, dynamic> toJson() => {
        'name': name,
        'acres': acres,
        'timeStamp': timeStamp,
        'shape': shape,
        'type': type,
        'structures': structures,
        'trunkLineLength': trunkLineLength,
        'latLineLength': latLineLength,
        'toyLineLength': toyLineLength,
        'fittings': fittings
      };
}
