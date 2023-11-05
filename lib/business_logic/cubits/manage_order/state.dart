part of 'cubit.dart';

enum LoadingStatus {
  loading,
  success,
  failed,
}

class ManageOrderState extends Equatable {
  final bool? initialLoading;
  final List<XFile>? orderImages;
  final OrderWithBags? order;
  final LoadingStatus? addingBag;
  final LoadingStatus? pickingUpOrder;
  final LoadingStatus? savingNotes;
  final String? errorMessage;

  const ManageOrderState({
    this.initialLoading,
    this.addingBag,
    this.pickingUpOrder,
    this.order,
    this.errorMessage,
    this.savingNotes,
    this.orderImages,
  });

  ManageOrderState copyWith({
    bool? initialLoading,
    LoadingStatus? addingBag,
    LoadingStatus? pickingUpOrder,
    OrderWithBags? order,
    String? errorMessage,
    LoadingStatus? savingNotes,
    List<XFile>? orderImages,
  }) {
    return ManageOrderState(
      initialLoading: initialLoading ?? this.initialLoading,
      order: order ?? this.order,
      addingBag: addingBag ?? this.addingBag,
      pickingUpOrder: pickingUpOrder ?? this.pickingUpOrder,
      errorMessage: errorMessage ?? this.errorMessage,
      savingNotes: savingNotes ?? this.savingNotes,
      orderImages: orderImages ?? this.orderImages,
    );
  }

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) => false;

  @override
  List<Object?> get props => [
        initialLoading,
        addingBag,
        pickingUpOrder,
        order,
        errorMessage,
        savingNotes,
        orderImages,
      ];
}
