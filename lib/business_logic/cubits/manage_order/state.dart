part of 'cubit.dart';

enum LoadingStatus {
  none,
  loading,
  success,
  failed,
}

class ManageOrderState extends Equatable {
  final bool? initialLoading;
  final Map<String, UploadedImage> orderImages;
  final OrderWithBags? order;
  final LoadingStatus? addingBag;
  final LoadingStatus? addingImage;
  final LoadingStatus? pickingUpOrder;
  final LoadingStatus? removingBag;
  final LoadingStatus? savingNotes;
  final LoadingStatus? loadingImages;
  final LoadingStatus? deletingImage;
  final String? errorMessage;

  const ManageOrderState({
    this.initialLoading,
    this.addingBag = LoadingStatus.none,
    this.addingImage = LoadingStatus.none,
    this.pickingUpOrder = LoadingStatus.none,
    this.removingBag = LoadingStatus.none,
    this.loadingImages = LoadingStatus.none,
    this.deletingImage = LoadingStatus.none,
    this.savingNotes = LoadingStatus.none,
    this.order,
    this.errorMessage,
    required this.orderImages,
  });

  ManageOrderState copyWith({
    bool? initialLoading,
    LoadingStatus? addingBag,
    LoadingStatus? addingImage,
    LoadingStatus? removingBag,
    LoadingStatus? pickingUpOrder,
    LoadingStatus? loadingImages,
    LoadingStatus? deletingImage,
    OrderWithBags? order,
    String? errorMessage,
    LoadingStatus? savingNotes,
    Map<String, UploadedImage>? orderImages,
  }) {
    return ManageOrderState(
      initialLoading: initialLoading ?? this.initialLoading,
      order: order ?? this.order,
      addingBag: addingBag ?? this.addingBag,
      pickingUpOrder: pickingUpOrder ?? this.pickingUpOrder,
      removingBag: removingBag ?? this.removingBag,
      errorMessage: errorMessage ?? this.errorMessage,
      savingNotes: savingNotes ?? this.savingNotes,
      orderImages: orderImages ?? Map.from(this.orderImages),
      addingImage: addingImage ?? this.addingImage,
      loadingImages: loadingImages ?? this.loadingImages,
      deletingImage: deletingImage ?? this.deletingImage,
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
        removingBag,
        addingBag,
        addingImage,
        loadingImages,
        deletingImage,
      ];
}
