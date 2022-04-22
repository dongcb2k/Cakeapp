import 'package:json_annotation/json_annotation.dart';

part 'cake.g.dart';

@JsonSerializable()
class CakeResponse {
  CakeResponse({
    required this.id,
    required this.name,
    required this.image,
    required this.ingredient,
    required this.price,
  });

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'image')
  String? image;

  @JsonKey(name: 'ingredient')
  String? ingredient;

  @JsonKey(name: 'price')
  int? price;

  factory CakeResponse.fromJson(Map<String, dynamic> json) => _$CakeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CakeResponseToJson(this);
}
