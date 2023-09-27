import 'package:washpro/data/models/api/getCustomers/model.dart';

abstract class CustomerRepository {
  Future<CustomersResponse> getCustomers();
  void dispose();
}
