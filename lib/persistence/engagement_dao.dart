import 'database_manager.dart';
import '../models/engagement.dart';

class EngagementDAO {

  static final sqlSelect = DatabaseManager.SQL['engagements']!['select'];

  static Future<List<Engagement>> engagements({required DatabaseManager databaseManager}) async {
    final engagementRecords = await databaseManager.select(sql: sqlSelect!);
    return engagementRecords.map( (row) => Engagement.fromMap(map: row) ).toList();
  }

}
