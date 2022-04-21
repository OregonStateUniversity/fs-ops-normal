class Estimate {
  static const BASE_TRUNK_LINE_LENGTH = 1000;
  static const TRUNK_LINE_LENGTH_PER_ACRE = 200;

  int? name;
  String? timeStamp;
  int? acres;
  int? structures;

  int? _trunkLineLength;
  int? _latLineLength;
  int? _toyLineLength;
  int? _fittings;

  int? _foldaTanks;
  int? _mark3PumpsAcres;
  int? _pumpMixCansAcres;
  int? _waterPallets;
  int? _gatoradePallets;
  int? _mrePallets;
  int? _portaPotties;

  int? _sprinklers;
  int? _onePointFiveHose;
  int? _oneInchHose;
  int? _onePointFiveWye;
  int? _oneInchWye;
  int? _onePointFiveToOneInchReducer;
  int? _kkNozzles;
  int? _mark3Structures;
  int? _foam;

  int? get trunkLineLength => _trunkLineLength;
  int? get latLineLength => _latLineLength;
  int? get toyLineLength => _toyLineLength;
  int? get fittings => _fittings;

  set trunkLineLength(int? length) => _trunkLineLength;
  set latLineLength(int? length) => _latLineLength;
  set toyLineLength(int? length) => _toyLineLength;
  set fittings(int? count) => _fittings;

  Estimate({
    this.name = -1,
    this.timeStamp,
    this.acres = 0,
    this.structures = 0,
  }) {
    initializeAllProperties();
  }

  Estimate.jsonConvF(name, acres, structures, timeStamp, trunk, lat, toy,
      [fittings = 0]) {
    this.name = name;
    this.acres = acres;
    this.structures = structures;
    this.timeStamp = timeStamp;
    _trunkLineLength = trunk;
    _latLineLength = lat;
    _toyLineLength = toy;
    _fittings = fittings;
  }

  Estimate.finalEstimate(name, acres, timeStamp, structures, trunk, lat, toy,
      [fittings]) {
    this.name = name;
    this.acres = acres;
    this.timeStamp = timeStamp;
    this.structures = structures;
    _trunkLineLength = trunk;
    _latLineLength = lat;
    _toyLineLength = toy;
    _fittings = fittings;
    initializeUnsavedProperties();
  }

  factory Estimate.fromJson(Map<String, dynamic> json) => Estimate.jsonConvF(
      json["name"],
      json["acres"],
      json["structures"],
      json["timeStamp"],
      json["trunkLineLength"],
      json["latLineLength"],
      json["toyLineLength"],
      json["fittings"] == null ? 0 : json["fittings"]);

  void initializeSavedProperties() {
    _trunkLineLength = defaultTrunkLineLength();
    _latLineLength = defaultLatLineLength();
    _toyLineLength = defaultToyLineLength();
    _fittings = defaultFittings();
  }

  void initializeUnsavedProperties() {
    _foldaTanks = defaultFoldaTanks();
    _mark3PumpsAcres = defaultMark3PumpsAcres();
    _pumpMixCansAcres = defaultPumpMixCansAcres();
    _waterPallets = defaultWaterPallets();
    _gatoradePallets = defaultGatoradePallets();
    _mrePallets = defaultMrePallets();
    _portaPotties = defaultPortaPotties();
    _sprinklers = defaultSprinklers();
    _onePointFiveHose = defaultOnePointFiveHose();
    _oneInchHose = defaultOneInchHose();
    _onePointFiveWye = defaultOnePointFiveWye();
    _oneInchWye = defaultOneInchWye();
    _onePointFiveToOneInchReducer = defaultOnePointFiveToOneInchReducer();
    _kkNozzles = defaultKkNozzles();
    _mark3Structures = defaultMark3Structures();
    _foam = defaultFoam();
  }

  void initializeAllProperties() {
    initializeSavedProperties();
    initializeUnsavedProperties();
  }

  int defaultTrunkLineLength() {
    return (BASE_TRUNK_LINE_LENGTH + TRUNK_LINE_LENGTH_PER_ACRE * acres!);
  }

  int defaultLatLineLength() {
    if (this.acres! >= 0) {
      return (trunkLineLength! ~/ 2).toInt();
    } else {
      return 0;
    }
  }

  int defaultToyLineLength() {
    if (this.acres! >= 0) {
      return (latLineLength! ~/ 2).toInt();
    } else {
      return 0;
    }
  }

  int defaultFittings() {
    if (this.acres! >= 0) {
      return (latLineLength! ~/ 100).toInt();
    } else {
      return 0;
    }
  }

  int defaultFoldaTanks() {
    if (acres! >= 10) {
      return (acres! ~/ 5).toInt();
    } else {
      return 0;
    }
  }

  int defaultMark3PumpsAcres() {
    if (acres! >= 10) {
      return acres! ~/ 10.toInt();
    } else {
      return 0;
    }
  }

  // TODO: https://github.com/osu-cascades/fs-hose-jockey/issues/120
  int calculateMark3KitsAcres() {
    if (acres! >= 10) {
      return (acres! ~/ 10).toInt();
    } else {
      return 0;
    }
  }

  int defaultPumpMixCansAcres() {
    if (this.acres! >= 10) {
      return (this.defaultMark3PumpsAcres() * 6).toInt();
    } else {
      return 0;
    }
  }

  int defaultWaterPallets() {
    if (this.acres! >= 20) {
      return (acres! ~/ 20).toInt();
    } else {
      return 0;
    }
  }

  int defaultGatoradePallets() {
    if (this.acres! >= 20) {
      return (acres! ~/ 20).toInt();
    } else {
      return 0;
    }
  }

  int defaultMrePallets() {
    if (this.acres! >= 20) {
      return (acres! ~/ 20).toInt();
    } else {
      return 0;
    }
  }

  int defaultPortaPotties() {
    if (this.acres! >= 20) {
      return (acres! ~/ 10).toInt();
    } else {
      return 0;
    }
  }

  int defaultSprinklers() {
    if (this.structures! == 0) {
      return 0;
    } else if (this.structures! < 10) {
      return 10;
    } else if (this.structures! < 40) {
      return 40;
    } else if (this.structures! > 40) {
      return 50;
    } else {
      return 0;
    }
  }

  int defaultOnePointFiveHose() {
    if (this.structures! == 0) {
      return 0;
    } else if (this.structures! < 10) {
      return 3000;
    } else if (this.structures! < 40) {
      return 5000;
    } else if (this.structures! > 40) {
      return 7000;
    } else {
      return 0;
    }
  }

  int defaultOneInchHose() {
    if (this.structures! == 0) {
      return 0;
    } else if (this.structures! < 10) {
      return 20;
    } else if (this.structures! < 40) {
      return 35;
    } else if (this.structures! > 40) {
      return 50;
    } else {
      return 0;
    }
  }

  int defaultOnePointFiveWye() {
    if (this.structures! == 0) {
      return 0;
    } else if (this.structures! < 10) {
      return 10;
    } else if (this.structures! < 40) {
      return 40;
    } else if (this.structures! > 40) {
      return 50;
    } else {
      return 0;
    }
  }

  int defaultOneInchWye() {
    if (this.structures! == 0) {
      return 0;
    } else if (this.structures! < 10) {
      return 20;
    } else if (this.structures! < 40) {
      return 40;
    } else if (this.structures! > 40) {
      return 50;
    } else {
      return 0;
    }
  }

  int defaultOnePointFiveToOneInchReducer() {
    if (this.structures! == 0) {
      return 0;
    } else if (this.structures! < 10) {
      return 20;
    } else if (this.structures! < 40) {
      return 20;
    } else if (this.structures! > 40) {
      return 30;
    } else {
      return 0;
    }
  }

  int defaultKkNozzles() {
    if (this.structures! == 0) {
      return 0;
    } else if (this.structures! < 10) {
      return 20;
    } else if (this.structures! < 40) {
      return 20;
    } else if (this.structures! > 40) {
      return 30;
    } else {
      return 0;
    }
  }

  int defaultMark3Structures() {
    if (this.structures! == 0) {
      return 0;
    } else if (this.structures! < 10) {
      return 3;
    } else if (this.structures! < 40) {
      return 6;
    } else if (this.structures! > 40) {
      return 10;
    } else {
      return 0;
    }
  }

  int defaultFoam() {
    if (this.structures! == 0) {
      return 0;
    } else if (this.structures! < 10) {
      return 5;
    } else if (this.structures! < 40) {
      return 5;
    } else if (this.structures! > 40) {
      return 0;
    } else {
      return 0;
    }
  }

  String flatFireOrderText() {
    String str = "Trunk Line: ${this._trunkLineLength} ft.\n"
        "Lat Line: ${this._latLineLength} ft.\n"
        "Toy Hose: ${this._toyLineLength} ft.\n\n";

    str += "1.5\" Gated Wye: ${this._fittings}\n"
        "1.5\" Reducers: ${this._fittings}\n"
        "1\"-3/4\" Reducers: ${this._fittings}\n"
        "Forester Nozzles: ${this._fittings}\n"
        "Toy Nozzles: ${this._fittings}\n"
        "Toy Wye: ${this._fittings}\n\n";
    str += "Folda-tank: ${this._foldaTanks}\n"
        "Mark 3 + Kits: ${this._mark3PumpsAcres}\n"
        "Pump Mix (Cans): ${this._pumpMixCansAcres}\n\n";

    str += "Water (Pallets): ${this._waterPallets}\n"
        "Gatorade (Pallets): ${this._gatoradePallets}\n"
        "MRE (Pallets): ${this._mrePallets}\n"
        "Port-a-Potties: ${this._portaPotties}\n\n";

    return str;
  }

  String structureFireOrderText() {
    String str = "Sprinkler Kits: ${this._sprinklers}\n"
        "1.5 hose: ${this._onePointFiveHose}\n"
        "1.0 hose: ${this._oneInchHose}\n"
        "1.5 Gated Wye: ${this._onePointFiveWye}\n"
        "1.0 Gated Wye: ${this._oneInchWye}\n"
        "1.5-1.0 Reducer: ${this._onePointFiveToOneInchReducer}\n"
        "KK Nozzles: ${this._kkNozzles}\n"
        "Mark 3 Pumps: ${this._mark3Structures}\n"
        "Mark 3 Kits: ${this._mark3Structures}\n"
        "Foam: ${this._foam}\n";
    return str;
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'timeStamp': timeStamp,
        'acres': acres,
        'structures': structures,
        'trunkLineLength': trunkLineLength,
        'latLineLength': latLineLength,
        'toyLineLength': toyLineLength,
        'fittings': fittings
      };
}
