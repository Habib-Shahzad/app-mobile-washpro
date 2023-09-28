import 'package:bloc/bloc.dart';
import 'package:washpro/data/models/api/bag/model.dart';
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
}
