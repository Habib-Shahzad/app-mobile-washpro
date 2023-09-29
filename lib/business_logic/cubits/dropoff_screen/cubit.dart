import 'package:bloc/bloc.dart';
import 'package:washpro/data/models/api/bag/model.dart';
import 'package:washpro/data/models/scan_result.dart';
import 'package:washpro/data/repositories/bag/base.dart';
import 'package:washpro/logger.dart';

part 'state.dart';

class DropOffScreenCubit extends Cubit<DropOffScreenState> {
  final BagRepository _bagRepository;
  DropOffScreenCubit({required BagRepository bagRepository})
      : _bagRepository = bagRepository,
        super(Initial());

  Future<void> getPickedUpBags() async {
    emit(Loading());
    try {
      List<Bag> response =
          await _bagRepository.getBagsByStatus(BagStatus.pickedUp);

      emit(Loaded(bagList: response));
      logger.i('Fetched Picked Up Bags');
    } catch (e) {
      logger.e(e);
      emit(Error(errorMessage: e.toString()));
    }
  }

  Future<void> dropOffBag(Bag bag, String scanResult) async {
    try {
      ScanResult expected = ScanResult(
        bagID: bag.bag_id,
        orderID: bag.id.toString(),
        bagType: bag.bag_type,
      );

      ScanResult result = ScanResult.fromString(scanResult);

      if (expected != result) {
        throw Exception("Incorrect");
      }

      await _bagRepository.updateBagStatus(bag, BagStatus.dropOff);

      await getPickedUpBags();
    } catch (e) {
      logger.e(e);
      // emit(const Error(errorMessage: "Incorrect"));
    }
  }
}
