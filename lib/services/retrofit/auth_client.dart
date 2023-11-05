import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:washpro/data/models/api/bag/model.dart';
import 'package:washpro/data/models/api/customer/model.dart';
import 'package:washpro/data/models/api/customers_response/model.dart';
import 'package:washpro/data/models/api/order_with_bags/model.dart';
import 'package:washpro/data/models/api/orders_response/model.dart';

import 'ip.dart';
part 'auth_client.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class AuthRestClient {
  factory AuthRestClient(Dio dio, {String baseUrl}) = _AuthRestClient;

  @GET("orders/")
  Future<OrdersResponse> getOrders(
    @Query('status') String status,
  );

  @GET("customer/")
  Future<CustomersResponse> getCustomers();

  @GET("customer/{id}")
  Future<Customer> getCustomer(
    @Path('id') int id,
  );

  @GET("orders/{id}")
  Future<OrderWithBags> getOrder(
    @Path('id') int id,
  );

  @PATCH("orders/{id}/")
  Future<OrderWithBags> patchOrder(
    @Path('id') int id,
    @Body() PatchOrder order,
  );

  @GET("orders/{id}/print-ticket/")
  Future<HttpResponse> printTicket(
    @Path('id') int id,
    @Query('bag_id') String bagID,
    @Query('bag_weight') double bagWeight,
    @Query('items_count') int itemsCount,
  );

  @GET("customer/{id}/orders/")
  Future<List<OrderWithBags>> getCustomerOrders(@Path("id") String id);

  @GET("bag/bags-by-status/")
  Future<List<Bag>> getBagsByStatus(@Query("status") String status);

  @GET("orders/{orderID}/change-bag-status/")
  Future<HttpResponse> updateBagStatus(@Path("orderID") int orderID,
      @Query("bag_id") String bagID, @Query("bag_status") String bagStatus);

  @GET("orders/{id}/add-bag/")
  Future<OrderWithBags> addBag(
    @Path('id') int id,
    @Query('bag_id') String bagID,
  );

  @GET("orders/{id}/remove-bag/")
  Future<OrderWithBags> removeBag(
    @Path('id') int id,
    @Query('bag_id') String bagID,
  );
}
