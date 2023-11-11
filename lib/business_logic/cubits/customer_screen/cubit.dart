import 'package:bloc/bloc.dart';
import 'package:washpro/data/models/api/customers_response/model.dart';
import 'package:washpro/data/repositories/customer/base.dart';
import 'package:washpro/logger.dart';

part 'state.dart';

class CustomerScreenCubit extends Cubit<CustomerScreenState> {
  final CustomerRepository _customerRepository;
  CustomerScreenCubit({required CustomerRepository customerRepository})
      : _customerRepository = customerRepository,
        super(Initial());

  Future<void> getCustomers() async {
    emit(Loading());
    try {
      logger.i('Fetching all Customers getCustomers(); ');
      CustomersResponse response =
          await _customerRepository.getCustomersByStatus("scheduled");
      emit(Loaded(customersResponse: response));
      logger.i('Fetched Customers');
    } catch (e) {
      logger.e(e);
      emit(Error(errorMessage: e.toString()));
    }
  }

  Future<void> getDispatchedCustomers() async {
    emit(Loading());
    try {
      logger.i('Fetching all Customers getCustomers(); ');
      CustomersResponse response =
          await _customerRepository.getCustomersByStatus("dispatched");
      emit(Loaded(customersResponse: response));
      logger.i('Fetched Customers');
    } catch (e) {
      logger.e(e);
      emit(Error(errorMessage: e.toString()));
    }
  }
}
