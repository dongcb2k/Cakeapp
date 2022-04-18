import 'package:cakeapp/constants/gaps.dart';
import 'package:cakeapp/screen/home/special_cake_card.dart';
import 'package:flutter/material.dart';

import 'cake_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

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
            SpecialCakeCard(),
          ],
        ),
      ),
    );
  }
}
