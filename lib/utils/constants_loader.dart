import 'dart:async' show Future;
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;
import 'constants.dart';

class ConstantsLoader {
  final String constantsPath;

  ConstantsLoader({required this.constantsPath});
  Future<Constants> load() {
    return rootBundle.loadStructuredData<Constants>(constantsPath,
        (jsonStr) async {
      final constants = Constants.fromJson(json.decode(jsonStr));
      return constants;
    });
  }
}
