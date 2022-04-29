import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'phone_verify_event.dart';
import 'phone_verify_state.dart';

@Singleton( )
@injectable
class PhoneVerifyBloc extends Bloc<PhoneVerifyEvent, PhoneVerifyState> {
  PhoneVerifyBloc() : super(PhoneVerifyState());

}
