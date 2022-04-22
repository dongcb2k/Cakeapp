import 'package:cakeapp/presentation/constants/gaps.dart';
import 'package:cakeapp/presentation/screen/cart/bloc/cart_bloc.dart';
import 'package:cakeapp/presentation/widgets/special_cake_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/cake_card.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartBloc>();
    
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
