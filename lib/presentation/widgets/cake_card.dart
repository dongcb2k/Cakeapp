import 'package:cakeapp/data/modals/cake.dart';
import 'package:cakeapp/presentation/utils/gaps.dart';
import 'package:cakeapp/presentation/utils//utils.dart';
import 'package:cakeapp/presentation/screen/detail/details_screen.dart';
import 'package:cakeapp/presentation/widgets/image_from_url.dart';
import 'package:flutter/material.dart';

class CakeCard extends StatefulWidget {
  const CakeCard({Key? key}) : super(key: key);

  @override
  State<CakeCard> createState() => _CakeCardState();
}

class _CakeCardState extends State<CakeCard> {
  List<CakeResponse> listCake = [
    CakeResponse(
      id: 5,
      name: 'Matcha Tiramisu',
      image: 'https://www.linkpicture.com/q/matcha2_1.jpg',
      ingredient: 'With Matcha Powder',
      price: 22,
      category: 'cake',
    ),
    CakeResponse(
      id: 11,
      name: 'Chocolate Tiramisu',
      image: 'https://www.linkpicture.com/q/chocolate.jpg',
      ingredient: 'With Chocolate Powder',
      price: 20,
      category: 'cake',
    ),
    CakeResponse(
      id: 7,
      name: 'Horny Cake',
      image: 'https://www.linkpicture.com/q/horny.jpg',
      ingredient: 'With Caramel Drizzle',
      price: 14,
      category: 'cake',
    ),
    CakeResponse(
      id: 9,
      name: 'Ocean Cake',
      image: 'https://www.linkpicture.com/q/ocean.jpg',
      ingredient: 'With Oat Milk',
      price: 18,
      category: 'cake',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: listCake.length,
        itemBuilder: (context, index) {
          final _data = listCake[index];

          return InkWell(
            onTap: () => {
              NavigatorUtils.pushWidget(
                  context, (context) => DetailsScreen(cake: _data))
            },
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
                        child: ImageFromUrl(
                          height: 120,
                          width: 150,
                          urlImage: _data.image,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
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
                              _data.ingredient,
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
                                        text: _data.price.toString(),
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
}
