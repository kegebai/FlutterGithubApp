import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/global/global_state.dart';
import '.././app/cons.dart';

class LocalStorage {
  final MaterialColor color;
  final String language;
  final String fontFamily;

  LocalStorage({this.color, this.language, this.fontFamily});

  LocalStorage copyWith({
    MaterialColor color,
    String language,
    String fontFamily,
  }) =>
      LocalStorage(
        color: color ?? this.color,
        language: language ?? this.language,
        fontFamily: fontFamily ?? this.fontFamily,
      );

  /// Private getter
  Future<SharedPreferences> get _sps async => await SharedPreferences.getInstance();

  /// 
  Future<GlobalState> initApp() async {
    var sp = await _sps;

    var themeIndex = sp.get(Cons.themeColorIndex) ?? 4;
    var fontIndex = sp.get(Cons.fontFamilyIndex) ?? 0;
    var languageIndex = sp.get(Cons.languageIndex) ?? 0;

    return GlobalState(LocalStorage(
      color: Cons.themeColorSupport.keys.toList()[themeIndex],
      fontFamily: Cons.fontFamilySupport[fontIndex],
      language: Cons.languageSupport[languageIndex],
    ));
  }

  Future<void> setFontFamily(String fontFamily) async {
    var sp = await _sps;
    var index = Cons.fontFamilySupport.indexOf(fontFamily);
    sp.setInt(Cons.fontFamilyIndex, index);
  }

  Future<String> getFontFamily() async {
    var sp = await _sps;
    return Cons.fontFamilySupport[sp.get(Cons.fontFamilyIndex)];
  }

  Future<void> setThemeColor(MaterialColor color) async {
    var sp = await _sps;
    var index = Cons.themeColorSupport.keys.toList().indexOf(color);
    sp.setInt(Cons.themeColorIndex, index);
  }

  Future<String> getTheme() async {
    var sp = await _sps;
    var key = Cons.themeColorSupport.keys.toList()[sp.get(Cons.themeColorIndex)];
    return Cons.themeColorSupport[key];
  }

  Future<void> setLanguage(String language) async {
    var sp = await _sps;
    var index = Cons.languageSupport.indexOf(language);
    sp.setInt(Cons.languageIndex, index);
  }

  Future<String> getLanguage() async {
    var sp = await _sps;
    return Cons.languageSupport[sp.get(Cons.languageIndex)]; 
  }

  ///
  Future<void> save(String key, value) async {
    var sp = await _sps;
    sp.setString(key, value);
  }

  ///
  Future<String> get(String key) async {
    var sp = await _sps;
    return sp.get(key);
  }

  ///
  Future<void> remove(String key) async {
    var sp = await _sps;
    sp.remove(key);
  } 

}
