import 'package:washpro/data/models/api/bag/model.dart';
import 'package:washpro/data/models/scan_result.dart';

abstract class BagRepository {
  void dispose();
  Future<List<Bag>> getBagsByStatus(String status);
  Future<void> updateBagStatus(ScanResult scan, String status);
}
