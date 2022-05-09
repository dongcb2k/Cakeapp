import 'package:cakeapp/presentation/di/app_module.dart';
import 'package:cakeapp/presentation/screen/cart/bloc/cart_bloc.dart';
import 'package:cakeapp/presentation/utils/gaps.dart';
import 'package:cakeapp/presentation/utils/utils.dart';
import 'package:cakeapp/presentation/widgets/common_text_field.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _cartBloc = sl<CartBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 5.0,
        ),
        child: Column(
          children: [
            _buildTextField('Name'),
            _buildTextField('Phone Number'),
            _buildTextField('Location'),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Utils.textStyle15),
        Gaps.hGap10,
        CommonTextField(
          textInputAction: TextInputAction.next,
          styles: Utils.textStyle18,
          onChanged: (value) {},
          validator: (nickName) {
            if (nickName!.isEmpty) {
              return 'Cant be empty';
            }
            return null;
          },
        ),
        Gaps.hGap20,
      ],
    );
  }
}
