import 'package:cakeapp/data/modals/voucher.dart';
import 'package:cakeapp/presentation/res/dimens.dart';
import 'package:cakeapp/presentation/res/strings.dart';
import 'package:cakeapp/presentation/screen/payment/payment_screen.dart';
import 'package:cakeapp/presentation/utils/utils.dart';
import 'package:cakeapp/presentation/screen/cart/bloc/cart_bloc.dart';
import 'package:cakeapp/presentation/screen/cart/bloc/cart_event.dart';
import 'package:cakeapp/presentation/screen/cart/bloc/cart_state.dart';
import 'package:cakeapp/presentation/widgets/image_from_url.dart';
import 'package:cakeapp/presentation/widgets/progress_dialog.dart';
import 'package:flutter/material.dart';

import 'package:cakeapp/presentation/utils/gaps.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/app_module.dart';
import '../../res/colors.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  final _cartBloc = sl<CartBloc>();

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    widget._cartBloc.add(GetAllCartEvent());
    widget._cartBloc.add(GetAllVoucher());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => widget._cartBloc,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: const Text('My Cart'),
            backgroundColor: Colors.black,
            centerTitle: true,
          ),
          body: SafeArea(
            child: BlocBuilder<CartBloc, CartState>(
              bloc: widget._cartBloc,
              builder: (context, state) => Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: _buildListCart(),
                  ),
                  Expanded(
                    flex: 3,
                    child: Payment(
                      listVoucher: state.listVoucher,
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildListCart() {
    final listData = widget._cartBloc.state.listCake;

    return ListView.builder(
      itemCount: listData.length,
      itemBuilder: (context, index) {
        final data = listData[index];

        return Card(
          color: blackBlue,
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                  child: ImageFromUrl(
                      height: 110, width: 110, urlImage: data.image),
                ),
              ),
              Gaps.wGap15,
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Title(
                      title: data.name,
                      cartBloc: widget._cartBloc,
                      id: data.id,
                    ),
                    Price(price: data.price.toString()),
                    _buildQuantity(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuantity() {
    return Row(
      children: const [
        IconButton(
          onPressed: null,
          icon: Icon(Icons.add_circle, color: Colors.white),
        ),
        Text('1', style: TextStyle(color: Colors.white)),
        IconButton(
          onPressed: null,
          icon: Icon(Icons.add_circle, color: Colors.white),
        ),
      ],
    );
  }
}

class Price extends StatelessWidget {
  const Price({Key? key, required this.price}) : super(key: key);

  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0),
      child: RichText(
        text: TextSpan(
          children: [
            const TextSpan(
                text: r'$ ',
                style: TextStyle(color: orange, fontSize: textSize18)),
            TextSpan(
              text: price,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: textSize18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    Key? key,
    required this.title,
    required this.cartBloc,
    required this.id,
  }) : super(key: key);

  final String title;
  final int id;
  final CartBloc cartBloc;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 160,
          child: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, fontSize: textSize18),
          ),
        ),
        IconButton(
          onPressed: () => cartBloc.add(RemoveItemByIdEvent(id)),
          icon: const Icon(Icons.clear, color: Colors.white),
        ),
      ],
    );
  }
}

class Payment extends StatefulWidget {
  const Payment({Key? key, required this.listVoucher}) : super(key: key);

  final List<VoucherResponse> listVoucher;

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 15.0),
      decoration: const BoxDecoration(
          color: blackBlue,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0))),
      child: BlocProvider.value(
        value: context.read<CartBloc>(),
        child: BlocBuilder<CartBloc, CartState>(
          buildWhen: (previous, current) =>
              previous.listCake != current.listCake ||
              previous.description != current.description,
          builder: (context, state) {
            double sum =
                state.subPrice - (state.subPrice * state.percent / 100);

            return Column(
              children: [
                _buildPromo(
                  context,
                  widget.listVoucher,
                  state.description,
                  context.read<CartBloc>(),
                ),
                Gaps.hGap15,
                _buildText('Sub Total', sum.toString(), false),
                Gaps.hGap5,
                _buildText('Ship', SHIP.toString(), state.freeship),
                Gaps.hGap10,
                Utils.line,
                Gaps.hGap10,
                _buildText(
                    'TOTAL',
                    state.freeship ? sum.toString() : (sum + SHIP).toString(),
                    false),
                Gaps.hGap20,
                _buildButtonPay(context,
                    state.freeship ? sum.toString() : (sum + SHIP).toString()),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildButtonPay(BuildContext context, String sum) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) => OutlinedButton(
          onPressed: () => state.subPrice >= 5.0
              ? NavigatorUtils.pushWidget(
                  context, (context) => PaymentScreen(total: sum))
              : showToast(context, 'Cart is Empty!'),
          child: const Text('Order', style: Utils.textStyle18),
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0))),
              backgroundColor: MaterialStateProperty.all(orange)),
        ),
      ),
    );
  }

  Widget _buildText(
    String title,
    String price,
    bool freeShip,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Utils.textStyle18),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                    text: r'$',
                    style: TextStyle(color: orange, fontSize: textSize18)),
                TextSpan(
                    text: freeShip == true ? '0' : price,
                    style: Utils.textStyle18),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPromo(
    BuildContext context,
    List<VoucherResponse> list,
    String voucherDes,
    CartBloc cartBloc,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: Colors.white)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(voucherDes, style: Utils.textStyle18),
          OutlinedButton(
            onPressed: () => _buildPromoDialog(context, list, cartBloc),
            child: const Text('Add', style: Utils.textStyle18),
            style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0))),
                padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 30.0)),
                backgroundColor: MaterialStateProperty.all(orange)),
          )
        ],
      ),
    );
  }

  void _buildPromoDialog(
    BuildContext context,
    List<VoucherResponse> list,
    CartBloc cartBloc,
  ) async {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(top: 30.0, bottom: 8.0),
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final data = list[index];
              return InkWell(
                onTap: () => _onClickVoucher(cartBloc, data, context),
                child: Card(
                  color: const Color(-336017757),
                  margin: const EdgeInsets.symmetric(
                      vertical: 3.0, horizontal: 10.0),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10.0),
                        width: 80,
                        height: 80,
                        child: Image.asset('assets/images/voucher.png',
                            fit: BoxFit.cover),
                      ),
                      Gaps.wGap10,
                      Text(
                        data.description,
                        style: const TextStyle(fontSize: 22),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _onClickVoucher(
      CartBloc cartBloc, VoucherResponse data, BuildContext context) {
    cartBloc.add(PickVoucherEvent(
      data.freeship,
      data.description,
      data.percent,
    ));
    Navigator.pop(context);
  }
}
