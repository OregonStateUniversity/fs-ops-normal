import 'database_manager.dart';
import 'engagement_dto.dart';
import '../models/engagement.dart';

class EngagementDAO {
  static final sqlSelectActive =
      DatabaseManager.SQL['engagements']!['selectActive'];
  static final sqlSelectInactive =
      DatabaseManager.SQL['engagements']!['selectInactive'];

  static Future<List<Engagement>> activeEngagements(
      {required DatabaseManager databaseManager}) async {
    final engagementRecords =
        await databaseManager.select(sql: sqlSelectActive!);
    return engagementRecords
        .map((row) => Engagement.fromMap(map: row))
        .toList();
  }

  static Future<List<Engagement>> inactiveEngagements(
      {required DatabaseManager databaseManager}) async {
    final engagementRecords =
        await databaseManager.select(sql: sqlSelectInactive!);
    return engagementRecords
        .map((row) => Engagement.fromMap(map: row))
        .toList();
  }

  static Future save(
      {required DatabaseManager databaseManager,
      required EngagementDTO dto}) async {
    databaseManager.insert(
        sql: DatabaseManager.SQL['engagements']!['insert']!,
        values: [dto.name, dto.createdAt.toString(), dto.active]);
  }

  static Future delete(
      {required DatabaseManager databaseManager,
      required Engagement engagement}) async {
    databaseManager.delete(
        sql: DatabaseManager.SQL['engagements']!['delete']!,
        id: engagement.id!);
  }

  static Future reactivate(
      {required DatabaseManager databaseManager,
      required Engagement engagement}) async {
    databaseManager.reactivate(
        sql: DatabaseManager.SQL['engagements']!['delete']!,
        id: engagement.id!);
  }
}