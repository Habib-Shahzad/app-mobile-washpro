part of 'cubit.dart';

abstract class CustomerScreenState {
  const CustomerScreenState();
}

class Initial extends CustomerScreenState {}

class Loading extends CustomerScreenState {}

class Loaded extends CustomerScreenState {
  final CustomersResponse customersResponse;
  const Loaded({required this.customersResponse});
}

class Error extends CustomerScreenState {
  final String errorMessage;
  const Error({required this.errorMessage});
}
