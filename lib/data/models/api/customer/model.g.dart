// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      id: json['id'] as int,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
      deleted_at: json['deleted_at'] as String?,
      name: json['name'] as String,
      address: json['address'] as String,
      phone_number: json['phone_number'] as String,
      email: json['email'] as String,
      customer_id: json['customer_id'] as String,
      preferences: json['preferences'] as String,
      scheduled_orders: (json['scheduled_orders'] as List<dynamic>)
          .map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
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
      'scheduled_orders': instance.scheduled_orders,
    };
