import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

import './db_service.dart';

abstract class DBProvider {
  bool isTableExists = false;

  String sqlString();
  String tableName();

  @mustCallSuper
  Future<Database> open() async {
    if (!isTableExists) {
      await prepare(tableName(), sqlString());
    }
    return await DBService.db;
  }

  @mustCallSuper
  Future<void> prepare(tableName, String createSql) async {
    isTableExists = await DBService.isTableExists(tableName);
    if (!isTableExists) {
      Database db = await DBService.db;
      return await db.execute(createSql);
    }
  }
}
