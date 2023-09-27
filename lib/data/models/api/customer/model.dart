// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
import 'package:washpro/data/models/api/bag/model.dart';
part 'model.g.dart';

@JsonSerializable()
class Customer {
  final int id;
  final String created_at;
  final String updated_at;
  final String? deleted_at;
  final String name;
  final String address;
  final String phone_number;
  final String email;
  final String customer_id;
  final String preferences;

  List<Bag>? bags;

  Customer({
    required this.id,
    required this.created_at,
    required this.updated_at,
    this.deleted_at,
    required this.name,
    required this.address,
    required this.phone_number,
    required this.email,
    required this.customer_id,
    required this.preferences,
    this.bags,
  });

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}
