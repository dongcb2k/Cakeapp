import 'package:cakeapp/presentation/di/app_module.dart';
import 'package:cakeapp/presentation/screen/cart/bloc/cart_bloc.dart';
import 'package:cakeapp/presentation/screen/cart/bloc/cart_event.dart';
import 'package:cakeapp/presentation/screen/payment/bloc/payment_bloc.dart';
import 'package:cakeapp/presentation/screen/payment/bloc/payment_event.dart';
import 'package:cakeapp/presentation/screen/payment/bloc/payment_state.dart';
import 'package:cakeapp/presentation/utils/gaps.dart';
import 'package:cakeapp/presentation/utils/utils.dart';
import 'package:cakeapp/presentation/widgets/common_text_field.dart';
import 'package:cakeapp/presentation/widgets/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef ValueSetter<T> = void Function(T value);

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key, required this.total}) : super(key: key);

  final String total;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _cartBloc = sl<CartBloc>();
  final _paymentBloc = sl<PaymentBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _paymentBloc,
      child: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) => Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: const Text('Payment'),
            backgroundColor: Colors.black,
            centerTitle: true,
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 5.0,
            ),
            child: Column(
              children: [
                _buildTextField(
                    'Name', (name) => _paymentBloc.add(NameChangedEvent(name))),
                _buildTextField(
                    'Phone Number',
                    (phone) =>
                        _paymentBloc.add(PhoneNumberChangedEvent(phone))),
                _buildTextField(
                    'Location',
                    (location) =>
                        _paymentBloc.add(LocationChangedEvent(location))),
                Gaps.hGap20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'TOTAL',
                      style: Utils.textStyle25orange,
                    ),
                    Text(
                      r'$' + widget.total,
                      style: Utils.textStyle25orange,
                    ),
                  ],
                )
              ],
            ),
          ),
          bottomNavigationBar: Material(
            color: const Color(0xffff8906),
            child: InkWell(
              onTap: () {
                state.isValid
                    ? _showDialogConfirm(context)
                    : showToast(context, 'All fields must be entered');
              },
              child: const SizedBox(
                height: kToolbarHeight,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Accept',
                    style: Utils.textStyle25,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDialogConfirm(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Confirm to Order?'),
          content: const Text('Are you sure to order items?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => _onPayment(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );

  void _onPayment(BuildContext context) {
    _paymentBloc.add(OrderEvent(widget.total));
    _cartBloc.add(RemoveAllItemEvent());
    showToast(context, "Order Success");
    Navigator.of(context)
      ..pop()
      ..pop()
      ..pop();
  }

  Widget _buildTextField(String title, Function(String) callback) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Utils.textStyle15),
          Gaps.hGap10,
          CommonTextField(
            textInputAction: TextInputAction.next,
            styles: Utils.textStyle18,
            onChanged: (value) => callback(value),
          ),
          Gaps.hGap20,
        ],
      );
}
