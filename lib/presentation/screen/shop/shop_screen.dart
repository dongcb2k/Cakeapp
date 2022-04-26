import 'package:cakeapp/data/modals/cake.dart';
import 'package:cakeapp/presentation/constants/utils.dart';
import 'package:cakeapp/presentation/di/app_module.dart';
import 'package:cakeapp/presentation/screen/cart/bloc/cart_bloc.dart';
import 'package:cakeapp/presentation/screen/cart/cart_screen.dart';
import 'package:cakeapp/presentation/screen/shop/bloc/shop_bloc.dart';
import 'package:cakeapp/presentation/screen/shop/bloc/shop_event.dart';
import 'package:cakeapp/presentation/screen/shop/bloc/shop_state.dart';
import 'package:cakeapp/presentation/widgets/list_cake_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({
    Key? key,
    required this.cartBloc,
  }) : super(key: key);

  final CartBloc cartBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cartBloc,
      child: const ShopItem(),
    );
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
        body: BlocBuilder<ShopBloc, ShopState>(
          bloc: _shopBloc,
          buildWhen: (p, v) => p.listCake != v.listCake,
          builder: (context, state) {
            return ListItem(listCake: state.listCake);
          },
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({Key? key, required this.listCake}) : super(key: key);
  final List<CakeResponse>? listCake;

  @override
  Widget build(BuildContext context) {
    return ListCakeCard(listCake: listCake ?? []);
  }
}
