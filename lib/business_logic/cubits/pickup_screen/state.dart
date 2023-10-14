part of 'cubit.dart';

enum AddedBagStatus {
  loading,
  success,
  failed,
}

class PickupScreenState extends Equatable {
  final bool? initialLoading;
  final List<OrderWithBags>? orders;
  final AddedBagStatus? addingBag;
  final String? errorMessage;

  const PickupScreenState({
    this.initialLoading,
    this.addingBag,
    this.orders,
    this.errorMessage,
  });

  PickupScreenState copyWith({
    bool? initialLoading,
    AddedBagStatus? addingBag,
    List<OrderWithBags>? orders,
    String? errorMessage,
  }) {
    return PickupScreenState(
      initialLoading: initialLoading ?? this.initialLoading,
      orders: orders ?? this.orders,
      addingBag: addingBag ?? this.addingBag,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) => false;

  @override
  List<Object?> get props => [initialLoading, addingBag, orders, errorMessage];
}
