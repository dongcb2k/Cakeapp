import 'package:cakeapp/constants/gaps.dart';
import 'package:flutter/material.dart';

class SpecialCakeCard extends StatelessWidget {
  List<String> specialImages = [
    "assets/images/kaffebase-coffeeshop-uAx74-kc5Kw-unsplash.jpg",
    "assets/images/coffee.jpg",
    "assets/images/lattee.jpg"
  ];

  List<String> coffeeName = [
    "Caramel Macchiato ",
    "Turkish Coffee",
    "Cafe Cubanoi"
  ];

  List<String> ingredients = [
    "Ice, Cramel Sauce, Espresso",
    "Turkish coffee, Sugar",
    "Ground Coffee, Water"
  ];

  List<String> price = ["5.00", "7.50", "9.00"];

  SpecialCakeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: specialImages.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: 140,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 120,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          image: DecorationImage(
                              image: AssetImage(specialImages[index]),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    Gaps.wGap15,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          coffeeName[index],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Gaps.hGap5,
                        Text(
                          ingredients[index],
                          style: const TextStyle(
                              color: Color(0xff919293), fontSize: 12),
                        ),
                        Gaps.hGap5,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  r'$ ',
                                  style: TextStyle(
                                      color: Color(0xffd17842),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  price[index],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 80,
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
                                ))
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    color: const Color(0xff141921),
                    borderRadius: BorderRadius.circular(20)),
              ),
              Gaps.hGap15,
            ],
          );
        });
  }
}
