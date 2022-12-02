class Estimate {
  static const baseTrunkLineLength = 1000;
  static const trunkLineLengthPerAcre = 200;

  int? id;
  int? engagementId;
  String? newName;
  DateTime? createdAt;

  int? name;
  String? timeStamp;
  int? acres;
  int? structures;

  int? trunkLineLength;
  int? latLineLength;
  int? toyLineLength;
  int? fittings;

  int? foldaTanks;
  int? pumpCans;
  int? waterPallets;
  int? gatoradePallets;
  int? mrePallets;
  int? portaPottiesPallets;

  int? sprinklerKits;
  int? _onePointFiveHose;
  int? _oneInchHose;
  int? onePointFiveInchWye;
  int? _oneInchWye;
  int? onePointFiveInchReducer;
  int? _kkNozzles;
  int? mark3Kits;
  int? _unleadedGas;
  int? _twoCycleOil;
  int? _foam;

  int? get trunkLine => trunkLineLength;
  int? get latLine => latLineLength;
  int? get toyLine => toyLineLength;
  int? get variousFittings => fittings;

  set trunkLine(int? length) => trunkLineLength;
  set latLine(int? length) => latLineLength;
  set toyLine(int? length) => toyLineLength;
  set variousFittings(int? count) => fittings;

  Estimate({
    this.name = -1,
    this.timeStamp,
    this.acres = 0,
    this.structures = 0,
  }) {
    initializeAllProperties();
  }

  Estimate.jsonConvF(
      this.name,
      this.acres,
      this.structures,
      this.timeStamp,
      trunk,
      lat,
      toy,
      wye,
      reducer,
      tank,
      mark3,
      cans,
      water,
      gatorade,
      mre,
      portaPotty,
      sprinklers,
      [variousFittings]) {
    trunkLineLength = trunk;
    latLineLength = lat;
    toyLineLength = toy;
    fittings = variousFittings;
    onePointFiveInchWye = wye;
    onePointFiveInchReducer = reducer;
    foldaTanks = tank;
    mark3Kits = mark3;
    pumpCans = cans;
    waterPallets = water;
    gatoradePallets = gatorade;
    mrePallets = mre;
    portaPottiesPallets = portaPotty;
    sprinklerKits = sprinklers;
  }

  Estimate.finalEstimate(
      this.name, this.acres, this.structures, this.timeStamp, trunk, lat, toy,
      [variousFittings]) {
    trunkLineLength = trunk;
    latLineLength = lat;
    toyLineLength = toy;
    fittings = variousFittings;
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
      json["fittings"],
      json["onePointFiveInchWye"],
      json["onePointFiveInchReducer"],
      json["foldaTanks"],
      json["mark3Kits"],
      json["pumpCans"],
      json["waterPallets"],
      json["gatoradePallets"],
      json["mrePallets"],
      json["portPottiesPallets"],
      json["sprinklerKits"] ?? 0);

  void initializeSavedProperties() {
    trunkLineLength = defaultTrunkLineLength();
    latLineLength = defaultLatLineLength();
    toyLineLength = defaultToyLineLength();
    fittings = defaultFittings();
  }

  void initializeUnsavedProperties() {
    foldaTanks = defaultFoldaTanksAcres();
    pumpCans = defaultPumpMixCansAcres();
    waterPallets = defaultWaterPallets();
    gatoradePallets = defaultGatoradePallets();
    mrePallets = defaultMrePallets();
    portaPottiesPallets = defaultPortaPottiesAcres();
    sprinklerKits = defaultSprinklerKits();
    _onePointFiveHose = defaultOnePointFiveHose();
    _oneInchHose = defaultOneInchHose();
    onePointFiveInchWye = defaultOnePointFiveWye();
    _oneInchWye = defaultOneInchWye();
    onePointFiveInchReducer = defaultOnePointFiveToOneInchReducer();
    _kkNozzles = defaultKkNozzles();
    mark3Kits = defaultMark3Structures();
    _unleadedGas = defaultUnleadedGas();
    _twoCycleOil = defaultTwoCycleOil();
    _foam = defaultFoam();
  }

  void initializeAllProperties() {
    initializeSavedProperties();
    initializeUnsavedProperties();
  }

  int defaultTrunkLineLength() {
    return (baseTrunkLineLength + trunkLineLengthPerAcre * acres!);
  }

  int defaultLatLineLength() {
    if (acres! >= 0) {
      return (trunkLine! ~/ 2).toInt();
    } else {
      return 0;
    }
  }

  int defaultToyLineLength() {
    if (acres! >= 0) {
      return (latLine! ~/ 2).toInt();
    } else {
      return 0;
    }
  }

  int defaultFittings() {
    if (acres! >= 0) {
      return (latLine! ~/ 100).toInt();
    } else {
      return 0;
    }
  }

  int defaultFoldaTanksAcres() {
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

  int calculateMark3KitsAcres() {
    if (acres! >= 10) {
      return (acres! ~/ 10).toInt();
    } else {
      return 0;
    }
  }

  int defaultPumpMixCansAcres() {
    if (acres! >= 10) {
      return (defaultMark3PumpsAcres() * 6).toInt();
    } else {
      return 0;
    }
  }

  int defaultWaterPallets() {
    if (acres! >= 20) {
      return (acres! ~/ 20).toInt();
    } else {
      return 0;
    }
  }

  int defaultGatoradePallets() {
    if (acres! >= 20) {
      return (acres! ~/ 20).toInt();
    } else {
      return 0;
    }
  }

  int defaultMrePallets() {
    if (acres! >= 20) {
      return (acres! ~/ 20).toInt();
    } else {
      return 0;
    }
  }

  int defaultPortaPottiesAcres() {
    if (acres! >= 20) {
      return (acres! ~/ 10).toInt();
    } else {
      return 0;
    }
  }

  int defaultSprinklerKits() {
    if (structures! == 0) {
      return 0;
    } else if (structures! < 10) {
      return 4;
    } else if (structures! < 40) {
      return 10;
    } else if (structures! > 40) {
      return 13;
    } else {
      return 0;
    }
  }

  int defaultOnePointFiveHose() {
    if (structures! == 0) {
      return 0;
    } else if (structures! < 10) {
      return 3000;
    } else if (structures! < 40) {
      return 5000;
    } else if (structures! > 40) {
      return 7000;
    } else {
      return 0;
    }
  }

  int defaultOneInchHose() {
    if (structures! == 0) {
      return 0;
    } else if (structures! < 10) {
      return 20;
    } else if (structures! < 40) {
      return 35;
    } else if (structures! > 40) {
      return 50;
    } else {
      return 0;
    }
  }

  int defaultOnePointFiveWye() {
    if (structures! == 0) {
      return 0;
    } else if (structures! < 10) {
      return 10;
    } else if (structures! < 40) {
      return 40;
    } else if (structures! > 40) {
      return 50;
    } else {
      return 0;
    }
  }

  int defaultOneInchWye() {
    if (structures! == 0) {
      return 0;
    } else if (structures! < 10) {
      return 20;
    } else if (structures! < 40) {
      return 40;
    } else if (structures! > 40) {
      return 50;
    } else {
      return 0;
    }
  }

  int defaultOnePointFiveToOneInchReducer() {
    if (structures! == 0) {
      return 0;
    } else if (structures! < 10) {
      return 20;
    } else if (structures! < 40) {
      return 20;
    } else if (structures! > 40) {
      return 30;
    } else {
      return 0;
    }
  }

  int defaultKkNozzles() {
    if (structures! == 0) {
      return 0;
    } else if (structures! < 10) {
      return 20;
    } else if (structures! < 40) {
      return 20;
    } else if (structures! > 40) {
      return 30;
    } else {
      return 0;
    }
  }

  int defaultMark3Structures() {
    if (structures! == 0) {
      return 0;
    } else if (structures! < 10) {
      return 3;
    } else if (structures! < 40) {
      return 6;
    } else if (structures! > 40) {
      return 10;
    } else {
      return 0;
    }
  }

  int defaultFoldATankStructures() {
    return ((structures! ~/ 5) * 4);
  }

  int defaultUnleadedGas() {
    if (structures! == 0) {
      return 0;
    } else if (structures! < 10) {
      return 30;
    } else if (structures! < 40) {
      return 90;
    } else if (structures! > 40) {
      return 300;
    } else {
      return 0;
    }
  }

  int defaultTwoCycleOil() {
    if (structures! == 0) {
      return 0;
    } else if (structures! < 10) {
      return 6;
    } else if (structures! < 40) {
      return 18;
    } else if (structures! > 40) {
      return 60;
    } else {
      return 0;
    }
  }

  int defaultPortaPottiesStructures() {
    if (structures! == 0) {
      return 0;
    } else if (structures! < 10) {
      return 5;
    } else if (structures! < 40) {
      return 6;
    } else if (structures! > 40) {
      return 10;
    } else {
      return 0;
    }
  }

  int defaultFoam() {
    if (structures! == 0) {
      return 0;
    } else if (structures! < 10) {
      return 5;
    } else if (structures! < 40) {
      return 5;
    } else if (structures! > 40) {
      return 5;
    } else {
      return 0;
    }
  }

  String flatFireOrderText() {
    String str = "Trunk Line: $trunkLineLength ft.\n"
        "Lat Line: $latLineLength ft.\n"
        "Toy Hose: $toyLineLength ft.\n\n";

    str += "1.5\" Gated Wye: $onePointFiveInchWye\n"
        "1.5\" Reducers: $onePointFiveInchReducer\n"
        "1\"-3/4\" Reducers: $fittings\n"
        "Forester Nozzles: $fittings\n"
        "Toy Nozzles: $fittings\n"
        "Toy Wye: $fittings\n\n";

    str += "Folda-tank: $foldaTanks\n"
        "Mark 3 + Kits: $mark3Kits\n"
        "Pump Mix (Cans): $pumpCans\n\n";
    str += "Water (Pallets): $waterPallets\n"
        "Gatorade (Pallets): $gatoradePallets\n"
        "MRE (Pallets): $mrePallets\n"
        "Port-a-Potties: $portaPottiesPallets\n\n";

    return str;
  }

  String structureFireOrderText() {
    String str = "\nSprinkler Kits: $sprinklerKits\n"
        "1.5 hose: $_onePointFiveHose\n"
        "1.0 hose: $_oneInchHose\n\n"
        "1.5 Gated Wye: $onePointFiveInchWye\n"
        "1.0 Gated Wye: $_oneInchWye\n"
        "1.5-1.0 Reducer: $onePointFiveInchReducer\n"
        "KK Nozzles: $_kkNozzles\n\n"
        "Mark 3 Pumps: $mark3Kits\n"
        "Mark 3 Kits: $mark3Kits\n\n"
        "Fold-a-Tanks: $foldaTanks\n\n"
        "Unleaded Gas (Gallons): $_unleadedGas\n"
        "2 Cycle Oil (Quart): $_twoCycleOil\n"
        "Port-a-Potties (1500 Gallon): $portaPottiesPallets\n"
        "Foam (Cans): $_foam\n";
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
        'fittings': fittings,
        'onePointFiveInchWye': onePointFiveInchWye,
        'onePointFiveInchReducer': onePointFiveInchReducer,
        'foldaTanks': foldaTanks,
        'mark3Kits': mark3Kits,
        'pumpCans': pumpCans,
        'waterPallets': waterPallets,
        'gatoradePallets': gatoradePallets,
        'mrePallets': mrePallets,
        'portaPottiesPallets': portaPottiesPallets,
        'sprinklerKits': sprinklerKits
      };

  Estimate.fromMap({required Map map})
      : id = map['id'],
        engagementId = map['engagementId'],
        newName = map['name'],
        createdAt = DateTime.parse(map['createdAt']),
        acres = map['acres'],
        structures = map['structures'],
        trunkLineLength = map['truckLineLength'],
        latLineLength = map['latLineLength'],
        toyLineLength = map['toyLineLength'],
        fittings = map['fittings'],
        onePointFiveInchWye = map['onePointFiveInchWye'],
        onePointFiveInchReducer = map['onePointFiveInchReducer'],
        foldaTanks = map['foldaTanks'],
        mark3Kits = map['mark3Kits'],
        pumpCans = map['pumpCans'],
        waterPallets = map['waterPallets'],
        gatoradePallets = map['gatoradePallets'],
        mrePallets = map['mrePallets'],
        portaPottiesPallets = map['portaPottiesPallets'],
        sprinklerKits = map['sprinklerKits'];
}
