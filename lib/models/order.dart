import 'package:protoype/models/food_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  String orderId;
  FoodItem foodItem;
  int numberOfItems;

  Order({this.orderId, this.foodItem, this.numberOfItems});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
