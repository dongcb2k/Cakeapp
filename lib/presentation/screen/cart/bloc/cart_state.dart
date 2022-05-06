import 'package:cakeapp/data/modals/cake.dart';
import 'package:cakeapp/data/modals/voucher.dart';
import 'package:equatable/equatable.dart';

class CartState extends Equatable {
  const CartState({
    this.listCake = const [],
    this.listVoucher = const [],
    this.subPrice = 0,
    this.freeship = false,
    this.description = 'Add Promo',
    this.percent = 0,
  });

  final List<CakeResponse> listCake;
  final List<VoucherResponse> listVoucher;
  final double subPrice;
  final bool freeship;
  final String description;
  final int percent;

  @override
  List<Object?> get props => [
        listCake,
        subPrice,
        listVoucher,
        freeship,
        description,
        percent,
      ];

  CartState copyWith({
    List<CakeResponse>? listCake,
    List<VoucherResponse>? listVoucher,
    double? subPrice,
    bool? freeship,
    String? description,
    int? percent,
  }) {
    return CartState(
      listCake: listCake ?? this.listCake,
      subPrice: subPrice ?? this.subPrice,
      listVoucher: listVoucher ?? this.listVoucher,
      freeship: freeship ?? this.freeship,
      description: description ?? this.description,
      percent: percent ?? this.percent,
    );
  }
}
