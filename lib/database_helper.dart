import 'package:sqflite/sqflite.dart';

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
}