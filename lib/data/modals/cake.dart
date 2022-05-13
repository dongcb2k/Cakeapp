import 'package:json_annotation/json_annotation.dart';

part 'cake.g.dart';

@JsonSerializable()
class CakeResponse {
  CakeResponse({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    required this.ingredient,
    required this.price,
    required this.count,
  });

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'category')
  String? category;

  @JsonKey(name: 'image')
  String image;

  @JsonKey(name: 'ingredient')
  String ingredient;

  @JsonKey(name: 'price')
  double price;

  @JsonKey(name: 'count')
  int? count;

  factory CakeResponse.fromJson(Map<String, dynamic> json) => _$CakeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CakeResponseToJson(this);
}
