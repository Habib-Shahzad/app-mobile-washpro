import 'package:bloc/bloc.dart';
import 'package:washpro/data/models/api/getOrders/model.dart';
import 'package:washpro/data/repositories/customer/base.dart';
import 'package:washpro/logger.dart';

part 'state.dart';

class CustomerScreenCubit extends Cubit<CustomerScreenState> {
  final CustomerRepository _customerRepository;
  CustomerScreenCubit({required CustomerRepository customerRepository})
      : _customerRepository = customerRepository,
        super(Initial());

  Future<void> getOrders() async {
    emit(Loading());
    try {
      OrdersResponse response = await _customerRepository.getOrders();
      emit(Loaded(ordersResponse: response));
      logger.i('Fetched Customers');
    } catch (e) {
      logger.e(e);
      emit(Error(errorMessage: e.toString()));
    }
  }
}
