// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['id'] as int,
      bags: (json['bags'] as List<dynamic>).map((e) => e as int).toList(),
      customer: json['customer'] as int,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
      deleted_at: json['deleted_at'] as String?,
      order_id: json['order_id'] as String,
      scheduled_pickup: json['scheduled_pickup'] as String,
      due_date: json['due_date'] as String,
      expected_bag_count: json['expected_bag_count'] as int,
      status: json['status'] as String,
      valet: json['valet'] as int,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'bags': instance.bags,
      'customer': instance.customer,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'deleted_at': instance.deleted_at,
      'order_id': instance.order_id,
      'scheduled_pickup': instance.scheduled_pickup,
      'due_date': instance.due_date,
      'expected_bag_count': instance.expected_bag_count,
      'status': instance.status,
      'valet': instance.valet,
    };
