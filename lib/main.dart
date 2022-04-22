import 'package:cakeapp/presentation/di/app_module.dart';
import 'package:cakeapp/presentation/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

Future<void> main() async {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.white
      ),
      home: const MainScreen(),
    );
  }
}
