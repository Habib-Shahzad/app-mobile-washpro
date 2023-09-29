import 'package:equatable/equatable.dart';
import 'package:washpro/data/models/api/bag/model.dart';

class ScanResult extends Equatable {
  final String bagID;
  final String orderID;
  final String bagType;

  const ScanResult({
    required this.bagID,
    required this.orderID,
    required this.bagType,
  });

  factory ScanResult.fromString(String string) {
    List<String> splitString = string.split(',');

    if (splitString.length != 3) {
      throw Exception('Invalid Scan Result');
    }
    return ScanResult(
      bagID: splitString[0].trim(),
      orderID: splitString[1].trim(),
      bagType: splitString[2].trim(),
    );
  }

  factory ScanResult.fromBag(Bag bag) {
    return ScanResult(
      bagID: bag.bag_id,
      orderID: bag.id.toString(),
      bagType: bag.bag_type,
    );
  }

  @override
  List<Object?> get props => [bagID, orderID, bagType];
}
