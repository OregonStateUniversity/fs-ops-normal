import 'database_manager.dart';
import 'engagement_dto.dart';
import '../models/engagement.dart';

class EngagementDAO {
  
  static const SQL_SELECT_ALL = "SELECT * FROM engagements ORDER BY createdAt DESC;";
  static const SQL_SELECT_ACTIVE = "SELECT * FROM engagements WHERE active = 1 ORDER BY createdAt DESC;";
  static const SQL_SELECT_INACTIVE = "SELECT * FROM engagements WHERE active = 0 ORDER BY createdAt DESC;";
  static const SQL_SELECT_ONE = "SELECT * FROM engagements WHERE id = ?;";
  static const SQL_INSERT = "INSERT INTO engagements(name, createdAt, active) VALUES (?, ?, ?);";
  static const SQL_DEACTIVATE = "UPDATE engagements SET active = 0 WHERE id = ?;";
  static const SQL_REACTIVATE = "UPDATE engagements SET active = 1 WHERE id = ?;";
  static const SQL_DELETE = "DELETE FROM engagements WHERE id = ?;";

  static Future<List<Engagement>> activeEngagements(
      {required DatabaseManager databaseManager}) async {
    final engagementRecords =
        await databaseManager.select(sql: SQL_SELECT_ACTIVE);
    return engagementRecords
        .map((row) => Engagement.fromMap(map: row))
        .toList();
  }

  static Future<List<Engagement>> inactiveEngagements(
      {required DatabaseManager databaseManager}) async {
    final engagementRecords =
        await databaseManager.select(sql: SQL_SELECT_INACTIVE);
    return engagementRecords
        .map((row) => Engagement.fromMap(map: row))
        .toList();
  }

  static Future save(
      {required DatabaseManager databaseManager,
      required EngagementDTO dto}) async {
    databaseManager.insert(
        sql: SQL_INSERT,
        values: [dto.name, dto.createdAt.toString(), dto.active]);
  }

  static Future delete(
      {required DatabaseManager databaseManager,
      required Engagement engagement}) async {
    databaseManager.delete(
        sql: SQL_DELETE,
        id: engagement.id!);
  }

  static Future reactivate(
      {required DatabaseManager databaseManager,
      required Engagement engagement}) async {
    databaseManager.update(
        sql: SQL_REACTIVATE,
        values: [engagement.id!]);
  }

  static Future deactivate(
      {required DatabaseManager databaseManager,
      required Engagement engagement}) async {
    databaseManager.update(
      sql: SQL_DEACTIVATE,
      values: [engagement.id!]);
  }

}
