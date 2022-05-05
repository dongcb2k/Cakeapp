import 'package:flutter/material.dart';

class AppName extends StatelessWidget {
  const AppName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(
        top: 45.0,
      ),
      child: Column(children: [
        const Text(
          'DCake',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 55.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'logo_font',
          ),
        ),
        Image.asset(
          'assets/images/cake.png',
          width: 70,
          height: 70,
        ),
      ]),
    );
  }
}
