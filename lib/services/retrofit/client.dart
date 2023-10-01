import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:washpro/data/models/api/auth/model.dart';
import 'package:washpro/data/models/api/bag/model.dart';
import 'package:washpro/data/models/api/getCustomers/model.dart';
import 'package:washpro/data/models/api/getOrders/model.dart';
part 'client.g.dart';

const ip = '192.168.100.47';
const baseUrl = "http://$ip:8080/api/";

@RestApi(baseUrl: baseUrl)
abstract class AuthRestClient {
  factory AuthRestClient(Dio dio, {String baseUrl}) = _AuthRestClient;

  @GET("orders/")
  Future<OrdersResponse> getOrders();

  @GET("customer/")
  Future<CustomersResponse> getCustomers();

  @GET("customer/{id}/orders/")
  Future<List<Order>> getCustomerOrders(@Path("id") String id);

  @GET("bag/bags-by-status/")
  Future<List<Bag>> getBagsByStatus(@Query("status") String status);

  @GET("orders/{orderID}/change-bag-status/")
  Future<HttpResponse> updateBagStatus(@Path("orderID") int orderID,
      @Query("bag_id") String bagID, @Query("bag_status") String bagStatus);
}

@RestApi(baseUrl: baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("token/")
  Future<AuthToken> signIn(@Body() body);

  @POST("token/refresh/")
  Future<AuthToken> refresh(@Body() body);

  @POST("token/verify/")
  Future<HttpResponse> verify(@Body() body);
}
