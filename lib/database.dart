import 'dart:async';

import 'package:Wallet/models.dart';
import 'package:path/path.dart';
//import 'package:sqflite/sqflite.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class AppDatabase {
  static String databaseName = "records.db";
  static String tableName = "records";

  static bool started = false;

  static insertRecord(List<dynamic> dataToInsert) async{
    var box = await Hive.openBox(databaseName);
    box.put(tableName, dataToInsert);
  }

  static Future<List<Record>> getAllProducts() async {
    if(!started){
      print("not started database");
    }
    var box = await Hive.openBox(databaseName);
    //print(box.get(tableName));
    List<dynamic> results = box.get(tableName);

    List<Record> records = new List();
    results.forEach((result) {
      Record record = Record.fromDynamic(result);
      records.add(record);
    });
    return records;
  }
}
