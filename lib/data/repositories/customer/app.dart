import 'package:retrofit/retrofit.dart';
import 'package:washpro/data/models/api/customer/model.dart';
import 'package:washpro/data/models/api/customers_response/model.dart';
import 'package:washpro/data/models/api/order_with_bags/model.dart';
import 'package:washpro/data/models/api/orders_response/model.dart';
import 'package:washpro/data/repositories/customer/base.dart';
import 'package:washpro/services/retrofit/auth_client.dart';
import 'package:washpro/singletons.dart';

class AppCustomerRepository extends CustomerRepository {
  @override
  void dispose() {}

  @override
  Future<CustomersResponse> getCustomers() async {
    final client = getIt<AuthRestClient>();
    final response = await client.getCustomers();
    return response;
  }

  @override
  Future<Customer> getCustomer(int id) async {
    final client = getIt<AuthRestClient>();
    final response = await client.getCustomer(id);
    return response;
  }

  @override
  Future<OrderWithBags> getOrder(int id) async {
    final client = getIt<AuthRestClient>();
    final response = await client.getOrder(id);
    return response;
  }

  @override
  Future<List<OrderWithBags>> getCustomerOrders(String id) async {
    final client = getIt<AuthRestClient>();
    final response = await client.getCustomerOrders(id);
    return response;
  }

  @override
  Future<OrdersResponse> getOrders() async {
    final client = getIt<AuthRestClient>();
    final response = await client.getOrders('scheduled');
    return response;
  }

  @override
  Future<OrderWithBags> addBag(int orderID, String bagID) async {
    final client = getIt<AuthRestClient>();
    final response = await client.addBag(orderID, bagID);
    return response;
  }

  @override
  Future<HttpResponse> printTicket(
    int id,
    String bagID,
    String bagWeight,
    String itemsCount,
  ) async {
    final client = getIt<AuthRestClient>();
    final response = await client.printTicket(id, bagID, bagWeight, itemsCount);
    return response;
  }
}
