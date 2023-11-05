import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:washpro/data/models/api/bag/model.dart';
import 'package:washpro/data/models/api/order_with_bags/model.dart';
import 'package:washpro/data/repositories/customer/base.dart';
import 'package:washpro/logger.dart';

part 'state.dart';

class ManageOrderCubit extends Cubit<ManageOrderState> {
  final CustomerRepository _customerRepository;
  ManageOrderCubit({required CustomerRepository customerRepository})
      : _customerRepository = customerRepository,
        super(
          const ManageOrderState(
            initialLoading: true,
            orderImages: [],
          ),
        );

  Future<void> addImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile == null) {
        return;
      }

      logger.i('Adding Image to screen');

      emit(state.copyWith(orderImages: [
        ...state.orderImages!,
        pickedFile,
      ]));
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> deleteBag(int orderID, String bagID) async {
    try {
      logger.i('Deleting Bag from order $orderID $bagID');

      emit(state.copyWith(addingBag: LoadingStatus.loading));

      if (state.order != null) {
        List<Bag> updatedOrderBags = state.order!.bags
            .where((element) => element.bag_id != bagID)
            .toList();
        state.order!.bags = updatedOrderBags;
      }

      emit(
          state.copyWith(order: state.order, addingBag: LoadingStatus.success));
    } catch (e) {
      logger.e(e);
      logger.e("failed To delete bag");
      emit(state.copyWith(addingBag: LoadingStatus.failed));
    }
  }

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

  Future<void> saveNotes(int orderID, String? note) async {
    try {
      logger.i('Changing Order Note $orderID $note');

      emit(state.copyWith(savingNotes: LoadingStatus.loading));

      OrderWithBags order = await _customerRepository.updateOrder(
          orderID, PatchOrder(note: note));

      emit(state.copyWith(savingNotes: LoadingStatus.success, order: order));
    } catch (e) {
      logger.e(e);
      logger.e("failed To change order notes");
      emit(state.copyWith(savingNotes: LoadingStatus.failed));
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
