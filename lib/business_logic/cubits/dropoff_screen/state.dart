part of 'cubit.dart';

abstract class DropOffScreenState {
  const DropOffScreenState();
}

class Initial extends DropOffScreenState {}

class Loading extends DropOffScreenState {}

class Loaded extends DropOffScreenState {
  final List<Bag> bagList;
  const Loaded({required this.bagList});
}

class Error extends DropOffScreenState {
  final String errorMessage;
  const Error({required this.errorMessage});
}
