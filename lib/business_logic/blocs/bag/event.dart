part of 'bloc.dart';

abstract class BagEvent {
  const BagEvent();
}

class LoadBags extends BagEvent {
  final String status;
  const LoadBags({required this.status});
}

class BagScanned extends BagEvent {
  final String scanResult;
  final Bag bag;
  final String updatedStatus;
  const BagScanned(
      {required this.scanResult,
      required this.bag,
      required this.updatedStatus});
}
