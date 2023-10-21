import 'package:retrofit/retrofit.dart';
import 'package:washpro/data/models/api/customer/model.dart';
import 'package:washpro/data/models/api/customers_response/model.dart';
import 'package:washpro/data/models/api/order_with_bags/model.dart';
import 'package:washpro/data/models/api/orders_response/model.dart';

abstract class CustomerRepository {
  Future<Customer> getCustomer(int id);
  Future<CustomersResponse> getCustomers();
  Future<OrderWithBags> getOrder(int id);
  Future<OrdersResponse> getOrders();
  Future<List<OrderWithBags>> getCustomerOrders(String id);
  Future<OrderWithBags> addBag(int orderID, String bagID);
  Future<OrderWithBags> updateOrder(int orderID, PatchOrder order);
  Future<HttpResponse> printTicket(
    int id,
    String bagID,
    String bagWeight,
    String itemsCount,
  );

  void dispose();
}
