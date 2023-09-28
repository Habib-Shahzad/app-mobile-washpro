part of 'cubit.dart';

abstract class PickupScreenState {
  const PickupScreenState();
}

class Initial extends PickupScreenState {}

class Loading extends PickupScreenState {}

class Loaded extends PickupScreenState {
  final List<Order> orderList;
  const Loaded({required this.orderList});
}

class Error extends PickupScreenState {
  final String errorMessage;
  const Error({required this.errorMessage});
}
