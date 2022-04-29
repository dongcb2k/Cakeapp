import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/gaps.dart';

class PhoneInputScreen extends StatefulWidget {
  const PhoneInputScreen({Key? key}) : super(key: key);

  @override
  _PhoneInputScreenState createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneInputScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/login.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              _buildAppName(),
              _buildTextField(),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildTextField() {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.25,
        left: 35,
        right: 35,
      ),
      child: Column(
        children: [
          TextField(
            keyboardType: TextInputType.phone,
            maxLength: 11,
            decoration: InputDecoration(
              labelText: 'Phone number',
              fillColor: Colors.grey.shade100,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          Gaps.hGap25,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  maximumSize: const Size(170.0, 90.0),
                  minimumSize: const Size(170.0, 60.0),
                  primary: Colors.black,
                  shape: const StadiumBorder(),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text('LOG IN'),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _buildAppName() {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(
        top: 45.0,
      ),
      child: const Text(
        'DCake',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.orange,
          fontSize: 55.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'logo_font',
        ),
      ),
    );
  }
}
