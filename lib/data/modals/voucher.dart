import 'package:json_annotation/json_annotation.dart';

part 'voucher.g.dart';

@JsonSerializable()
class VoucherResponse {
  VoucherResponse({
    required this.id,
    required this.freeship,
    required this.description,
    required this.percent,
  });

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'freeship')
  bool freeship;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'percent')
  int percent;

  factory VoucherResponse.fromJson(Map<String, dynamic> json) => _$VoucherResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherResponseToJson(this);
}