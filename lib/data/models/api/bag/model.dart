// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

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
