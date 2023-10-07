import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:washpro/data/models/api/bag/model.dart';
import 'package:washpro/data/models/scan_result.dart';
import 'package:washpro/data/repositories/bag/base.dart';

part 'event.dart';
part 'state.dart';

class BagBloc extends Bloc<BagEvent, BagState> {
  final BagRepository _bagRepository;

  BagBloc({required BagRepository repository})
      : _bagRepository = repository,
        super(const BagState()) {
    on<LoadBags>(loadBags);
    on<BagScanned>(updateBag);
  }

  void loadBags(
    LoadBags event,
    Emitter<BagState> emit,
  ) async {
    try {
      emit(state.copyWith(screenState: ScreenState.loading));
      final bags = await _bagRepository.getBagsByStatus(event.status);
      emit(state.copyWith(bags: bags, screenState: ScreenState.loaded));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
        screenState: ScreenState.error,
      ));
    }
  }

  void updateBag(
    BagScanned event,
    Emitter<BagState> emit,
  ) async {
    String status = event.updatedStatus;

    try {
      ScanResult scan = ScanResult.fromString(event.scanResult);
      await _bagRepository.updateBagStatus(scan, status);
      final updatedBags =
          state.bags!.where((b) => b.bag_id != scan.bagID).toList();
      emit(state.copyWith(bags: updatedBags, scanStatus: ScanStatus.matched));
    } catch (e) {
      emit(state.copyWith(scanStatus: ScanStatus.invalid));
    }
  }
}
