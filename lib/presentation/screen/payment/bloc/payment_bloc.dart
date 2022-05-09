import 'package:cakeapp/presentation/screen/payment/bloc/payment_event.dart';
import 'package:cakeapp/presentation/screen/payment/bloc/payment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(const PaymentState());

}
