import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../../app/utils/codec_util.dart';
import '../../app/db_service.dart';
import '../../models/event.dart';

class EventDao {
  int id;
  String name;
  String data;

  static final String tableName = "t_event";
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

  EventDao();

  EventDao.fromMap(Map map) {
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

  Future<EventDao> _getEventDao(Database db, String name) async {
    List<Map<String, dynamic>> maps = await db.query(
      tableName,
      columns: [cid, cname, cdata],
      where: '$cname = ?',
      whereArgs: [name],
    );
    if (maps != null && maps.isNotEmpty) {
      return EventDao.fromMap(maps.first);
    }
    return null;
  }

  Future<int> addEvent(String name, String event) async {
    var db = await DBService.open(tableName, createSql);
    var provider = await _getEventDao(db, name);
    if (provider != null) {
      await db.delete(tableName, where: '$cname = ?', whereArgs: [name]);
    }
    return await db.insert(tableName, _toMap(name, event));
  }

  Future<List<Event>> getEvents(String name) async {
    var db = await DBService.open(tableName, createSql);
    var provider = await _getEventDao(db, name);
    if (provider != null) {
      List<Event> list = new List();
      List<dynamic> items = await compute(CodecUtil.decodeList, provider.data);

      if (items != null && items.isNotEmpty) {
        for (var item in items) {
          list.add(Event.fromJson(item));
        }
        return list;
      }
    }
    return null;
  }
}
