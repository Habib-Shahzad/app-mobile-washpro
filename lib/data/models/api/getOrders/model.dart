// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
import 'package:washpro/data/models/api/bag/model.dart';
import 'package:washpro/data/models/api/customer/model.dart';

part 'model.g.dart';

@JsonSerializable()
class OrdersResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<Order> results;

  OrdersResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory OrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$OrdersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersResponseToJson(this);
}

@JsonSerializable()
class Order {
  final int id;
  final List<Bag> bags;
  final Customer customer;
  final String created_at;
  final String updated_at;
  final String? deleted_at;
  final String order_id;
  final String scheduled_pickup;
  final String due_date;
  final int expected_bag_count;
  final String status;
  final int valet;

  Order({
    required this.id,
    required this.bags,
    required this.customer,
    required this.created_at,
    required this.updated_at,
    this.deleted_at,
    required this.order_id,
    required this.scheduled_pickup,
    required this.due_date,
    required this.expected_bag_count,
    required this.status,
    required this.valet,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
