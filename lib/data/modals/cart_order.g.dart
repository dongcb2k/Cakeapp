// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartOrder _$CartOrderFromJson(Map<String, dynamic> json) => CartOrder(
      json['name'] as String,
      json['phoneNumber'] as String,
      json['location'] as String,
      json['listCake'] as String,
      json['price'] as String,
    );

Map<String, dynamic> _$CartOrderToJson(CartOrder instance) => <String, dynamic>{
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'location': instance.location,
      'listCake': instance.listCake,
      'price': instance.price,
    };
