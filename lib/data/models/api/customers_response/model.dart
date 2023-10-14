import 'package:json_annotation/json_annotation.dart';
import 'package:washpro/data/models/api/customer/model.dart';

part 'model.g.dart';

@JsonSerializable()
class CustomersResponse {
  int count;
  String? next;
  String? previous;
  List<Customer> results;

  CustomersResponse({
    required this.count,
    required this.results,
    this.next,
    this.previous,
  });

  factory CustomersResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomersResponseToJson(this);
}
