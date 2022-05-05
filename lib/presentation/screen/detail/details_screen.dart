import 'package:cached_network_image/cached_network_image.dart';
import 'package:cakeapp/data/modals/cake.dart';
import 'package:cakeapp/presentation/utils/gaps.dart';
import 'package:cakeapp/presentation/res/colors.dart';
import 'package:cakeapp/presentation/screen/cart/bloc/cart_bloc.dart';
import 'package:cakeapp/presentation/screen/cart/bloc/cart_event.dart';
import 'package:cakeapp/presentation/widgets/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, required this.cake}) : super(key: key);

  final CakeResponse cake;

  @override
  Widget build(BuildContext context) {
    final _cartBloc = context.read<CartBloc>();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocProvider.value(
          value: _cartBloc,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 440,
                      width: MediaQuery.of(context).size.width,
                      child: CachedNetworkImage(
                        imageUrl: cake.image,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    BackButton(
                      onPressed: () => Navigator.pop(context),
                      color: Colors.white,
                    ),
                    Positioned(
                      top: 340,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        height: 140,
                        width: 377,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cake.name,
                                  style: const TextStyle(
                                    color: Color(-386243307),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Gaps.hGap20,
                                Row(
                                  children: [
                                    SizedBox(
                                        width: 15,
                                        height: 15,
                                        child: SvgPicture.asset(
                                          'assets/images/star.svg',
                                          color: Colors.yellow,
                                        )),
                                    Gaps.wGap10,
                                    const Text(
                                      "4.5",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Gaps.hGap20,
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Description",
                        style: TextStyle(
                          color: grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      Gaps.hGap10,
                      Text(
                        cake.ingredient,
                        style: const TextStyle(color: grey, fontSize: 15),
                      ),
                      Gaps.hGap20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Price",
                                style: TextStyle(
                                  color: grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                              Gaps.hGap10,
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                        text: r'$',
                                        style: TextStyle(
                                            color: orange, fontSize: 23)),
                                    TextSpan(
                                        text: cake.price.toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 21,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              )
                            ],
                          ),
                          ButtonTheme(
                            minWidth: 200,
                            height: 50,
                            child: TextButton(
                              onPressed: () => _buttonBuy(_cartBloc, context),
                              child: const Text(
                                "Buy Now",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _buttonBuy(CartBloc _cartBloc, BuildContext context) {
    _cartBloc.add(AddCartEvent(cake.id));
    Navigator.pop(context);
    showToast(context, 'Add to Cart');
  }
}
