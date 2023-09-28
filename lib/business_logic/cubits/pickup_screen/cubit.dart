import 'package:bloc/bloc.dart';
import 'package:washpro/data/models/api/getOrders/model.dart';
import 'package:washpro/data/repositories/customer/base.dart';
import 'package:washpro/logger.dart';

part 'state.dart';

class PickupScreenCubit extends Cubit<PickupScreenState> {
  final CustomerRepository _customerRepository;
  PickupScreenCubit({required CustomerRepository customerRepository})
      : _customerRepository = customerRepository,
        super(Initial());

  Future<void> getCustomerOrders(String id) async {
    emit(Loading());
    try {
      List<Order> response = await _customerRepository.getCustomerOrders(id);
      emit(Loaded(orderList: response));

      logger.i('Fetched Customer Orders');
    } catch (e) {
      logger.e(e);
      emit(Error(errorMessage: e.toString()));
    }
  }
}
