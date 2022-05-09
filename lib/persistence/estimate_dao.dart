import 'database_manager.dart';
import '../models/engagement.dart';
import '../models/estimate.dart';

class EstimateDAO {

  static const SQL_SELECT = "SELECT * FROM estimates WHERE engagementId = ? ORDER BY createdAt DESC;";

  static Future<List<Estimate>> estimates({required DatabaseManager databaseManager, required Engagement engagement}) async {
    final estimateRecords = await databaseManager.selectWhere(sql: SQL_SELECT, values: [engagement.id]);
    return estimateRecords.map( (row) => Estimate.fromMap(map: row) ).toList();
  }

}
