import 'package:cakeapp/presentation/utils/gaps.dart';
import 'package:cakeapp/presentation/utils/utils.dart';
import 'package:cakeapp/presentation/res/colors.dart';
import 'package:cakeapp/presentation/res/strings.dart';
import 'package:cakeapp/presentation/screen/login/bloc/phone_verify_bloc.dart';
import 'package:cakeapp/presentation/screen/login/bloc/phone_verify_event.dart';
import 'package:cakeapp/presentation/screen/login/bloc/phone_verify_state.dart';
import 'package:cakeapp/presentation/screen/main_screen.dart';
import 'package:cakeapp/presentation/widgets/app_name.dart';
import 'package:cakeapp/presentation/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerifyScreen extends StatelessWidget {
  const OtpVerifyScreen({Key? key, required this.phoneVerifyBloc})
      : super(key: key);
  final PhoneVerifyBloc phoneVerifyBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: phoneVerifyBloc,
      child: const _OtpVerifyView(),
    );
  }
}

class _OtpVerifyView extends StatefulWidget {
  const _OtpVerifyView({Key? key}) : super(key: key);

  @override
  _OtpVerifyViewState createState() => _OtpVerifyViewState();
}

class _OtpVerifyViewState extends State<_OtpVerifyView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: BlocListener<PhoneVerifyBloc, PhoneVerifyState>(
        listener: (context, state) {
          if (state.isVerifySuccess) {
            NavigatorUtils.pushAndClear(
                context, (context) => const MainScreen());
          }
        },
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
                  child: BlocBuilder<PhoneVerifyBloc, PhoneVerifyState>(
                    builder: (context, state) => Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _OtpInputW(phone: state.phone),
                        CommonButton(
                          icon: const Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          label: const Text(''),
                          onPressed: () => _onSubmitVerify(context, state),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onSubmitVerify(BuildContext context, PhoneVerifyState state) {
    context
        .read<PhoneVerifyBloc>()
        .add(VerifyOtpEvent(state.otp, state.verificationId));
  }
}

class _OtpInputW extends StatelessWidget {
  const _OtpInputW({Key? key, required this.phone}) : super(key: key);

  final String phone;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth * 0.12;
    final itemHeight = itemWidth * 1.3;
    return Column(
      children: [
        PinCodeTextField(
          appContext: context,
          animationType: AnimationType.none,
          animationDuration: const Duration(milliseconds: 1),
          length: OTP_LENGTH,
          mainAxisAlignment: MainAxisAlignment.center,
          autoFocus: true,
          cursorColor: Colors.orange,
          textStyle: Utils.textStyle25,
          keyboardAppearance: Brightness.light,
          pinTheme: PinTheme(
            fieldWidth: itemWidth,
            fieldHeight: itemHeight,
            activeColor: Colors.orange,
            inactiveColor: darkGray,
            selectedColor: Colors.orange,
            fieldOuterPadding: const EdgeInsets.all(4),
          ),
          enablePinAutofill: false,
          keyboardType: TextInputType.number,
          // focusNode: focusNode,
          onChanged: (value) {
            _onChangedOtp(context, value);
          },
        ),
        Gaps.hGap20,
        const Text(
          "Don't receive OTP?",
          style: Utils.textStyle15black,
        ),
        _buildButtonResendOtp(context)
      ],
    );
  }

  ButtonTheme _buildButtonResendOtp(BuildContext context) {
    return ButtonTheme(
      minWidth: 200,
      height: 50,
      child: TextButton(
        onPressed: () =>
            context.read<PhoneVerifyBloc>().add(SendOtpSmsEvent(phone)),
        child: const Text(
          "Resend OTP",
          style: Utils.textStyle18orange,
        ),
      ),
    );
  }

  void _onChangedOtp(BuildContext context, String value) {
    context.read<PhoneVerifyBloc>().add(OtpChangedEvent(value));
  }
}
