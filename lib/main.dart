import 'package:cakeapp/presentation/di/app_module.dart';
import 'package:cakeapp/presentation/screen/cart/bloc/cart_bloc.dart';
import 'package:cakeapp/presentation/screen/login/phone_input_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:logger/logger.dart';
import 'package:sp_util/sp_util.dart';

import 'presentation/screen/login/bloc/phone_verify_bloc.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

void main() async {
  initSplash();
  SpUtil.getInstance();
  await Firebase.initializeApp();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<CartBloc>()),
        BlocProvider(create: (context) => sl<PhoneVerifyBloc>()),
      ],
      child: MaterialApp(
        color: Colors.white,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(backgroundColor: Colors.white),
        home: const PhoneInputScreen(),
      ),
    );
  }
}

void initSplash() {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
}
