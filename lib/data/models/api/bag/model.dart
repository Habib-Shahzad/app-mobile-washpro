// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

class BagStatus {
  static const String vacant = "vacant";
  static const String pickedUp = "picked_up";
  static const String dropOff = "drop_off";
  static const String processing = "processing";
  static const String ready = "ready";
  static const String dispatched = "dispatched";
  static const String delivered = "delivered";
}

String defaultLabeler(String x, {String splitter = '_'}) {
  // Split the input string by the splitter
  List<String> words = x.split(splitter);

  // Capitalize the first letter of each word and join them with a space
  String result = words.map((word) {
    if (word.isEmpty) {
      return '';
    }
    return word[0].toUpperCase() + word.substring(1);
  }).join(' ');

  return result;
}

@JsonSerializable()
class Bag {
  final int id;
  final String status;
  final String created_at;
  final String updated_at;
  final String? deleted_at;
  final String bag_id;
  final String bag_type;
  final int customer;

  Bag({
    required this.id,
    required this.status,
    required this.created_at,
    required this.updated_at,
    this.deleted_at,
    required this.bag_id,
    required this.bag_type,
    required this.customer,
  });

  factory Bag.fromJson(Map<String, dynamic> json) => _$BagFromJson(json);

  Map<String, dynamic> toJson() => _$BagToJson(this);
}
