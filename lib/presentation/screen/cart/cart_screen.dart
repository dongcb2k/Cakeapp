import 'package:cached_network_image/cached_network_image.dart';
import 'package:cakeapp/presentation/res/dimens.dart';
import 'package:cakeapp/presentation/constants/utils.dart';
import 'package:cakeapp/presentation/screen/cart/bloc/cart_bloc.dart';
import 'package:cakeapp/presentation/screen/cart/bloc/cart_event.dart';
import 'package:cakeapp/presentation/screen/cart/bloc/cart_state.dart';
import 'package:cakeapp/presentation/widgets/image_from_url.dart';
import 'package:flutter/material.dart';

import 'package:cakeapp/presentation/constants/gaps.dart';
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
              buildWhen: (p, c) => p.listCake != c.listCake,
              builder: (context, state) => Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: _buildListCart(),
                  ),
                  const Expanded(
                    flex: 3,
                    child: Payment(),
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
      itemCount: listData?.length ?? 0,
      itemBuilder: (context, index) {
        final data = listData![index];

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
                    Title(title: data.name),
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
  const Title({Key? key, required this.title}) : super(key: key);

  final String title;

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
        const IconButton(
          onPressed: null,
          icon: Icon(Icons.clear, color: Colors.white),
        ),
      ],
    );
  }
}

class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 15.0),
      decoration: const BoxDecoration(
          color: blackBlue,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0))),
      child: Column(
        children: [
          _buildPromo(context),
          Gaps.hGap10,
          _buildText('Sub Total', '16'),
          Gaps.hGap5,
          _buildText('Shipping', '2'),
          Gaps.hGap10,
          Utils.line,
          Gaps.hGap10,
          _buildText('TOTAL', '14'),
          Gaps.hGap20,
          _buildButtonPay(),
        ],
      ),
    );
  }

  Widget _buildButtonPay() {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: null,
        child: const Text('Order', style: Utils.textStyle18),
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0))),
            backgroundColor: MaterialStateProperty.all(orange)),
      ),
    );
  }

  Widget _buildText(String title, String price) {
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
                TextSpan(text: price, style: Utils.textStyle18),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPromo(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: Colors.white)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Promo Code', style: Utils.textStyle18),
          OutlinedButton(
            onPressed: () => _buildPromoDialog(context),
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

  Future _buildPromoDialog(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 1,
          child: ListView(
            children: [
              ListTile(
                title: const Text('1'),
                leading: CachedNetworkImage(
                  imageUrl: 'https://www.linkpicture.com/q/matcha2.jpg',
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}