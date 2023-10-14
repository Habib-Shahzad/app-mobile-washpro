// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
import 'package:washpro/data/models/api/bag/model.dart';

part 'model.g.dart';

@JsonSerializable()
class OrderWithBags {
  int id;
  List<Bag> bags;
  OrderCustomer customer;
  String created_at;
  String updated_at;
  String? deleted_at;
  String? order_id;
  String? scheduled_pickup;
  String? due_date;
  int? expected_bag_count;
  String? status;
  int? valet;

  OrderWithBags({
    required this.id,
    required this.bags,
    required this.customer,
    required this.created_at,
    required this.updated_at,
    this.deleted_at,
    this.order_id,
    this.scheduled_pickup,
    this.due_date,
    this.expected_bag_count,
    this.status,
    this.valet,
  });

  factory OrderWithBags.fromJson(Map<String, dynamic> json) =>
      _$OrderWithBagsFromJson(json);

  Map<String, dynamic> toJson() => _$OrderWithBagsToJson(this);
}

@JsonSerializable()
class OrderCustomer {
  int id;
  String created_at;
  String updated_at;
  String? deleted_at;
  String name;
  String address;
  String phone_number;
  String email;
  String customer_id;
  String? preferences;

  OrderCustomer({
    required this.id,
    required this.created_at,
    required this.updated_at,
    this.deleted_at,
    required this.name,
    required this.address,
    required this.phone_number,
    required this.email,
    required this.customer_id,
    this.preferences,
  });

  factory OrderCustomer.fromJson(Map<String, dynamic> json) =>
      _$OrderCustomerFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCustomerToJson(this);
}
