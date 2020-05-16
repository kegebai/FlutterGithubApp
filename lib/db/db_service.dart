///
/// File: db_service.dart
/// 
/// Created by kege <kegebai@gmail.com> on 2020-04-30
/// Copyright © 2020 BLH .inc
/// 
/// Code as poetry.
/// All we can do is our best, and sometimes the best we can do is to start over.
///
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

import '../app/dlog.dart';
import '../models/user.dart';
import '../repositories/itf/user_repository.dart';

class DBService {
  static const _VERSION = 1;
  static const _NAME = 'flutter_github_app.db';
    
  static Future<Database> get db async => _db ??= await _initDatabase();

  static UserRepository _userRepo;
  static Database _db;

  /// Initialize the database.
  static Future<Database> _initDatabase() async {
    // Open the database
    var dbsp = await getDatabasesPath();
    // When user is visitor the database name is `flutter_github_app.db`.
    String _dbName = _NAME;

    User user = await _userRepo.getLocalUserInfo();
    if (user != null && user.login != null) {
      // When user login the database name is `user_flutter_github_app.db`
      _dbName = user.login + '_' + _NAME;
    }

    var dbp = path.join(dbsp, _dbName);
    var exists = await databaseExists(dbp);

    if (!exists) {
      try {
        await Directory(path.dirname(dbp)).create(recursive: true);
        Dlog.log('+++++++ DB ### Copy is complete +++++++');
      } catch (e) {
        Dlog.log('xxxxxxx DB ### Copy is failure xxxxxxx');
        Dlog.log(e);
      }

      ByteData data = await rootBundle.load(path.join('assets/db', _dbName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(dbp).writeAsBytes(bytes, flush: true);
    } else {
      Dlog.log('******* The database already exists *******');
    }

    // return await openDatabase(dbp, version: _VERSION, readOnly: true,
    //     onCreate: (Database db, int version) async {
    //   // When creating the db, create the table
    //   String createSql =
    //       'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)';
    //   await db.execute(createSql);
    // });

    return await openDatabase(dbp, version: _VERSION, readOnly: true);
  }

  /// According to `'tableName'` to 
  /// determine whether the table exists in the database.
  static isTableExists(String tableName) async {
    var _database = await db;
        
    String checkSql =
        "select * from Sqlite_master where type = 'table' and name = '$tableName'";
    var res = await _database.rawQuery(checkSql);

    return null != res && res.length > 0;
  }

  /// Closed the database
  static close() {
    _db?.close();
    _db = null;
  }
}
