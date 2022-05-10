import 'package:json_annotation/json_annotation.dart';

part 'cart_order.g.dart';

@JsonSerializable()
class CartOrder {
  CartOrder(
    this.name,
    this.phoneNumber,
    this.location,
    this.listCake,
    this.price,
  );

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'phoneNumber')
  String phoneNumber;

  @JsonKey(name: 'location')
  String location;

  @JsonKey(name: 'listCake')
  String listCake;

  @JsonKey(name: 'price')
  String price;

  factory CartOrder.fromJson(Map<String, dynamic> json) => _$CartOrderFromJson(json);

  Map<String, dynamic> toJson() => _$CartOrderToJson(this);
}
