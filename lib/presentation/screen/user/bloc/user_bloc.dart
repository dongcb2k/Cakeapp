import 'dart:async';

import 'package:cakeapp/domain/local/local_data.dart';
import 'package:cakeapp/presentation/screen/user/bloc/user_event.dart';
import 'package:cakeapp/presentation/screen/user/bloc/user_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this._localData) : super(const UserState()) {
    on<GetInfoUserEvent>(_getUserInfo);

    on<LogoutEvent>(_onLogout);
  }

  final LocalData _localData;

  Future<void> _getUserInfo(
    GetInfoUserEvent event,
    Emitter<UserState> emit,
  ) async {
    final phone = await _localData.getPhoneNumber;
    emit(state.copyWith(phone: phone.toString()));
  }

  Future<void> _onLogout(
    LogoutEvent event,
    Emitter<UserState> emit,
  ) async {
    FirebaseAuth.instance.signOut();
  }
}
