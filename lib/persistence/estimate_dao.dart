import 'database_manager.dart';
import '../models/engagement.dart';
import '../models/estimate.dart';

class EstimateDAO {

  static const SQL_SELECT = "SELECT * FROM estimates WHERE engagementId = ? ORDER BY createdAt DESC;";
  static const SQL_DELETE = "DELETE FROM estimates WHERE estimateId = ?;";
  static const SQL_INSERT = "INSERT INTO estimates(engagementId, name, createdAt, acres, structures) VALUES (?, ?, ?, ?, ?);";

  static Future<List<Estimate>> estimates({required DatabaseManager databaseManager, required Engagement engagement}) async {
    final estimateRecords = await databaseManager.selectWhere(sql: SQL_SELECT, values: [engagement.id]);
    return estimateRecords.map( (row) => Estimate.fromMap(map: row) ).toList();
  }

  static Future<void> delete({required DatabaseManager databaseManager, required Estimate estimate}) async {
    final id = estimate.id;
    if (id != null) databaseManager.delete(sql: SQL_DELETE, id: id);
  }

  static Future<void> save({required DatabaseManager databaseManager, required Engagement engagement, required Estimate estimate}) async {
    final engagementId = engagement.id;
    if (engagementId != null) {
      databaseManager.insert(sql: SQL_INSERT, values: [engagementId, estimate.name, estimate.createdAt.toString(), estimate.acres, estimate.structures]);
    }
  }
}
