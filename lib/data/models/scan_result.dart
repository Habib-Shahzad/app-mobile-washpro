import 'package:equatable/equatable.dart';

class ScanResult extends Equatable {
  final String bagID;
  final int orderID;

  const ScanResult({
    required this.bagID,
    required this.orderID,
  });

  factory ScanResult.fromString(String string) {
    List<String> splitString = string.split(',');

    if (splitString.length != 2) {
      throw Exception('Invalid Scan Result');
    }
    return ScanResult(
      bagID: splitString[0].trim(),
      orderID: int.parse(splitString[1].trim()),
    );
  }

  @override
  List<Object?> get props => [bagID, orderID];
}
