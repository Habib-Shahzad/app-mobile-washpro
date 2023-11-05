import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:washpro/data/models/api/order_image/model.dart';
import 'package:washpro/data/models/api/order_with_bags/model.dart';
import 'package:washpro/data/repositories/customer/base.dart';
import 'package:washpro/logger.dart';

part 'state.dart';

String generateUniqueID() {
  return DateTime.now().millisecondsSinceEpoch.toString();
}

class ManageOrderCubit extends Cubit<ManageOrderState> {
  final CustomerRepository _customerRepository;
  ManageOrderCubit({required CustomerRepository customerRepository})
      : _customerRepository = customerRepository,
        super(
          const ManageOrderState(
            initialLoading: true,
            orderImages: {},
          ),
        );

  void resetAddingBag() {
    emit(state.copyWith(
      addingBag: LoadingStatus.none,
    ));
  }

  void resetRemovingBag() {
    emit(state.copyWith(
      removingBag: LoadingStatus.none,
    ));
  }

  void resetPickingUpOrder() {
    emit(state.copyWith(
      pickingUpOrder: LoadingStatus.none,
    ));
  }

  void resetSavingNotes() {
    emit(state.copyWith(
      savingNotes: LoadingStatus.none,
    ));
  }

  void resetAddingImage() {
    emit(state.copyWith(
      addingImage: LoadingStatus.none,
    ));
  }

  void resetDeletingImage() {
    emit(state.copyWith(
      deletingImage: LoadingStatus.none,
    ));
  }

  Future<void> deleteImage(String imageID) async {
    try {
      logger.i('Deleting Image $imageID');
      state.orderImages.remove(imageID);
      emit(state.copyWith(
          orderImages: state.orderImages,
          deletingImage: LoadingStatus.loading));

      await _customerRepository.deleteImage(int.parse(imageID));

      emit(state.copyWith(deletingImage: LoadingStatus.success));
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(deletingImage: LoadingStatus.failed));
    }
  }

  Future<void> addImage() async {
    try {
      const source = ImageSource.gallery;
      final picked =
          await ImagePicker().pickImage(source: source, imageQuality: 70);

      if (picked == null) {
        return;
      }

      UploadedImage uploaded = UploadedImage(
        file: XFile(picked.path),
        url: null,
      );

      logger.i('Got Image from $source');
      String imageID = generateUniqueID().toString();
      state.orderImages[imageID] = uploaded;
      emit(state.copyWith(
        addingImage: LoadingStatus.loading,
        orderImages: state.orderImages,
      ));

      OrderImage recieved =
          await _customerRepository.uploadImage(state.order!.id, picked);

      if (state.orderImages[imageID] != null) {
        state.orderImages[recieved.id.toString()] = UploadedImage(
          file: null,
          url: recieved.image,
        );
        state.orderImages.remove(imageID);
      }

      emit(state.copyWith(
        addingImage: LoadingStatus.success,
        orderImages: state.orderImages,
      ));
      logger.i('Uploaded Image ${uploaded.url}');
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(addingImage: LoadingStatus.failed));
    }
  }

  Future<void> removeBag(int orderID, String bagID) async {
    try {
      logger.i('Deleting Bag from order $orderID $bagID');

      emit(state.copyWith(removingBag: LoadingStatus.loading));

      OrderWithBags order = await _customerRepository.removeBag(orderID, bagID);

      emit(state.copyWith(order: order, removingBag: LoadingStatus.success));
    } catch (e) {
      logger.e(e);
      logger.e("failed To delete bag");
      emit(state.copyWith(removingBag: LoadingStatus.failed));
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

  Future<void> loadImages(int id) async {
    try {
      logger.i('Fetching Order Images');
      emit(state.copyWith(loadingImages: LoadingStatus.loading));

      PaginatedImages images = await _customerRepository.getOrderImages(id);

      logger.i('Fetched Order Images');

      Map<String, UploadedImage> orderImages = {};

      if (images.results != null) {
        images.results?.forEach((element) {
          orderImages[element.id.toString()] = UploadedImage(
            file: null,
            url: element.image,
          );
        });
      }

      emit(state.copyWith(
        loadingImages: LoadingStatus.success,
        orderImages: orderImages,
      ));
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(
          loadingImages: LoadingStatus.failed, errorMessage: e.toString()));
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

      await loadImages(id);
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(initialLoading: false, errorMessage: e.toString()));
    }
  }
}
