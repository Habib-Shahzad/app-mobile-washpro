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

  void matchScan(Bag bag, String scanResult) {
    ScanResult expected = ScanResult.fromBag(bag);
    ScanResult scanned = ScanResult.fromString(scanResult);

    if (expected != scanned) {
      throw Exception('Scan result does not match bag');
    }
  }

  void updateBag(
    BagScanned event,
    Emitter<BagState> emit,
  ) async {
    Bag bag = event.bag;
    String status = event.updatedStatus;

    try {
      matchScan(bag, event.scanResult);
      final updatedBags = state.bags!.where((b) => b.id != bag.id).toList();

      emit(state.copyWith(bags: updatedBags, scanStatus: ScanStatus.matched));

      await _bagRepository.updateBagStatus(bag, status);
    } catch (e) {
      emit(state.copyWith(scanStatus: ScanStatus.invalid));
    }
  }
}
