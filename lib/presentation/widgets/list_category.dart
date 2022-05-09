import 'package:cakeapp/presentation/screen/shop/bloc/shop_bloc.dart';
import 'package:cakeapp/presentation/screen/shop/bloc/shop_event.dart';
import 'package:cakeapp/presentation/screen/shop/bloc/shop_state.dart';
import 'package:cakeapp/presentation/widgets/common_button.dart';
import 'package:cakeapp/presentation/widgets/image_from_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/gaps.dart';

class ListCategory extends StatefulWidget {
  const ListCategory({
    Key? key,
    required this.shopBloc,
  }) : super(key: key);

  final ShopBloc shopBloc;

  @override
  _ListCategoryState createState() => _ListCategoryState();
}

class _ListCategoryState extends State<ListCategory> {
  @override
  void initState() {
    super.initState();
    widget.shopBloc.add(GetCategoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: BlocBuilder<ShopBloc, ShopState>(
        bloc: widget.shopBloc,
        buildWhen: (p, c) => p.listCategory != c.listCategory,
        builder: (context, state) => Row(
          children: [
            CommonButton(
              widthPadding: 15.0,
              heightPadding: 2.0,
              icon: const ImageFromUrl(
                height: 20,
                width: 20,
                urlImage: 'https://www.linkpicture.com/q/checked_1.png',
              ),
              label: const Text('All'),
              onPressed: () => widget.shopBloc.add(GetShopEvent()),
            ),
            Gaps.wGap15,
            buildListView(state),
          ],
        ),
      ),
    );
  }

  Widget buildListView(ShopState state) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: state.listCategory.length,
      itemBuilder: (context, index) {
        final _data = state.listCategory[index];

        return Row(
          children: [
            CommonButton(
              widthPadding: 15.0,
              heightPadding: 2.0,
              icon: ImageFromUrl(
                height: 20,
                width: 20,
                urlImage: _data.icon,
              ),
              label: Text(_data.category.toUpperCase()),
              onPressed: () =>
                  widget.shopBloc.add(FilterDataEvent(_data.category)),
            ),
            Gaps.wGap15,
          ],
        );
      },
    );
  }
}
