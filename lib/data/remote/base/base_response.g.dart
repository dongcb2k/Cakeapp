// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse<T> _$ApiResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ApiResponse<T>(
      $enumDecode(_$StatusEnumMap, json['status']),
      json['message'] as String,
      json['code'] as String?,
      Converter<T?>().fromJson(json['results']),
    );

Map<String, dynamic> _$ApiResponseToJson<T>(
  ApiResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'status': _$StatusEnumMap[instance.status],
      'message': instance.message,
      'code': instance.code,
      'results': Converter<T?>().toJson(instance.results),
    };

const _$StatusEnumMap = {
  Status.success: 'success',
  Status.failure: 'failure',
};
