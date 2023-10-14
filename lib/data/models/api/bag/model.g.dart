// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bag _$BagFromJson(Map<String, dynamic> json) => Bag(
      id: json['id'] as int,
      status: json['status'] as String,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
      deleted_at: json['deleted_at'] as String?,
      order_id: json['order_id'] as int?,
      bag_id: json['bag_id'] as String,
      bag_type: json['bag_type'] as String,
      item_count: json['item_count'] as int?,
      weight: (json['weight'] as num?)?.toDouble(),
      customer: json['customer'] as int,
    );

Map<String, dynamic> _$BagToJson(Bag instance) => <String, dynamic>{
      'id': instance.id,
      'order_id': instance.order_id,
      'status': instance.status,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'deleted_at': instance.deleted_at,
      'bag_id': instance.bag_id,
      'bag_type': instance.bag_type,
      'item_count': instance.item_count,
      'weight': instance.weight,
      'customer': instance.customer,
    };
