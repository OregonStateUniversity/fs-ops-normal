import 'database_manager.dart';
import 'engagement_dto.dart';
import '../models/engagement.dart';

class EngagementDAO {
  static const sqlSelectAll =
      "SELECT * FROM engagements ORDER BY createdAt DESC;";
  static const sqlSelectActive =
      "SELECT * FROM engagements WHERE active = 1 ORDER BY createdAt DESC;";
  static const sqlSelectInactive =
      "SELECT * FROM engagements WHERE active = 0 ORDER BY createdAt DESC;";
  static const sqlSelectOne = "SELECT * FROM engagements WHERE id = ?;";
  static const sqlInsert =
      "INSERT INTO engagements(name, createdAt, active) VALUES (?, ?, ?);";
  static const sqlDeactivate =
      "UPDATE engagements SET active = 0 WHERE id = ?;";
  static const sqlReactivate =
      "UPDATE engagements SET active = 1 WHERE id = ?;";
  static const sqlDelete = "DELETE FROM engagements WHERE id = ?;";

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
    databaseManager.delete(sql: sqlDelete, id: engagement.id!);
  }

  static Future reactivate(
      {required DatabaseManager databaseManager,
      required Engagement engagement}) async {
    databaseManager.update(sql: sqlReactivate, values: [engagement.id!]);
  }

  static Future deactivate(
      {required DatabaseManager databaseManager,
      required Engagement engagement}) async {
    databaseManager.update(sql: sqlDeactivate, values: [engagement.id!]);
  }
}
