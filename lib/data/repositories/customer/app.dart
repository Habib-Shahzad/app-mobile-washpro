import 'package:washpro/data/models/api/getCustomers/model.dart';
import 'package:washpro/data/models/api/getOrders/model.dart';
import 'package:washpro/data/repositories/customer/base.dart';
import 'package:washpro/services/retrofit/client.dart';
import 'package:washpro/singletons.dart';

class AppCustomerRepository extends CustomerRepository {
  @override
  void dispose() {}

  @override
  Future<CustomersResponse> getCustomers() async {
    // final client = getIt<AuthRestClient>();
    // final response = await client.getCustomers();
    // return response;

    return CustomersResponse(count: 0, results: []);
  }

  @override
  Future<List<Order>> getCustomerOrders(String id) async {
    // final client = getIt<AuthRestClient>();
    // final response = await client.getCustomerOrders(id);
    // return response;

    return [];
  }
}
