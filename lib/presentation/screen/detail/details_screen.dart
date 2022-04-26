import 'package:cached_network_image/cached_network_image.dart';
import 'package:cakeapp/data/modals/cake.dart';
import 'package:cakeapp/presentation/constants/gaps.dart';
import 'package:cakeapp/presentation/constants/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, required this.cake}) : super(key: key);

  final CakeResponse cake;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
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
                      style:
                          TextStyle(color: grey, fontWeight: FontWeight.bold),
                    ),
                    Gaps.hGap10,
                    Text(
                      cake.ingredient,
                      style: const TextStyle(color: grey, fontSize: 15),
                    ),
                    Gaps.hGap25,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Price",
                              style: TextStyle(
                                  color: grey, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Text(
                                  r'$',
                                  style: TextStyle(
                                      color: Color(0xffd17842), fontSize: 23),
                                ),
                                Text(
                                  cake.price.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        ),
                        ButtonTheme(
                          minWidth: 200,
                          height: 50,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Buy Now",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
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
    );
  }
}
