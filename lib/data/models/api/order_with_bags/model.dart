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

// ---------------------------------------------------

class PatchOrder {
  String? order_id;
  String? scheduled_pickup;
  String? due_date;
  int? expected_bag_count;
  String? status;
  int? valet;

  PatchOrder({
    this.order_id,
    this.scheduled_pickup,
    this.due_date,
    this.expected_bag_count,
    this.status,
    this.valet,
  });

  factory PatchOrder.fromJson(Map<String, dynamic> json) {
    return PatchOrder(
      order_id: json['order_id'],
      scheduled_pickup: json['scheduled_pickup'],
      due_date: json['due_date'],
      expected_bag_count: json['expected_bag_count'],
      status: json['status'],
      valet: json['valet'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (order_id != null) data['order_id'] = order_id;
    if (scheduled_pickup != null) data['scheduled_pickup'] = scheduled_pickup;
    if (due_date != null) data['due_date'] = due_date;
    if (expected_bag_count != null) {
      data['expected_bag_count'] = expected_bag_count;
    }
    if (status != null) data['status'] = status;
    if (valet != null) data['valet'] = valet;
    return data;
  }
}
