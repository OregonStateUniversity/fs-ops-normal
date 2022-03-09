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
    if (acres! >= 0) {
      return (BASE_TRUNK_LINE_LENGTH + TRUNK_LINE_LENGTH_PER_ACRE * acres!)
          .toInt();
    } else {
      return 0;
    }
  }

  int calculateLatLineLength() {
    if (acres! >= 0) {
      return (trunkLineLength! ~/ 2).toInt();
    } else {
      return 0;
    }
  }

  int calculateToyLineLength() {
    if (acres! >= 0) {
      return (latLineLength! ~/ 2).toInt();
    } else {
      return 0;
    }
  }

  int calculateFittings() {
    if (fittings! >= 0) {
      return (latLineLength! ~/ 100).toInt();
    } else {
      return 0;
    }
  }

  int calculateMark3s() {
    if (acres! >= 10) {
      return (acres! ~/ 10).toInt();
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
      return (this.calculateMark3s()).toInt();
    } else {
      return 0;
    }
  }

  int calculatePumpMixCans() {
    if (acres! >= 10) {
      return (_Mark3s! * 6).toInt();
    } else {
      return 0;
    }
  }

  int calculateWaterPallets() {
    if (acres! >= 20) {
      return (acres! ~/ 20).toInt();
    } else {
      return 0;
    }
  }

  int calculateGatoradePallets() {
    if (acres! >= 20) {
      return (acres! ~/ 20).toInt();
    } else {
      return 0;
    }
  }

  int calculateMREPallets() {
    if (acres! >= 20) {
      return (acres! ~/ 20).toInt();
    } else {
      return 0;
    }
  }

  int calculatePortaPotties() {
    if (acres! >= 20) {
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
    }
    if (this.acres! >= 20) {
      str += "Water (Pallets): ${acres! ~/ 20}\n"
          "Gatorade (Pallets): ${acres! ~/ 20}\n"
          "MRE (Pallets): ${acres! ~/ 20}\n"
          "Port-a-Potties: ${acres! ~/ 10}\n\n";
    }
    return str;
  }

  void initialEquipmentCalculation() {
    _trunkLineLength =
        BASE_TRUNK_LINE_LENGTH + TRUNK_LINE_LENGTH_PER_ACRE * acres!;
    _latLineLength = trunkLineLength! ~/ 2;
    _toyLineLength = latLineLength! ~/ 2;
    _fittings = latLineLength! ~/ 100;

    // _1and1HalfGatedWye = this.fittings;
    // _1and1HalfReducers = this.fittings;
    // _1and3quatersReducers = this.fittings;
    // _ForesterNozzles = this.fittings;
    // _ToyNozzles = this.fittings;
    // _ToyWye = this.fittings;

    // _FoldaTank = acres! ~/ 10;
    // _Mark3s = acres! ~/ 10;
    // _PumpMixCans = _Mark3s! * 6;

    // _WaterPallets = acres! ~/ 20;
    // _GatoradePallets = acres! ~/ 20;
    // _MREPallets = acres! ~/ 20;
    // _PortaPotties = acres! ~/ 10;
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
