///
/// File: db_provider.dart
/// 
/// Created by kege <kegebai@gmail.com> on 2020-04-30
/// Copyright © 2020 BLH .inc
/// 
/// Code as poetry.
/// All we can do is our best, and sometimes the best we can do is to start over.
///
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

import './db_service.dart';

abstract class DBProvider {
  bool isTableExists = false;

  sqlString();
  tableName();

  baseSqlString(String tableName, String columnId) {
    return '''
      create table $tableName (
      $columnId integer primary key autoincremnt,
    ''';
  }

  Future<Database> db() async {
    return await open();
  }

  @mustCallSuper
  open() async {
    if (!isTableExists) {
      await prepare(tableName(), sqlString());
    }
    return await DBService.db;
  }

  @mustCallSuper
  prepare(tableName, String createSql) async {
    isTableExists = await DBService.isTableExists(tableName);
    if (!isTableExists) {
      Database db = await DBService.db;
      return await db.execute(createSql);
    }
  }
}
