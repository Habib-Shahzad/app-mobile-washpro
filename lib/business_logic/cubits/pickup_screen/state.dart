part of 'cubit.dart';

enum LoadingStatus {
  loading,
  success,
  failed,
}

class PickupScreenState extends Equatable {
  final bool? initialLoading;
  final OrderWithBags? order;
  final LoadingStatus? addingBag;
  final LoadingStatus? pickingUpOrder;
  final String? errorMessage;

  const PickupScreenState({
    this.initialLoading,
    this.addingBag,
    this.pickingUpOrder,
    this.order,
    this.errorMessage,
  });

  PickupScreenState copyWith({
    bool? initialLoading,
    LoadingStatus? addingBag,
    LoadingStatus? pickingUpOrder,
    OrderWithBags? order,
    String? errorMessage,
  }) {
    return PickupScreenState(
      initialLoading: initialLoading ?? this.initialLoading,
      order: order ?? this.order,
      addingBag: addingBag ?? this.addingBag,
      pickingUpOrder: pickingUpOrder ?? this.pickingUpOrder,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) => false;

  @override
  List<Object?> get props =>
      [initialLoading, addingBag, pickingUpOrder, order, errorMessage];
}
