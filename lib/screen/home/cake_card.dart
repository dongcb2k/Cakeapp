import 'package:cakeapp/constants/gaps.dart';
import 'package:flutter/material.dart';

import '../detail/details_screen.dart';

class CakeCard extends StatefulWidget {

  const CakeCard({Key? key}) : super(key: key);

  @override
  State<CakeCard> createState() => _CakeCardState();
}

class _CakeCardState extends State<CakeCard> {
  List<String> images = [
    "assets/images/tyler-nix-nwdtkFzDfPY-unsplash.jpg",
    "assets/images/newcappuccino.jpg",
    "assets/images/newcoffee.jpg",
    "assets/images/nicholas-grande-Hd36cpebWbQ-unsplash.jpg",
  ];

  List<String> ingredients = [
    "With Oat Milk",
    "With Cinnamon Powder",
    "With Chocolate Powder",
    "With Caramel Drizzle"
  ];

  List<double> price = [4.29, 3.21, 6.46, 2.90];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _navigateDetailItem(context),
            child: Row(
              children: [
                Container(
                  height: 250,
                  width: 160,
                  child: Column(
                    children: [
                      Gaps.hGap10,
                      Container(
                        height: 135,
                        width: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: AssetImage(images[index]),
                                fit: BoxFit.cover)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Cappuccino",
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              ingredients[index],
                              style: const TextStyle(
                                  color: Color(0xff919293), fontSize: 11),
                            ),
                            Gaps.hGap5,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(children: [
                                    const TextSpan(
                                        text: r'$ ',
                                        style: TextStyle(
                                            color: Color(0xffd17842),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: '${price[index]}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold))
                                  ]),
                                ),
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffd17842),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: const Color(0xff242931),
                      borderRadius: BorderRadius.circular(20)),
                ),
                Gaps.wGap20,
              ],
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> _navigateDetailItem(BuildContext context) {
    return Navigator.push(context,
        MaterialPageRoute(builder: (context) => const DetailsScreen()));
  }
}