import 'package:flutter/foundation.dart';
import 'package:flutter_github_app/db/db_service.dart';
import 'package:sqflite/sqflite.dart';

import '../app/utils/codec_util.dart';
import '.././models/user.dart';

class UserDBProvider {
  int id;
  String name;
  String data;

  static final String tableName = "t_user";
  static final String cid = "id";
  static final String cname = "name";
  static final String cdata = "data";

  static final String createSql = ''' 
    CREATE TABLE IF NOT EXISTS $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        data TEXT NOT NULL,
        created DATETIME NOT NULL,
        updated DATETIME NOT NULL 
    );
  ''';

  UserDBProvider();

  UserDBProvider.fromMap(Map map) {
    id = map[cid];
    name = map[cname];
    data = map[cdata];
  }

  Map<String, dynamic> _toMap(String name, String data) {
    Map<String, dynamic> map = {cname: name, cdata: data};
    if (id != null) {
      map[cid] = id;
    }
    return map;
  }

  Future<UserDBProvider> _getProvider(Database db, String name) async {
    // String sql = "SELECT * FROM t_user WHERE name = ?";
    // List<Map<String, dynamic>> maps = await db.rawQuery(sql, [name]);

    List<Map<String, dynamic>> maps = await db.query(tableName,
        columns: [cname, cname, cdata], where: '$cname = ?', whereArgs: [name]);

    if (maps != null && maps.isNotEmpty) {
      return UserDBProvider.fromMap(maps.first);
    }
    return null;
  }

  ///
  Future<int> addUser(String name, String event) async {
    var db = await DBService.open(tableName, createSql);
    var provider = await _getProvider(db, name);

    if (provider != null) {
      // String deleteSql = "DELETE FROM t_user WHERE name = ?";
      // await db.rawDelete(deleteSql, [name]);
      await db.delete(tableName, where: '$cname = ?', whereArgs: [name]);
    }

    // String sql = "INSERT INTO t_user (name, data) VALUES (?, ?)";
    // return await db.rawInsert(sql, [name, event]);

    return await db.insert(tableName, _toMap(name, event));
  }

  ///
  Future<User> getUser(String name) async {
    var db = await DBService.open(tableName, createSql);
    var provider = await _getProvider(db, name);

    if (provider != null) {
      var data = await compute(CodecUtil.decodeMap, provider.data);
      return User.fromJson(data);
    }
    return null;
  }
}
