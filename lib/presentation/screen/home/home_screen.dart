import 'package:cakeapp/data/modals/cake.dart';
import 'package:cakeapp/presentation/utils/gaps.dart';
import 'package:cakeapp/presentation/widgets/list_cake_card.dart';
import 'package:flutter/material.dart';

import '../../widgets/cake_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CakeResponse> listCake = [
    CakeResponse(
        id: 2,
        name: 'Sakura Cake',
        image: 'https://www.linkpicture.com/q/sakura.jpg',
        ingredient: 'With Strawberry Siro',
        price: 25),
    CakeResponse(
        id: 3,
        name: 'Blueberry Cake',
        image: 'https://www.linkpicture.com/q/blueberry.jpg',
        ingredient: 'With Blueberry And Sugar',
        price: 18),
    CakeResponse(
        id: 11,
        name: 'Chocolate Tiramisu',
        image: 'https://www.linkpicture.com/q/chocolate.jpg',
        ingredient: 'With Chocolate Powder',
        price: 20),
    CakeResponse(
        id: 12,
        name: 'Strawberry Cake',
        image: 'https://www.linkpicture.com/q/strawberry.jpg',
        ingredient: 'With Oat Milk And Strawberry',
        price: 18),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),
          children: [
            Gaps.hGap10,
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Find the best\ncake for you",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  CakeCard(),
                  Text(
                    "Special for you",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Gaps.hGap20,
            ListCakeCard(listCake: listCake),
          ],
        ),
      ),
    );
  }
}
