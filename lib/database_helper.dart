import 'dart:convert';
import 'package:sqflite/sqflite.dart';

// https://www.youtube.com/watch?v=GZfFRv9VWtU

class DatabaseHelper{
  static Database _database;

  static Future<Database> getDBConnector() async{
    if (_database != null){
      return _database;
    }

    return await _initDatabase();
  }

  static Future<Database> _initDatabase() async{
    _database = await openDatabase(
        'engagements.db', version: 1, onCreate: (Database db, int version) async{
      await db.execute(
          'CREATE TABLE IF NOT EXISTS engagements(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, timeStamp TEXT NOT NULL, acres INTEGER NOT NULL, orders TEXT NOT NULL);'
          );
        }
    );

    return _database;
  }

  static Future<void> insertEngagement(dto) async{
    final Database db = await getDBConnector();

    await db.transaction((txn) async {
      await txn.rawInsert('INSERT INTO engagements(name, timeStamp, acres, orders) VALUES(?, ?, ?, ?)',
          [dto.name, dto.fireTimeStamp, dto.size, "[]"]
      );
    });
  }

  static Future<void> deleteEngagement(index) async{
    final Database db = await getDBConnector();

    await db.transaction((txn) async {
      await txn.rawDelete('DELETE FROM engagements WHERE id = $index');
    });
  }

  static Future<void> insertOrder(eng, order) async{
    final Database db = await getDBConnector();
    eng.orders.add(order);
    await db.transaction((txn) async {
      String tmp = "'[";
      eng.orders.forEach((value) {
        tmp += json.encode(value.toJson());
        if((eng.orders.last != value)){
          tmp += ", ";
        }
      });
      tmp += "]'";
      await txn.rawUpdate('UPDATE engagements SET orders = ${tmp.toString()} WHERE id = ${eng.primaryKey}',
      );
    });
  }

  static Future<void> deleteOrder(eng, order) async{
    final Database db = await getDBConnector();

    eng.orders.reversed.toList().remove(order);
    var newOrderList = eng.orders;

    await db.transaction((txn) async {
      String tmp = "'[";
      newOrderList.forEach((value) {
        tmp += json.encode(value.toJson());
        if(newOrderList.last != value){
          tmp += ", ";
        }
      });
      tmp += "]'";
      await txn.rawUpdate('UPDATE engagements SET orders = $tmp WHERE id = ${eng.primaryKey}');
    });
  }
}