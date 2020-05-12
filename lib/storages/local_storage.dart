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
    var _sp = await _sps;

    var themeIndex = _sp.get(Cons.themeColorIndex) ?? 4;
    var fontIndex = _sp.get(Cons.fontFamilyIndex) ?? 0;
    var languageIndex = _sp.get(Cons.languageIndex) ?? 0;

    return GlobalState(LocalStorage(
      color: Cons.themeColorSupport.keys.toList()[themeIndex],
      fontFamily: Cons.fontFamilySupport[fontIndex],
      language: Cons.languageSupport[languageIndex],
    ));
  }

  setFontFamily(String fontFamily) async {
    var _sp = await _sps;
    var index = Cons.fontFamilySupport.indexOf(fontFamily);
    _sp.setInt(Cons.fontFamilyIndex, index);
  }

  getFontFamily() {}

  setThemeColor(MaterialColor color) async {
    var _sp = await _sps;
    var index = Cons.themeColorSupport.keys.toList().indexOf(color);
    _sp.setInt(Cons.themeColorIndex, index);
  }

  getTheme() {}

  setLanguage(String language) async {
    var _sp = await _sps;
    var index = Cons.languageSupport.indexOf(language);
    _sp.setInt(Cons.languageIndex, index);
  }

  getLanguage() {}

  setToken(String key, value) async {
    var _sp = await _sps;
    _sp.setString(key, value);
  }

  getToken(String key) async {
    var _sp = await _sps;
    _sp.get(key);
  }

  removeToken(String key) async {
    var _sp = await _sps;
    _sp.remove(key);
  }
}
