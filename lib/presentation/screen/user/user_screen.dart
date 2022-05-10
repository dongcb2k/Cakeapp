import 'package:cakeapp/presentation/di/app_module.dart';
import 'package:cakeapp/presentation/screen/login/phone_input_screen.dart';
import 'package:cakeapp/presentation/screen/user/bloc/user_bloc.dart';
import 'package:cakeapp/presentation/screen/user/bloc/user_event.dart';
import 'package:cakeapp/presentation/screen/user/bloc/user_state.dart';
import 'package:cakeapp/presentation/utils/gaps.dart';
import 'package:cakeapp/presentation/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);


  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final _userBloc = sl<UserBloc>();

  @override
  void initState() {
    super.initState();
    _userBloc.add(GetInfoUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      bloc: _userBloc,
      builder: (context, state) => Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              const Expanded(
                  child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 70,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              )),
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 50.0,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.phone, color: Colors.orange,),
                          Gaps.wGap10,
                          Text(state.phone, style: Utils.textStyle18orange),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildButton(context),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 10.0)),
        backgroundColor: MaterialStateProperty.all(Colors.white),
      ),
      onPressed: () => _onClickLogout(context),
      child: const Text(
        'Logout',
        style: Utils.textStyle18orange,
      ),
    );
  }

  void _onClickLogout(BuildContext context) {
    _userBloc.add(LogoutEvent());
    _userBloc.close();
    NavigatorUtils.pushAndClearAllStack(
        context, (context) => const PhoneInputScreen());
  }
}
