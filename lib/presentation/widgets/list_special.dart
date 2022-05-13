import 'package:cakeapp/presentation/di/app_module.dart';
import 'package:cakeapp/presentation/res/colors.dart';
import 'package:cakeapp/presentation/screen/cart/bloc/cart_bloc.dart';
import 'package:cakeapp/presentation/screen/cart/bloc/cart_event.dart';
import 'package:cakeapp/presentation/screen/detail/details_screen.dart';
import 'package:cakeapp/presentation/utils/gaps.dart';
import 'package:cakeapp/presentation/utils/utils.dart';
import 'package:cakeapp/presentation/widgets/image_from_url.dart';
import 'package:cakeapp/presentation/widgets/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/modals/cake.dart';

class ListSpecialCake extends StatelessWidget {
  ListSpecialCake({Key? key, this.listCake}) : super(key: key);

  final List<CakeResponse>? listCake;
  final _cartBloc = sl<CartBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _cartBloc,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: listCake?.length,
        itemBuilder: (context, index) {
          final data = listCake![index];

          return InkWell(
            onTap: () {
              NavigatorUtils.pushWidget(
                  context, (context) => DetailsScreen(cake: data));
            },
            child: Column(
              children: [
                Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Gaps.wGap10,
                      ImageFromUrl(
                        height: 120,
                        width: 130,
                        urlImage: data.image,
                      ),
                      Gaps.wGap15,
                      _buildInfoItem(data, context)
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: const Color(0xff141921),
                      borderRadius: BorderRadius.circular(20)),
                ),
                Gaps.hGap15,
              ],
            ),
          );
        },
      ),
    );
  }

  Column _buildInfoItem(CakeResponse data, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.name,
          style: Utils.textStyle18,
        ),
        Gaps.hGap5,
        Text(
          data.ingredient,
          style: const TextStyle(color: Color(0xff919293), fontSize: 12),
        ),
        Gaps.hGap10,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                      text: r'$ ',
                      style: TextStyle(
                          color: orange,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: data.price.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Gaps.wGap75,
            _buildButtonAdd(data, context),
          ],
        ),
      ],
    );
  }

  Container _buildButtonAdd(CakeResponse data, BuildContext context) {
    return Container(
      height: 25,
      width: 25,
      decoration:
      BoxDecoration(color: orange, borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
        onTap: () {
          _cartBloc.add(AddCartEvent(data.id));
          showToast(context, 'Add to Cart');
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 20.0,
        ),
      ),
    );
  }
}
