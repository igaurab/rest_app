import 'package:json_annotation/json_annotation.dart';
part 'food_item.g.dart';

@JsonSerializable()
class FoodItem {
  String id;
  String name;
  String price;
  String imageUrl;
  String category;

  FoodItem({this.id, this.name, this.category, this.imageUrl, this.price});

  factory FoodItem.fromJson(Map<String, dynamic> json) =>
      _$FoodItemFromJson(json);

  Map<String, dynamic> toJson() => _$FoodItemToJson(this);
}
