import 'package:flutter/material.dart';

class Utils {
  static const textStyle15 = TextStyle(color: Colors.white, fontSize: 15);
  static const textStyle18 = TextStyle(color: Colors.white, fontSize: 18);
  static const textStyle25 = TextStyle(color: Colors.black, fontSize: 25);

  static const line = Divider(
    height: 1,
    color: Colors.white,
  );
}

class NavigatorUtils {

  static Future<dynamic> pushWidget(BuildContext context,
      WidgetBuilder builder) {
    return Navigator.of(context)
        .push<dynamic>(MaterialPageRoute<dynamic>(builder: builder));
  }

  static Future<dynamic> pushAndClear(BuildContext context,
      WidgetBuilder builder) {
    return Navigator.of(context)
        .pushReplacement(MaterialPageRoute<dynamic>(builder: builder));
  }
}
