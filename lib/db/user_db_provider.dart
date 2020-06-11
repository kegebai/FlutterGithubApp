import 'package:flutter/foundation.dart';
import 'package:flutter_github_app/app/codec.dart';
import 'package:sqflite/sqlite_api.dart';

import './db_provider.dart';
import '.././models/user.dart';

class UserDBProvider extends DBProvider {
  static final String tbName = 'User';
  static final String columnId = '_id';
  static final String columnUsername = 'username';
  static final String columnData = 'data';

  int id;
  String username;
  String data;

  UserDBProvider();

  UserDBProvider.fromMap(Map map) {
    id = map[columnId];
    username = map[columnUsername];
    data = map[columnData];
  }

  Map<String, dynamic> _toMap(String username, String data) {
    Map<String, dynamic> map = {
      columnUsername: username,
      columnData: data,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Future _userProvider(Database db, String username) async {
    //var db = await DBService.db;
    List<Map<String, dynamic>> maps = await db.query(
      tbName,
      columns: [columnId, columnUsername, columnData],
      where: '$columnUsername = ?',
      whereArgs: [username],
    );
    if (maps.isNotEmpty) {
      return UserDBProvider.fromMap(maps.first);
    }
    return null;
  }

  Future insert(String username, String event) async {
    var db = await open();
    var userpd = await _userProvider(db, username);
    if (userpd != null) {
      await db.delete(
        tbName, 
        where: '$columnUsername = ?',
        whereArgs: [username],
      );
    }
    return await db.insert(tbName, _toMap(username, event));
  }

  Future<User> getUserInfo(String username) async {
    var db = await open();
    var userpd = await _userProvider(db, username);
    if (userpd != null) {
      var data = await compute(
        Codec.decodeMap,
        userpd.data as String,
      );
      return User.fromJson(data);
    }
    return null;
  }

  @override
  sqlString() => ''' 
  create table $tableName (
    $columnId integer primary key autoincremnt,
    $columnUsername text non null,
    $columnData text non null
    ''';

  @override
  tableName() => tbName;
}
