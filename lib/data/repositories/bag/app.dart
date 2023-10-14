import 'package:washpro/data/models/api/bag/model.dart';
import 'package:washpro/data/repositories/bag/base.dart';
import 'package:washpro/services/retrofit/auth_client.dart';
import 'package:washpro/singletons.dart';

class AppBagRepository extends BagRepository {
  @override
  void dispose() {}

  @override
  Future<List<Bag>> getBagsByStatus(String status) async {
    final client = getIt<AuthRestClient>();
    final response = await client.getBagsByStatus(status);
    return response;
  }

  @override
  Future<void> updateBagStatus(int orderID, String bagID, String status) async {
    final client = getIt<AuthRestClient>();
    final response = await client.updateBagStatus(orderID, bagID, status);

    if (response.response.statusCode != 200) {
      throw Exception("Could not update Bag");
    }
  }
}
