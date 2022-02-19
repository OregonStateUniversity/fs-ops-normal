import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier{

  final darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: Colors.blue,
    accentColor: Colors.white,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12
  );

  final lightTheme = ThemeData(
      primarySwatch: Colors.red,
      primaryColor: Colors.white,
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      accentColor: Colors.redAccent,
      accentIconTheme: IconThemeData(color: Colors.white),
      dividerColor: Colors.white12
  );

  ThemeData _themeData;

  ThemeChanger(this._themeData);

  getTheme() => _themeData;


  setTheme(ThemeData theme){
    _themeData = theme;
    notifyListeners();
  }

  void setDarkMode() async{
    _themeData = darkTheme;
    //manager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async{
    _themeData = lightTheme;
    //manager.saveData('themeMode', 'light');
    notifyListeners();
  }
}