import 'package:washpro/data/models/api/bag/model.dart';
import 'package:washpro/data/repositories/bag/base.dart';
import 'package:washpro/services/retrofit/client.dart';
import 'package:washpro/singletons.dart';

class AppBagRepository extends BagRepository {
  @override
  void dispose() {}

  @override
  Future<List<Bag>> getBagsByStatus(String status) async {
    // final client = getIt<AuthRestClient>();
    // final response = await client.getBagsByStatus(status);
    // return response;
    return [];
  }
}
