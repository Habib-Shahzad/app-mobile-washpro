import 'package:bloc/bloc.dart';
import 'package:washpro/data/models/api/getCustomers/model.dart';
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
      CustomersResponse response = await _customerRepository.getCustomers();
      emit(Loaded(customersResponse: response));
      logger.i('Fetched Customers');
    } catch (e) {
      logger.e(e);
      emit(Error(errorMessage: e.toString()));
    }
  }
}
