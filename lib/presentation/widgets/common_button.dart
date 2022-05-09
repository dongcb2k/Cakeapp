import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {Key? key,
      required this.icon,
      required this.label,
      this.onPressed,
      this.padding,
      this.radius,
      this.widthPadding,
      this.heightPadding})
      : super(key: key);

  final Widget icon;
  final Widget label;
  final VoidCallback? onPressed;
  final double? radius;
  final double? widthPadding;
  final double? heightPadding;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.symmetric(
            vertical: heightPadding ?? 18.0,
            horizontal: widthPadding ?? 50.0,
          )),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.orangeAccent;
              } else if (states.contains(MaterialState.disabled)) {
                return Colors.grey;
              }
              return Colors.orangeAccent; // Use the component's default.
            },
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 30),
          ))),
      icon: icon,
      label: label,
    );
  }
}
