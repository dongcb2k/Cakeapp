// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cake.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CakeResponse _$CakeResponseFromJson(Map<String, dynamic> json) => CakeResponse(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as String,
      image: json['image'] as String,
      ingredient: json['ingredient'] as String,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$CakeResponseToJson(CakeResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'image': instance.image,
      'ingredient': instance.ingredient,
      'price': instance.price,
    };
