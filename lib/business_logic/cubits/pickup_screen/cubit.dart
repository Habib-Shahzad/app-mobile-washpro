import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:washpro/data/models/api/order_with_bags/model.dart';
import 'package:washpro/data/repositories/customer/base.dart';
import 'package:washpro/logger.dart';

part 'state.dart';

class PickupScreenCubit extends Cubit<PickupScreenState> {
  final CustomerRepository _customerRepository;
  PickupScreenCubit({required CustomerRepository customerRepository})
      : _customerRepository = customerRepository,
        super(
          const PickupScreenState(
            initialLoading: true,
          ),
        );

  Future<void> addBag(int orderID, String? bagID) async {
    try {
      if (bagID == null) {
        logger.e("Bag ID is null");
        throw Exception("Bag ID is null");
      }

      logger.i('Adding Bag to order $orderID $bagID');

      emit(state.copyWith(addingBag: AddedBagStatus.loading));

      OrderWithBags order = await _customerRepository.addBag(orderID, bagID);
      List<OrderWithBags> updatedOrders = state.orders!.map((e) {
        if (e.id == order.id) {
          return order;
        }
        return e;
      }).toList();

      emit(state.copyWith(
          orders: updatedOrders, addingBag: AddedBagStatus.success));
    } catch (e) {
      logger.e(e);
      logger.e("failed To add bag");
      emit(state.copyWith(addingBag: AddedBagStatus.failed));
    }
  }

  Future<void> getCustomerOrders(String id) async {
    emit(state.copyWith(initialLoading: true));

    try {
      logger.i('Fetching Customer Orders');
      List<OrderWithBags> response =
          await _customerRepository.getCustomerOrders(id);
      emit(state.copyWith(
        initialLoading: false,
        orders: response,
      ));

      logger.i('Fetched Customer Orders');
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(initialLoading: false, errorMessage: e.toString()));
    }
  }
}
