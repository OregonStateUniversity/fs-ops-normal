import 'database_manager.dart';
import '../models/engagement.dart';
import '../models/estimate.dart';

class EstimateDAO {

  static final sqlSelect = DatabaseManager.SQL['estimates']!['select'];

  static Future<List<Estimate>> estimates({required DatabaseManager databaseManager, required Engagement engagement}) async {
    final estimateRecords = await databaseManager.selectWhere(sql: sqlSelect!, values: [engagement.id]);
    return estimateRecords.map( (row) => Estimate.fromMap(map: row) ).toList();
  }

}
