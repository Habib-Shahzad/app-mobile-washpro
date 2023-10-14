// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
import 'package:washpro/data/models/api/order/model.dart';

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
