import 'package:sqflite/sqlite_api.dart';

import 'database_manager.dart';
import 'engagement_dto.dart';
import '../models/engagement.dart';

class EngagementDAO {

  static final sqlSelect = DatabaseManager.SQL['engagements']!['select'];

  static Future<List<Engagement>> engagements({required DatabaseManager databaseManager}) async {
    final engagementRecords = await databaseManager.select(sql: sqlSelect!);
    return engagementRecords.map( (row) => Engagement.fromMap(map: row) ).toList();
  }

  static Future save({required DatabaseManager databaseManager, required EngagementDTO dto}) async {
    databaseManager.insert(sql: DatabaseManager.SQL['engagements']!['insert']!,
      values: [dto.name, dto.createdAt.toString(), dto.active]
    );
  }

}
