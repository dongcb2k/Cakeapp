// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherResponse _$VoucherResponseFromJson(Map<String, dynamic> json) =>
    VoucherResponse(
      id: json['id'] as int,
      freeship: json['freeship'] as bool,
      description: json['description'] as String,
      percent: json['percent'] as int,
    );

Map<String, dynamic> _$VoucherResponseToJson(VoucherResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'freeship': instance.freeship,
      'description': instance.description,
      'percent': instance.percent,
    };
