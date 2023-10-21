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

  Future<void> updateOrderStatus(int orderID, String status) async {
    try {
      logger.i('Changing Order Status $orderID $status');

      emit(state.copyWith(pickingUpOrder: LoadingStatus.loading));

      OrderWithBags order = await _customerRepository.updateOrder(
          orderID, PatchOrder(status: status));

      emit(state.copyWith(pickingUpOrder: LoadingStatus.success, order: order));
    } catch (e) {
      logger.e(e);
      logger.e("failed To change order status");
      emit(state.copyWith(pickingUpOrder: LoadingStatus.failed));
    }
  }

  Future<void> addBag(int orderID, String? bagID) async {
    try {
      if (bagID == null) {
        logger.e("Bag ID is null");
        throw Exception("Bag ID is null");
      }

      logger.i('Adding Bag to order $orderID $bagID');

      emit(state.copyWith(addingBag: LoadingStatus.loading));

      OrderWithBags order = await _customerRepository.addBag(orderID, bagID);

      emit(state.copyWith(order: order, addingBag: LoadingStatus.success));
    } catch (e) {
      logger.e(e);
      logger.e("failed To add bag");
      emit(state.copyWith(addingBag: LoadingStatus.failed));
    }
  }

  Future<void> getOrder(int id) async {
    emit(state.copyWith(initialLoading: true));

    try {
      logger.i('Fetching Order');
      OrderWithBags response = await _customerRepository.getOrder(id);
      emit(state.copyWith(
        initialLoading: false,
        order: response,
      ));

      logger.i('Fetched Order');
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(initialLoading: false, errorMessage: e.toString()));
    }
  }
}
