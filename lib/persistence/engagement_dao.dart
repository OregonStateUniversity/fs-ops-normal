import 'database_manager.dart';
import 'engagement_dto.dart';
import '../models/engagement.dart';

class EngagementDAO {
  
  static final sqlSelectActive =
      DatabaseManager.SQL['engagements']!['selectActive']!;
  static final sqlSelectInactive =
      DatabaseManager.SQL['engagements']!['selectInactive']!;
  static final sqlInsert =
      DatabaseManager.SQL['engagements']!['insert']!;
  static final sqlDelete =
      DatabaseManager.SQL['engagements']!['delete']!;
  static final sqlReactivate =
      DatabaseManager.SQL['engagements']!['reactivate']!;
  static final sqlDeactivate =
      DatabaseManager.SQL['engagements']!['deactivate']!;

  static Future<List<Engagement>> activeEngagements(
      {required DatabaseManager databaseManager}) async {
    final engagementRecords =
        await databaseManager.select(sql: sqlSelectActive);
    return engagementRecords
        .map((row) => Engagement.fromMap(map: row))
        .toList();
  }

  static Future<List<Engagement>> inactiveEngagements(
      {required DatabaseManager databaseManager}) async {
    final engagementRecords =
        await databaseManager.select(sql: sqlSelectInactive);
    return engagementRecords
        .map((row) => Engagement.fromMap(map: row))
        .toList();
  }

  static Future save(
      {required DatabaseManager databaseManager,
      required EngagementDTO dto}) async {
    databaseManager.insert(
        sql: sqlInsert,
        values: [dto.name, dto.createdAt.toString(), dto.active]);
  }

  static Future delete(
      {required DatabaseManager databaseManager,
      required Engagement engagement}) async {
    databaseManager.delete(
        sql: sqlDelete,
        id: engagement.id!);
  }

  static Future reactivate(
      {required DatabaseManager databaseManager,
      required Engagement engagement}) async {
    databaseManager.update(
        sql: sqlReactivate,
        values: [engagement.id!]);
  }

  static Future deactivate(
      {required DatabaseManager databaseManager,
      required Engagement engagement}) async {
    databaseManager.update(
      sql: sqlDeactivate,
      values: [engagement.id!]);
  }

}
