part of 'cubit.dart';

abstract class CustomerScreenState {
  const CustomerScreenState();
}

class Initial extends CustomerScreenState {}

class Loading extends CustomerScreenState {}

class Loaded extends CustomerScreenState {
  final OrdersResponse ordersResponse;
  const Loaded({required this.ordersResponse});
}

class Error extends CustomerScreenState {
  final String errorMessage;
  const Error({required this.errorMessage});
}
