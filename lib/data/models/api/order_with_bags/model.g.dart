// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderWithBags _$OrderWithBagsFromJson(Map<String, dynamic> json) =>
    OrderWithBags(
      id: json['id'] as int,
      bags: (json['bags'] as List<dynamic>)
          .map((e) => Bag.fromJson(e as Map<String, dynamic>))
          .toList(),
      customer:
          OrderCustomer.fromJson(json['customer'] as Map<String, dynamic>),
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
      deleted_at: json['deleted_at'] as String?,
      order_id: json['order_id'] as String?,
      scheduled_pickup: json['scheduled_pickup'] as String?,
      due_date: json['due_date'] as String?,
      expected_bag_count: json['expected_bag_count'] as int?,
      status: json['status'] as String?,
      valet: json['valet'] as int?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$OrderWithBagsToJson(OrderWithBags instance) =>
    <String, dynamic>{
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
      'note': instance.note,
    };

OrderCustomer _$OrderCustomerFromJson(Map<String, dynamic> json) =>
    OrderCustomer(
      id: json['id'] as int,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
      deleted_at: json['deleted_at'] as String?,
      name: json['name'] as String,
      address: json['address'] as String,
      phone_number: json['phone_number'] as String,
      email: json['email'] as String,
      customer_id: json['customer_id'] as String,
      preferences: json['preferences'] as String?,
    );

Map<String, dynamic> _$OrderCustomerToJson(OrderCustomer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'deleted_at': instance.deleted_at,
      'name': instance.name,
      'address': instance.address,
      'phone_number': instance.phone_number,
      'email': instance.email,
      'customer_id': instance.customer_id,
      'preferences': instance.preferences,
    };
