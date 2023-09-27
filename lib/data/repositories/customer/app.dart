import 'package:dio/dio.dart';
import 'package:washpro/data/models/api/getCustomers/model.dart';
import 'package:washpro/data/repositories/customer/base.dart';
import 'package:washpro/services/retrofit/client.dart';
import 'package:washpro/services/retrofit/interceptor.dart';

class AppCustomerRepository extends CustomerRepository {
  @override
  void dispose() {}

  @override
  Future<CustomersResponse> getCustomers() async {
    final dio = Dio();
    addAuthInterceptor(dio);
    final client = RestClient(dio);
    final response = await client.getCustomers();
    return response;
  }
}
