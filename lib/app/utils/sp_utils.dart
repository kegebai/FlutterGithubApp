///
/// File: sp_utils.dart
/// 
/// Created by kege <kegebai@gmail.com> on 2020-05-02
/// Copyright © 2020 BLH .inc
/// 
/// Code as poetry.
/// All we can do is our best, and sometimes the best we can do is to start over.
///
import 'package:shared_preferences/shared_preferences.dart';

class SPUtils {
  // static SharedPreferences _sps;

  ///
  static Future<SharedPreferences> get sps async => 
      await SharedPreferences.getInstance();
      // _sps ??= await SharedPreferences.getInstance();

  ///
  static save(String key, value) async {
    var sp = await sps;
    sp.setString(key, value);
  }

  ///
  static get(String key) async {
    var sp = await sps;
    return sp.get(key);
  }

  ///
  static remove(String key) async {
    var sp = await sps;
    sp.remove(key);
  } 
}