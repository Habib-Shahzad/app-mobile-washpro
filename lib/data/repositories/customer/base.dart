import 'package:washpro/data/models/api/getCustomers/model.dart';
import 'package:washpro/data/models/api/getOrders/model.dart';

abstract class CustomerRepository {
  Future<CustomersResponse> getCustomers();
  Future<List<Order>> getCustomerOrders(String id);
  void dispose();
}
