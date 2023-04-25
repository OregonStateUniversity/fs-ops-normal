class Estimate {
  static const baseTrunkLineLength = 1000;
  static const trunkLineLengthPerAcre = 200;

  int? id;
  int? engagementId;
  String? newName;
  DateTime? createdAt;

  String? name;
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
  int? onePointFiveHose;
  int? oneInchHose;
  int? onePointFiveInchWye;
  int? oneInchWye;
  int? onePointFiveInchReducer;
  int? kkNozzles;
  int? mark3Structures;
  int? foldaTankStructures;
  int? mark3Kits;
  int? unleadedGas;
  int? twoCycleOil;
  int? foam;

  int? get trunkLine => trunkLineLength;
  int? get latLine => latLineLength;
  int? get toyLine => toyLineLength;
  int? get variousFittings => fittings;

  set trunkLine(int? length) => trunkLineLength;
  set latLine(int? length) => latLineLength;
  set toyLine(int? length) => toyLineLength;
  set variousFittings(int? count) => fittings;

  Estimate({
    this.name = "",
    this.timeStamp,
    this.acres = 0,
    this.structures = 0,
  }) {
    initializeSavedProperties();
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
      hoseOnePointFive,
      hoseOneInch,
      wyeOneInch,
      nozzles,
      mark3Struct,
      foldaTankStruct,
      gas,
      oil,
      foamCans,
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
    onePointFiveHose = hoseOnePointFive;
    oneInchHose = hoseOneInch;
    oneInchWye = wyeOneInch;
    kkNozzles = nozzles;
    mark3Structures = mark3Struct;
    foldaTankStructures = foldaTankStruct;
    unleadedGas = gas;
    twoCycleOil = oil;
    foam = foamCans;
  }

  Estimate.finalEstimate(
      this.name,
      this.acres,
      this.structures,
      this.timeStamp,
      trunk,
      lat,
      toy,
      variousFittings,
      oneFiveWye,
      onePointFiveRed,
      foldaTank,
      mark3,
      pumpCan,
      water,
      gatorade,
      mre,
      portaPotties,
      sprinkers,
      oneFiveHose,
      oneHose,
      oneWye,
      kkNozzle,
      mark3Struct,
      foldaTankStruct,
      gas,
      oil,
      foamCan) {
    trunkLineLength = trunk;
    latLineLength = lat;
    toyLineLength = toy;
    fittings = variousFittings;
    onePointFiveInchWye = oneFiveWye;
    onePointFiveInchReducer = onePointFiveRed;
    foldaTanks = foldaTank;
    mark3Kits = mark3;
    pumpCans = pumpCan;
    waterPallets = water;
    gatoradePallets = gatorade;
    mrePallets = mre;
    portaPottiesPallets = portaPotties;
    sprinklerKits = sprinkers;
    onePointFiveHose = oneFiveHose;
    oneInchHose = oneHose;
    oneInchWye = oneWye;
    kkNozzles = kkNozzle;
    mark3Structures = mark3Struct;
    foldaTankStructures = foldaTankStruct;
    unleadedGas = gas;
    twoCycleOil = oil;
    foam = foamCan;
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
      json["sprinklerKits"],
      json["onePointFiveHose"],
      json["oneInchHose"],
      json["oneInchWye"],
      json["kkNozzles"],
      json["mark3Structures"],
      json["foldaTankStructures"],
      json["unleadedGas"],
      json["twoCycleOil"],
      json["foam"] ?? 0);

  void initializeSavedProperties() {
    trunkLineLength = defaultTrunkLineLength();
    latLineLength = defaultLatLineLength();
    toyLineLength = defaultToyLineLength();
    fittings = defaultFittings();
    onePointFiveInchWye = defaultOnePointFiveWye();
    onePointFiveInchReducer = defaultOnePointFiveToOneInchReducer();
    foldaTanks = defaultFoldaTanksAcres();
    mark3Kits = defaultMark3PumpsAcres();
    pumpCans = defaultPumpMixCansAcres();
    waterPallets = defaultWaterPallets();
    gatoradePallets = defaultGatoradePallets();
    mrePallets = defaultMrePallets();
    portaPottiesPallets = defaultPortaPottiesAcres();
    sprinklerKits = defaultSprinklerKits();
    onePointFiveHose = defaultOnePointFiveHose();
    oneInchHose = defaultOneInchHose();
    oneInchWye = defaultOneInchWye();
    kkNozzles = defaultKkNozzles();
    mark3Structures = defaultMark3Structures();
    foldaTankStructures = defaultFoldATankStructures();
    unleadedGas = defaultUnleadedGas();
    twoCycleOil = defaultTwoCycleOil();
    foam = defaultFoam();
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
    } else {
      return 5;
    }      
  }

  String flatFireOrderText() {
    String str =
        "Trunk Line & 1.5\" Synthetic Hose (NFES#: 001239):  $trunkLineLength ft.\n"
        "1\" Lateral Line (NFES#: 001238):  $latLineLength ft.\n"
        "Toy Hose (NFES#: 001016):  $toyLineLength ft.\n\n";

    str += "1.5\" Gated Wye (NFES# 000231):  $onePointFiveInchWye\n"
        "1.5\" Reducers (NFES#: 000010):  $onePointFiveInchReducer\n"
        "1\"-3/4\" Reducers (NFES# 000733):  $fittings\n"
        "Forester Nozzles (NFES# 000024):  $fittings\n"
        "Toy Nozzles (NFES# 007387):  $fittings\n"
        "Toy Wye (NFES# 000904):  $fittings\n\n";

    str += "Folda-tank (NFES# 000664):  $foldaTanks\n"
        "Mark 3 + Kits (NFES# 003870):  $mark3Kits\n"
        "Pump Mix (Cans):  $pumpCans\n\n";
    str += "Water (Pallets):  $waterPallets\n"
        "Gatorade (Pallets):  $gatoradePallets\n"
        "MRE (Pallets) (NFES# 001842):  $mrePallets\n"
        "Port-a-Potties:  $portaPottiesPallets\n\n";
    return str;
  }

  String structureFireOrderText() {
    String str = "\nSprinkler Kits (NFES# 001048): $sprinklerKits\n"
        "1.5 hose (NFES# 001239):  $onePointFiveHose\n"
        "1.0 hose (NFES# 001238):  $oneInchHose\n\n"
        "1.5 Gated Wye (NFES# 000231):  $onePointFiveInchWye\n"
        "1.0 Gated Wye (NFES# 000259):  $oneInchWye\n"
        "1.5-1.0 Reducer (NFES# 000010):  $onePointFiveInchReducer\n"
        "KK Nozzles (NFES# 001081):  $kkNozzles\n\n"
        "Mark 3 Pumps & Kits (NFES# 003870): $mark3Structures\n"
        "Fold-a-Tanks (NFES# 000664):  $foldaTankStructures\n\n"
        "Unleaded Gas (Gallons):  $unleadedGas\n"
        "2 Cycle Oil (Quart):  $twoCycleOil\n"
        "Port-a-Potties (1500 Gallon):  $portaPottiesPallets\n"
        "Foam (Cans):  $foam\n";
    return str;
  }

  String flatFireOrderTextAndNotes() {
    String str = flatFireOrderText();
    str += fireNotes();
    return str;
  }

  String structureFireOrderTextAndNotes() {
    String str = structureFireOrderText();
    str += fireNotes();
    return str;
  }

  String fireNotes() {
    String str = "\nTips for General Message\n"
        "- Incident Response Name:\n"
        "- POC Name:\n"
        "- POC Number:\n"
        "- Dispatch Center:\n"
        "- Drop Points:\n"
        "- Delivery Instructions:\n"
        "- Time/Date Needed:\n"
        "- Comments:\n";
    return str;
  }

  String everythingOrderTextAndNotes() {
    String str = flatFireOrderText() + structureFireOrderText() + fireNotes();
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
        'sprinklerKits': sprinklerKits,
        'onePointFiveHose': onePointFiveHose,
        'oneInchHose': oneInchHose,
        'oneInchWye': oneInchWye,
        'kkNozzles': kkNozzles,
        'mark3Structures': mark3Structures,
        'foldaTankStructures': foldaTankStructures,
        'unleadedGas': unleadedGas,
        'twoCycleOil': twoCycleOil,
        'foam': foam
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
        sprinklerKits = map['sprinklerKits'],
        onePointFiveHose = map["onePointFiveHose"],
        oneInchHose = map["oneInchHose"],
        oneInchWye = map["oneInchWye"],
        kkNozzles = map["kkNozzles"],
        mark3Structures = map["mark3Structures"],
        foldaTankStructures = map["foldaTankStructures"],
        unleadedGas = map["unleadedGas"],
        twoCycleOil = map["twoCycleOil"],
        foam = map["foam"];
}
