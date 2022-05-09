import 'package:cakeapp/presentation/utils/gaps.dart';
import 'package:cakeapp/presentation/utils/utils.dart';
import 'package:cakeapp/presentation/di/app_module.dart';
import 'package:cakeapp/presentation/screen/cart/cart_screen.dart';
import 'package:cakeapp/presentation/screen/shop/bloc/shop_bloc.dart';
import 'package:cakeapp/presentation/screen/shop/bloc/shop_event.dart';
import 'package:cakeapp/presentation/screen/shop/bloc/shop_state.dart';
import 'package:cakeapp/presentation/widgets/list_cake_card.dart';
import 'package:cakeapp/presentation/widgets/list_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ShopItem();
  }
}

class ShopItem extends StatefulWidget {
  const ShopItem({Key? key}) : super(key: key);

  @override
  _ShopItemState createState() => _ShopItemState();
}

class _ShopItemState extends State<ShopItem> {
  final _shopBloc = sl<ShopBloc>();

  @override
  void initState() {
    super.initState();
    _shopBloc.add(GetShopEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _shopBloc,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Shop'),
          backgroundColor: Colors.black,
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                NavigatorUtils.pushWidget(context, (context) => CartScreen());
              },
              child: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: 26.0,
              ),
            )
          ],
        ),
        body: Container(
          margin:
          const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
          child: Column(
            children: [
              Expanded(
                child: ListCategory(
                  shopBloc: _shopBloc,
                ),
              ),
              Expanded(
                flex: 9,
                child: ListCakeCard(shopBloc: _shopBloc),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
