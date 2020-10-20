import 'package:protoype/models/order.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable(explicitToJson: true)
class Cart {
  String cartId;
  List<Order> orders;
  double totalPrice;
  Cart({this.cartId, this.orders, this.totalPrice});

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);
}
