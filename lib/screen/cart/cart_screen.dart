import 'package:cached_network_image/cached_network_image.dart';
import 'package:cakeapp/constants/res/dimens.dart';
import 'package:cakeapp/constants/utils.dart';
import 'package:flutter/material.dart';

import '../../constants/gaps.dart';
import '../../constants/res/colors.dart';

class CartScreen extends StatefulWidget {
  final List<String> listCart;

  const CartScreen({Key? key, required this.listCart}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: _buildListCart(widget.listCart),
            ),
            const Expanded(
              flex: 3,
              child: Payment(),
            )
          ],
        ),
      ),
    );
  }

  ListView _buildListCart(List<String> listCart) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return Card(
          color: blackBlue,
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: ImagesItem(
                      urlImage: 'https://www.linkpicture.com/q/ocean.jpg'),
                ),
                Gaps.wGap15,
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Title(title: 'Chocolate latteee'),
                      const Price(price: '15'),
                      _buildQuantity(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuantity() {
    return Row(
      children: const [
        IconButton(
            onPressed: null, icon: Icon(Icons.add_circle, color: Colors.white)),
        Text('1', style: TextStyle(color: Colors.white)),
        IconButton(
            onPressed: null, icon: Icon(Icons.add_circle, color: Colors.white)),
      ],
    );
  }
}

class ImagesItem extends StatelessWidget {
  const ImagesItem({Key? key, required this.urlImage}) : super(key: key);

  final String urlImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      width: 110,
      child: CachedNetworkImage(
        imageUrl: urlImage,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class Price extends StatelessWidget {
  const Price({Key? key, required this.price}) : super(key: key);

  final String price;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          const TextSpan(
              text: r'$ ',
              style: TextStyle(color: orange, fontSize: textSize18)),
          TextSpan(
            text: price,
            style: const TextStyle(
                color: Colors.white,
                fontSize: textSize18,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 160,
          child: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, fontSize: textSize18),
          ),
        ),
        const IconButton(
          onPressed: null,
          icon: Icon(Icons.clear, color: Colors.white),
        ),
      ],
    );
  }
}

class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
      decoration: const BoxDecoration(
          color: blackBlue,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
      child: Column(
        children: [
          _buildPromo(context),
          Gaps.hGap10,
          _buildText('Sub Total', '16'),
          Gaps.hGap5,
          _buildText('Shipping', '2'),
          Gaps.hGap10,
          Utils.line,
          Gaps.hGap10,
          _buildText('TOTAL', '14'),
          Gaps.hGap10,
          _buildButtonPay(),
        ],
      ),
    );
  }

  Widget _buildButtonPay() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: null,
        child: const Text('Order', style: Utils.textStyle18),
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0))),
            backgroundColor: MaterialStateProperty.all(orange)),
      ),
    );
  }

  Widget _buildText(String title, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Utils.textStyle18),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                    text: r'$',
                    style: TextStyle(color: orange, fontSize: textSize18)),
                TextSpan(text: price, style: Utils.textStyle18),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPromo(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: Colors.white)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Promo Code', style: Utils.textStyle18),
          OutlinedButton(
            onPressed: () => _buildPromoDialog(context),
            child: const Text('Add', style: Utils.textStyle18),
            style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0))),
                padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 30.0)),
                backgroundColor: MaterialStateProperty.all(orange)),
          )
        ],
      ),
    );
  }

  Future _buildPromoDialog(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 1,
          child: ListView(
            children: [
              ListTile(
                title: const Text('1'),
                leading: CachedNetworkImage(
                  imageUrl: 'https://www.linkpicture.com/q/matcha2.jpg',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
