// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) {
  return Cart(
    cartId: json['cartId'] as String,
    orders: (json['orders'] as List)
        ?.map(
            (e) => e == null ? null : Order.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    totalPrice: (json['totalPrice'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'cartId': instance.cartId,
      'orders': instance.orders?.map((e) => e?.toJson())?.toList(),
      'totalPrice': instance.totalPrice,
    };
