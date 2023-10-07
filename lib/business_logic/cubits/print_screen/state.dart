part of 'cubit.dart';

class PrintScreenState extends Equatable {
  final bool? initialLoading;
  final bool? printLoading;
  final Order? order;
  final Customer? customer;
  final String? errorMessage;

  const PrintScreenState({
    this.initialLoading,
    this.printLoading,
    this.order,
    this.customer,
    this.errorMessage,
  });

  PrintScreenState copyWith({
    bool? initialLoading,
    bool? printLoading,
    Order? order,
    Customer? customer,
    String? errorMessage,
  }) {
    return PrintScreenState(
      initialLoading: initialLoading ?? this.initialLoading,
      printLoading: printLoading ?? this.printLoading,
      order: order ?? this.order,
      customer: customer ?? this.customer,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [initialLoading, printLoading, order, customer, errorMessage];
}
