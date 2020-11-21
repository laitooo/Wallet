import 'dart:async';

import 'package:Wallet/models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

class AppDatabase {
  static Database sqliteDb;
  static String databaseName = "records.db";
  static String tableName = "records";
  static final columns = [
    "id",
    "name",
    "currency",
    "credit",
    "debit",
    "balance"
  ];

  static Future init() async {
    String databasesPath = await getDatabasesPath();
    String userDBPath = join(databasesPath, '$databaseName');
    sqliteDb = await openDatabase(
      userDBPath,
      version: 1,
      onCreate: (Database db, int version) async {
        db.execute('''CREATE TABLE IF NOT EXISTS records (
          id INTEGER,
          name TEXT,
          currency INTEGER,
          credit DOUBLE,
          debit DOUBLE,
          balance DOUBLE)''');
      },
    );
  }

  checkDatabase() {
    if (sqliteDb == null) {
      init();
    }
  }

  insertRecord(Record record) {
    checkDatabase();
    sqliteDb.insert(tableName, record.toMap());
  }

  Future<List<Record>> getAllProducts() async {
    checkDatabase();
    List<Map> results =
        await sqliteDb.query(tableName, columns: columns, orderBy: "id ASC");

    List<Record> records = new List();
    results.forEach((result) {
      Record record = Record.fromMap(result);
      records.add(record);
    });
    return records;
  }
}
