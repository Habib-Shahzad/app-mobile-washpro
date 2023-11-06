import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:retrofit/retrofit.dart';
import 'package:washpro/data/models/api/customer/model.dart';
import 'package:washpro/data/models/api/customers_response/model.dart';
import 'package:washpro/data/models/api/order_image/model.dart';
import 'package:washpro/data/models/api/order_with_bags/model.dart';
import 'package:washpro/data/models/api/orders_response/model.dart';
import 'package:washpro/data/repositories/customer/base.dart';
import 'package:washpro/services/retrofit/auth_client.dart';
import 'package:washpro/singletons.dart';

class AppCustomerRepository extends CustomerRepository {
  @override
  void dispose() {}

  @override
  Future<CustomersResponse> getScheduledCustomers() async {
    final client = getIt<AuthRestClient>();
    final response = await client.getCustomers("scheduled");
    return response;
  }

  @override
  Future<Customer> getCustomer(int id) async {
    final client = getIt<AuthRestClient>();
    final response = await client.getCustomer(id);
    return response;
  }

  @override
  Future<PaginatedImages> getOrderImages(String orderID) async {
    final client = getIt<AuthRestClient>();
    final response = await client.getOrderImages(orderID);
    return response;
  }

  @override
  Future<void> deleteImage(int imageID) async {
    final client = getIt<AuthRestClient>();
    await client.deleteImage(imageID);
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
  Future<OrderWithBags> removeBag(int orderID, String bagID) async {
    final client = getIt<AuthRestClient>();
    final response = await client.removeBag(orderID, bagID);
    return response;
  }

  @override
  Future<OrderImage> uploadImage(int orderID, XFile file) async {
    final client = getIt<AuthRestClient>();

    FormData form = FormData.fromMap({
      "image": await MultipartFile.fromFile(file.path),
      "order": orderID,
    });

    final response = await client.uploadImage(form);

    return response;
  }

  @override
  Future<OrderWithBags> updateOrder(int orderID, PatchOrder order) async {
    final client = getIt<AuthRestClient>();
    final response = await client.patchOrder(orderID, order);
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

    double weight = double.parse(bagWeight);
    int count = int.parse(itemsCount);

    final response = await client.printTicket(id, bagID, weight, count);
    return response;
  }
}
