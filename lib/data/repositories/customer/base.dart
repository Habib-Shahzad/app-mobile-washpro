import 'package:retrofit/retrofit.dart';
import 'package:washpro/data/models/api/customer/model.dart';
import 'package:washpro/data/models/api/getCustomers/model.dart';
import 'package:washpro/data/models/api/getOrders/model.dart';

abstract class CustomerRepository {
  Future<Customer> getCustomer(int id);
  Future<CustomersResponse> getCustomers();
  Future<Order> getOrder(int id);
  Future<OrdersResponse> getOrders();
  Future<List<Order>> getCustomerOrders(String id);
  Future<HttpResponse> printTicket(
    int id,
    String bagID,
    String bagWeight,
    String itemsCount,
  );

  void dispose();
}
