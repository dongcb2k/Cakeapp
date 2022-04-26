import 'package:cached_network_image/cached_network_image.dart';
import 'package:cakeapp/data/modals/cake.dart';
import 'package:cakeapp/presentation/constants/gaps.dart';
import 'package:cakeapp/presentation/constants/utils.dart';
import 'package:cakeapp/presentation/screen/cart/bloc/cart_bloc.dart';
import 'package:cakeapp/presentation/screen/detail/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/res/colors.dart';
import '../screen/cart/bloc/cart_event.dart';

class ListCakeCard extends StatelessWidget {
  const ListCakeCard({Key? key, this.listCake}) : super(key: key);

  final List<CakeResponse>? listCake;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                    const SizedBox(
                      width: 10,
                    ),
                    _buildImages(data),
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
    );
  }

  SizedBox _buildImages(CakeResponse data) {
    return SizedBox(
      height: 120,
      width: 150,
      child: CachedNetworkImage(
        imageUrl: data.image,
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
    );
  }

  Column _buildInfoItem(CakeResponse data, BuildContext context) {
    final cartBloc = context.read<CartBloc>();

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
                      text: r'$',
                      style: TextStyle(
                          color: orange,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: data.price.toString(), style: Utils.textStyle18),
                ],
              ),
            ),
            Gaps.wGap100,
            _buildButtonAdd(cartBloc, data),
          ],
        ),
      ],
    );
  }

  Container _buildButtonAdd(CartBloc cartBloc, CakeResponse data) {
    return Container(
      height: 25,
      width: 25,
      decoration: BoxDecoration(
          color: const Color(0xffd17842),
          borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
        onTap: () {
          cartBloc.add(AddItemEvent(data.id));
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
