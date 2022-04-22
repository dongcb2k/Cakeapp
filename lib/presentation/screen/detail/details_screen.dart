import 'package:cakeapp/presentation/constants/gaps.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 440,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: const DecorationImage(
                            image: AssetImage(
                                "assets/images/tyler-nix-nwdtkFzDfPY-unsplash.jpg"),
                            fit: BoxFit.cover)),
                  ),
                  BackButton(
                    onPressed: () => Navigator.pop(context),
                    color: Colors.white,
                  ),
                  Positioned(
                    top: 320,
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
                              const Text(
                                "Cappuccino",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "With Oat Milk",
                                style: TextStyle(
                                  color: Color(0xff919296),
                                  fontSize: 12,
                                ),
                              ),
                              Gaps.hGap15,
                              Row(
                                children: const [
                                  Gaps.hGap10,
                                  Text(
                                    "4.5",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "(6.983)",
                                    style: TextStyle(color: Color(0xff919296)),
                                  )
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
                          color: Color(0xff919296),
                          fontWeight: FontWeight.bold),
                    ),
                    Gaps.hGap10,
                    const Text(
                      "A cappuccino is a coffee-based drink made primarily from espresso and milk.",
                      style: TextStyle(color: Color(0xff919296), fontSize: 15),
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
                                  color: Color(0xff919296),
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: const [
                                Text(
                                  r'$',
                                  style: TextStyle(
                                      color: Color(0xffd17842), fontSize: 21),
                                ),
                                Text(
                                  " 4.20",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 21),
                                )
                              ],
                            )
                          ],
                        ),
                        // ignore: deprecated_member_use
                        ButtonTheme(
                          minWidth: 200,
                          height: 50,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Buy Now",
                              style: TextStyle(
                                  color: Colors.black,
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
