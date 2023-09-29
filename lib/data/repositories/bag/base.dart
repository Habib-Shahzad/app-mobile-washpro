import 'package:washpro/data/models/api/bag/model.dart';

abstract class BagRepository {
  void dispose();
  Future<List<Bag>> getBagsByStatus(String status);
  Future<void> updateBagStatus(Bag bag, String status);
}
