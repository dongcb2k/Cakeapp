import 'package:cakeapp/presentation/constants/utils.dart';
import 'package:cakeapp/presentation/di/app_module.dart';
import 'package:cakeapp/presentation/screen/login/bloc/phone_verify_bloc.dart';
import 'package:cakeapp/presentation/screen/login/bloc/phone_verify_event.dart';
import 'package:cakeapp/presentation/screen/login/bloc/phone_verify_state.dart';
import 'package:cakeapp/presentation/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: BlocProvider(
        create: (context) => sl<PhoneVerifyBloc>(),
        child: BlocListener<PhoneVerifyBloc, PhoneVerifyState>(
          listener: (context, state) {
            if (state.isVerifySuccess == true) {
              NavigatorUtils.pushAndClear(
                  context, (context) => const MainScreen());
            }
          },
          child: SafeArea(
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
                  _buildTextField(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildTextField(BuildContext context) {
    final _verifyBloc = context.read<PhoneVerifyBloc>();

    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery
            .of(context)
            .size
            .height * 0.25,
        left: 35,
        right: 35,
      ),
      child: BlocBuilder<PhoneVerifyBloc, PhoneVerifyState>(
        bloc: _verifyBloc,
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              TextField(
                keyboardType: TextInputType.phone,
                maxLength: 10,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  labelText: 'Phone number',
                  counterText: '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onChanged: (phone) {
                  _verifyBloc.add(PhoneChangedEvent(phone));
                },
              ),
              Gaps.hGap25,
              TextField(
                keyboardType: TextInputType.phone,
                maxLength: 10,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  labelText: 'Verify',
                  counterText: '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onChanged: (otp) {
                  _verifyBloc.add(OtpChangedEvent(otp));
                },
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
                    onPressed: () {
                      _verifyBloc.add(SendOtpSmsEvent(state.phone));
                      _verifyBloc.add(VerifyOtpEvent(state.otp, state.verificationId));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          );
        },
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
