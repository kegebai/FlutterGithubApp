import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../app/utils/codec_util.dart';
import './db_provider.dart';
import '../models/repo.dart';

class RepoDBProvider extends DBProvider {
  static final String tbName = "Repos";
  // static final String columnId = "_id";
  // static final String columnUsername = "username";
  // static final String columnData = "data";

  int id;
  String username;
  String data;

  RepoDBProvider();

  RepoDBProvider.fromMap(Map map) {
    id = map[columnId];
    username = map[columnUsername];
    data = map[columnData];
  }

  Map<String, dynamic> _toMap(String name, String data) {
    Map<String, dynamic> map = {
      columnUsername: name,
      columnData: data,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  // @override
  // String sqlString() {
  //   return '''
  //   CREATE TABLE $tableName (
  //     $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
  //     $columnUsername text non null,
  //     $columnData text non null
  //   );
  //   ''';
  // }

  @override
  String tableName() => tbName;

  Future _getProvider(Database db, String name) async {
    List<Map<String, dynamic>> maps = await db.query(
      tbName,
      columns: [columnId, columnUsername, columnData],
      where: '$columnUsername = ?',
      whereArgs: [name],
    );
    if (maps.isNotEmpty) {
      return RepoDBProvider.fromMap(maps.first);
    }
    return null;
  }

  Future<int> insert(String name, String event) async {
    var db = await open();
    var provider = await _getProvider(db, name);
    if (provider != null) {
      await db.delete(
        tbName, 
        where: '$columnUsername = ?',
        whereArgs: [name],
      );
    }
    return await db.insert(tbName, _toMap(name, event));
  }

  Future<List<Repo>> getRepos(String name) async {
    var db = await open();
    var provider = await _getProvider(db, name);
    if (provider != null) {
      List<Repo> list = new List();
      List<dynamic> items = await compute (
        CodecUtil.decodeList,
        provider.data as String,
      );

      if (items.isNotEmpty) {
        for (var item in items) {
          list.add(Repo.fromJson(item));
        }
        return list;
      }
    }
    return null;
  }
}