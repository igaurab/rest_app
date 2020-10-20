// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodItem _$FoodItemFromJson(Map<String, dynamic> json) {
  return FoodItem(
    id: json['id'] as String,
    name: json['name'] as String,
    category: json['category'] as String,
    imageUrl: json['imageUrl'] as String,
    price: json['price'] as String,
  );
}

Map<String, dynamic> _$FoodItemToJson(FoodItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'imageUrl': instance.imageUrl,
      'category': instance.category,
    };
