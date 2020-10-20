// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    orderId: json['orderId'] as String,
    foodItem: json['foodItem'] == null
        ? null
        : FoodItem.fromJson(json['foodItem'] as Map<String, dynamic>),
    numberOfItems: json['numberOfItems'] as int,
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'orderId': instance.orderId,
      'foodItem': instance.foodItem?.toJson(),
      'numberOfItems': instance.numberOfItems,
    };
