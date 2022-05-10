import 'package:flutter/material.dart';

class Utils {
  static const textStyle15 = TextStyle(color: Colors.white, fontSize: 15);
  static const textStyle15black = TextStyle(color: Colors.black, fontSize: 15);
  static const textStyle18 = TextStyle(color: Colors.white, fontSize: 18);
  static const textStyle18orange =
      TextStyle(color: Colors.orange, fontSize: 18);
  static const textStyle20 = TextStyle(color: Colors.orange, fontSize: 20);
  static const textStyle25 = TextStyle(color: Colors.black, fontSize: 25);
  static const textStyle25orange =
      TextStyle(color: Colors.orange, fontSize: 25);

  static const line = Divider(
    height: 1,
    color: Colors.white,
  );
}

class NavigatorUtils {
  static Future<dynamic> pushWidget(
      BuildContext context, WidgetBuilder builder) {
    return Navigator.of(context)
        .push<dynamic>(MaterialPageRoute<dynamic>(builder: builder));
  }

  static Future<dynamic> pushAndClear(
      BuildContext context, WidgetBuilder builder) {
    return Navigator.of(context)
        .push(MaterialPageRoute<dynamic>(builder: builder));
  }

  static Future<dynamic> pushAndClearAllStack(
      BuildContext context, WidgetBuilder builder) {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: builder), (Route<dynamic> route) => false);
  }
}
