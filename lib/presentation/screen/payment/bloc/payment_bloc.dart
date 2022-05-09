import 'package:cakeapp/presentation/screen/payment/bloc/payment_event.dart';
import 'package:cakeapp/presentation/screen/payment/bloc/payment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(const PaymentState()) {
    on<NameChangedEvent>(
        (event, emit) => emit(state.copyWith(name: event.name)));

    on<PhoneNumberChangedEvent>(
        (event, emit) => emit(state.copyWith(phoneNumber: event.phone)));

    on<LocationChangedEvent>(
        (event, emit) => emit(state.copyWith(location: event.location)));
  }
}
