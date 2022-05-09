import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class CategoryResponse {
  CategoryResponse({
    required this.id,
    required this.category,
    required this.icon,
  });

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'category')
  String category;

  @JsonKey(name: 'icon')
  String icon;

  factory CategoryResponse.fromJson(Map<String, dynamic> json) => _$CategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}