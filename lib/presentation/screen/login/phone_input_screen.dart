import 'package:cakeapp/presentation/res/colors.dart';
import 'package:cakeapp/presentation/res/strings.dart';
import 'package:cakeapp/presentation/utils/utils.dart';
import 'package:cakeapp/presentation/di/app_module.dart';
import 'package:cakeapp/presentation/screen/login/bloc/phone_verify_bloc.dart';
import 'package:cakeapp/presentation/screen/login/bloc/phone_verify_event.dart';
import 'package:cakeapp/presentation/screen/login/bloc/phone_verify_state.dart';
import 'package:cakeapp/presentation/screen/login/verify_screen.dart';
import 'package:cakeapp/presentation/widgets/app_name.dart';
import 'package:cakeapp/presentation/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../utils/gaps.dart';

class PhoneInputScreen extends StatefulWidget {
  const PhoneInputScreen({Key? key}) : super(key: key);

  @override
  _PhoneInputScreenState createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneInputScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: BlocProvider(
        create: (context) => sl<PhoneVerifyBloc>(),
        child: SafeArea(
          child: Column(
            children: [
              const Expanded(
                flex: 2,
                child: AppName(),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(80.0))),
                  child: _buildTextField(context),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context) {
    final _verifyBloc = context.read<PhoneVerifyBloc>();

    return Container(
      padding: const EdgeInsets.only(
        top: 50,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildPhoneInput(_verifyBloc),
              Gaps.hGap25,
              BlocBuilder<PhoneVerifyBloc, PhoneVerifyState>(
                buildWhen: (previous, current) =>
                    previous.isValidPhone() != current.isValidPhone(),
                builder: (context, state) => CommonButton(
                  icon: const Text('NEXT', style: Utils.textStyle18),
                  label: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  onPressed: () => state.phone.length == PHONE_LENGTH
                      ? _onVerifyPhone(_verifyBloc, state, context)
                      : null,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPhoneInput(PhoneVerifyBloc _verifyBloc) {
    return TextField(
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
    );
  }

  void _onVerifyPhone(
    PhoneVerifyBloc _verifyBloc,
    PhoneVerifyState state,
    BuildContext context,
  ) {
    _verifyBloc.add(SendOtpSmsEvent(state.phone));

    if (state.error.isEmpty && state.phone.isNotEmpty) {
      NavigatorUtils.pushWidget(
          context, (context) => OtpVerifyScreen(phoneVerifyBloc: _verifyBloc));
    }
  }
}
