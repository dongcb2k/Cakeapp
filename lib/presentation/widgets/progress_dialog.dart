import 'package:cakeapp/presentation/utils/gaps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

bool _isShowDialog = false;

void setHideLoadingVariable() {
  _isShowDialog = false;
}

void showToast(BuildContext context, String title) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      backgroundColor: const Color(-220299735),
      content: Text(
        title,
        textAlign: TextAlign.center,
      ),
    ),
  );
}

void hideLoading({required BuildContext context}) {
  if (_isShowDialog) {
    Navigator.of(context, rootNavigator: true).pop();
    _isShowDialog = false;
  }
}

Future<void> showLoading({required BuildContext context}) async {
  try {
    if (_isShowDialog) return;
    _isShowDialog = true;

    await showTransparentDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return WillPopScope(
          onWillPop: () async {
            return Future.value(false);
          },
          child: const ProgressDialog(
            hintText: 'Loading',
          ),
        );
      },
    ).then((value) {
      _isShowDialog = false;
    });
  } catch (e) {
    logger.e(e.toString());
  }
}

class ProgressDialog extends Dialog {
  const ProgressDialog({
    Key? key,
    this.hintText = '',
  }) : super(key: key);

  final String hintText;

  @override
  Widget build(BuildContext context) {
    final Widget progress = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Theme(
          data: ThemeData(
            cupertinoOverrideTheme: const CupertinoThemeData(
              brightness: Brightness.light,
            ),
          ),
          child: const CircularProgressIndicator.adaptive(),
        ),
        Gaps.hGap10,
        Text(
          hintText.isEmpty ? 'Loading' : hintText,
          style: const TextStyle(color: Colors.black),
        )
      ],
    );

    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          height: 100,
          width: 120.0,
          decoration: const ShapeDecoration(
            color: Colors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
          child: progress,
        ),
      ),
    );
  }
}

Future<T?> showTransparentDialog<T>({
  required BuildContext context,
  bool barrierDismissible = true,
  required WidgetBuilder builder,
  bool useRootNavigator = true,
  Color? barrierColor,
}) async {
  final ThemeData theme = Theme.of(context);
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final Widget pageChild = Builder(builder: builder);
      return SafeArea(
        child: Builder(builder: (BuildContext context) {
          return Theme(data: theme, child: pageChild);
        }),
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: barrierColor ?? const Color(0x00FFFFFF),
    transitionDuration: const Duration(milliseconds: 150),
    useRootNavigator: useRootNavigator,
    transitionBuilder: _buildMaterialDialogTransitions,
  );
}

Widget _buildMaterialDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return FadeTransition(
    opacity: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}
