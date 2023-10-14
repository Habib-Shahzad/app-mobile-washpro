part of 'cubit.dart';

class PrintScreenState extends Equatable {
  final bool? initialLoading;
  final bool? printLoading;
  final OrderWithBags? order;
  final String? errorMessage;

  const PrintScreenState({
    this.initialLoading,
    this.printLoading,
    this.order,
    this.errorMessage,
  });

  PrintScreenState copyWith({
    bool? initialLoading,
    bool? printLoading,
    OrderWithBags? order,
    Customer? customer,
    String? errorMessage,
  }) {
    return PrintScreenState(
      initialLoading: initialLoading ?? this.initialLoading,
      printLoading: printLoading ?? this.printLoading,
      order: order ?? this.order,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [initialLoading, printLoading, order, errorMessage];
}
