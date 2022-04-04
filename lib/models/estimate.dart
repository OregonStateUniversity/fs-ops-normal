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

  int? _1and1HalfGatedWye;
  int? _1and1HalfReducers;
  int? _1and3quatersReducers;
  int? _ForesterNozzles;
  int? _ToyNozzles;
  int? _ToyWye;

  int? _FoldaTank;
  int? _Mark3s;
  int? _PumpMixCans;

  int? _WaterPallets;
  int? _GatoradePallets;
  int? _MREPallets;
  int? _PortaPotties;

  Estimate({
    this.name = -1,
    this.timeStamp,
    this.acres,
    this.structures = 0,
  });

  int calculateTrunkLineLength() {
    return (BASE_TRUNK_LINE_LENGTH + TRUNK_LINE_LENGTH_PER_ACRE * acres!);
  }

  int calculateLatLineLength() {
    if (this.acres! >= 0) {
      return (trunkLineLength! ~/ 2).toInt();
    } else {
      return 0;
    }
  }

  int calculateToyLineLength() {
    if (this.acres! >= 0) {
      return (latLineLength! ~/ 2).toInt();
    } else {
      return 0;
    }
  }

  int calculateFittings() {
    return (this.latLineLength! ~/ 100).toInt();
  }

  int calculateMark3s() {
    if (acres! >= 10) {
      return acres! ~/ 10.toInt();
    } else {
      return 0;
    }
  }

  int calculateFoldaTanks() {
    if (acres! >= 10) {
      return (acres! ~/ 5).toInt();
    } else {
      return 0;
    }
  }

  int calculateMark3Kits() {
    if (acres! >= 10) {
      return (acres! ~/ 10).toInt();
    } else {
      return 0;
    }
  }

  int calculatePumpMixCans() {
    if (this.acres! >= 10) {
      return (this.calculateMark3s() * 6).toInt();
    } else {
      return 0;
    }
  }

  int calculateWaterPallets() {
    if (this.acres! >= 20) {
      return (acres! ~/ 20).toInt();
    } else {
      return 0;
    }
  }

  int calculateGatoradePallets() {
    if (this.acres! >= 20) {
      return (acres! ~/ 20).toInt();
    } else {
      return 0;
    }
  }

  int calculateMREPallets() {
    if (this.acres! >= 20) {
      return (acres! ~/ 20).toInt();
    } else {
      return 0;
    }
  }

  int calculatePortaPotties() {
    if (this.acres! >= 20) {
      return (acres! ~/ 10).toInt();
    } else {
      return 0;
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

  String toCopyStringAcres() {
    String str = "Trunk Line: ${this.trunkLineLength} ft.\n"
        "Lat Line: ${this.latLineLength} ft.\n"
        "Toy Hose: ${this.toyLineLength} ft.\n\n";

    str += "1.5\" Gated Wye: ${this.fittings}\n"
        "1.5\" Reducers: ${this.fittings}\n"
        "1\"-3/4\" Reducers: ${this.fittings}\n"
        "Forester Nozzles: ${this.fittings}\n"
        "Toy Nozzles: ${this.fittings}\n"
        "Toy Wye: ${this.fittings}\n\n";
    str += "Folda-tank: ${this.calculateFoldaTanks()}\n"
        "Mark 3 + Kits: ${this.calculateMark3s()}\n"
        "Pump Mix (Cans): ${this.calculatePumpMixCans()}\n\n"; //one mark 3 for every 30 gallons of pump mix or 6 cans

    str += "Water (Pallets): ${this.calculateWaterPallets()}\n"
        "Gatorade (Pallets): ${this.calculateGatoradePallets()}\n"
        "MRE (Pallets): ${this.calculateMREPallets()}\n"
        "Port-a-Potties: ${this.calculatePortaPotties()}\n\n";

    return str;
  }

  String toCopyStringStructures() {
    String str = "Trunk Line: ${this.trunkLineLength} ft.\n"
        "Lat Line: ${this.latLineLength} ft.\n"
        "Toy Hose: ${this.toyLineLength} ft.\n\n";

    str += "1.5\" Gated Wye: ${this.fittings}\n"
        "1.5\" Reducers: ${this.fittings}\n"
        "1\"-3/4\" Reducers: ${this.fittings}\n"
        "Forester Nozzles: ${this.fittings}\n"
        "Toy Nozzles: ${this.fittings}\n"
        "Toy Wye: ${this.fittings}\n\n";
    str += "Folda-tank: ${this.calculateFoldaTanks()}\n"
        "Mark 3 + Kits: ${this.calculateMark3s()}\n"
        "Pump Mix (Cans): ${this.calculatePumpMixCans()}\n\n"; //one mark 3 for every 30 gallons of pump mix or 6 cans

    str += "Water (Pallets): ${this.calculateWaterPallets()}\n"
        "Gatorade (Pallets): ${this.calculateGatoradePallets()}\n"
        "MRE (Pallets): ${this.calculateMREPallets()}\n"
        "Port-a-Potties: ${this.calculatePortaPotties()}\n\n";

    return str;
  }

  void initialEquipmentCalculation() {
    _trunkLineLength = calculateTrunkLineLength();
    _latLineLength = trunkLineLength! ~/ 2;
    _toyLineLength = latLineLength! ~/ 2;
    _fittings = latLineLength! ~/ 100;

    calculateLatLineLength();
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
