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
          'CREATE TABLE IF NOT EXISTS engagements(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, timeStamp TEXT NOT NULL, acres INTEGER NOT NULL, active INTEGER NOT NULL, orders TEXT NOT NULL);'
          );
        }
    );

    return _database;
  }

  static Future<List<Map>> getAllEngagements() async{
    final Database db = await getDBConnector();
    var records = await db.rawQuery('SELECT * FROM engagements');
    return records;
  }

  static Future<void> deleteALLDataFromDatabase() async{
    print("Database Deleted");
    await deleteDatabase('engagements.db');
  }

  static Future<void> insertEngagement(dto) async{
    final Database db = await getDBConnector();

    await db.transaction((txn) async {
      await txn.rawInsert('INSERT INTO engagements(name, timeStamp, acres, active, orders) VALUES(?, ?, ?, ?, ?)',
          [dto.name, dto.timeStamp, dto.size, 1, "[]"]
      );
    });
  }

  static Future<void> deleteEngagement(index) async{
    final Database db = await getDBConnector();

    await db.transaction((txn) async {
      await txn.rawDelete('DELETE FROM engagements WHERE id = $index');
    });
  }

  static Future<void> archiveEngagement(index) async{
    final Database db = await getDBConnector();

    await db.transaction((txn) async{
      await txn.rawUpdate('UPDATE engagements SET active = 0 WHERE id = $index');
    });
  }

  static Future<void> unarchiveEngagement(index) async{
    final Database db = await getDBConnector();

    await db.transaction((txn) async{
      await txn.rawUpdate('UPDATE engagements SET active = 1 WHERE id = $index');
    });
  }

  static Future<void> insertOrder(eng, order) async{
    final Database db = await getDBConnector();
    eng.orders.insert(0,order);
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

    eng.orders.toList().remove(order);
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