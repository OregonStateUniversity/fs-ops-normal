import 'package:flutter/services.dart' show rootBundle;
import 'package:sqflite/sqflite.dart';

class DatabaseManager {

  static const SCHEMA_FILE_ASSET_PATH = 'assets/db/schema_1.sql.txt';
  static const DATABASE_FILENAME = 'ops_normal.sqlite3.db';
  static const SQL = {
    'engagements': {
      'select': 'SELECT * FROM engagements',
      'select_one': 'SELECT * FROM engagements WHERE id = ?',
      'insert': 'INSERT INTO engagements(name, createdAt, active) VALUES(?, ?, ?)',
      'deactivate': 'UPDATE engagements SET active = FALSE WHERE id = ?',
      'reactivate': 'UPDATE engagements SET active = TRUE WHERE id = ?'
    }
  };

  static DatabaseManager? _instance;
  final Database db;

  DatabaseManager._({required Database database}) : db = database;

  factory DatabaseManager.getInstance() {
    if (_instance == null) {
      initialize();
    }
    return _instance!;
  }

  static Future initialize() async {
    final db = await openDatabase(DATABASE_FILENAME,
      version: 1,
      onCreate: (Database db, int _) async {
        createTables(db, _, await rootBundle.loadString(SCHEMA_FILE_ASSET_PATH));
      },
      onConfigure: _configure
    );
    _instance = DatabaseManager._(database: db);
  }

  static Future _configure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  static void createTables(Database db, int _, String sql) async {
    await db.execute(sql);
  }

  Future<List<Map<String, dynamic>>> select({required String sql}) {
    return db.rawQuery(sql);
  }

}
