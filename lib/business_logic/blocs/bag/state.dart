part of 'bloc.dart';

enum ScanStatus { matched, invalid }
enum ScreenState { initial, loading, loaded, error }

class BagState extends Equatable {
  final ScanStatus? scanStatus;
  final List<Bag>? bags;
  final String? errorMessage;
  final ScreenState? screenState;

  const BagState({
    this.bags = const [],
    this.scanStatus,
    this.errorMessage,
    this.screenState = ScreenState.initial,
  });

  BagState copyWith(
      {List<Bag>? bags,
      ScanStatus? scanStatus,
      String? errorMessage,
      ScreenState? screenState}) {
    return BagState(
      bags: bags ?? this.bags,
      scanStatus: scanStatus ?? this.scanStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      screenState: screenState ?? this.screenState,
    );
  }

  @override
  List<Object?> get props => [bags, scanStatus, errorMessage, screenState];
}



