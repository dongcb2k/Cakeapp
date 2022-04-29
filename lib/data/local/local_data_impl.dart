import 'package:cakeapp/data/modals/cake.dart';
import 'package:cakeapp/domain/local/local_data.dart';
import 'package:cakeapp/main.dart';
import 'package:cakeapp/presentation/constants/const.dart';
import 'package:injectable/injectable.dart';
import 'package:sp_util/sp_util.dart';

@Singleton(as: LocalData)
class LocalDataImpl extends LocalData {
  @override
  Future<List<CakeResponse>?> get getAllCart async {
    final list = SpUtil.getObjList(
        KEY_CART, (v) => CakeResponse.fromJson(v as Map<String, dynamic>));
    return list;
  }

  @override
  Future<void> saveItemCart(List<CakeResponse>? item) async {
    if (item != null) {
      logger.d('LOCAL: ' + item.length.toString());
      await SpUtil.putObjectList(KEY_CART, item);
    } else {
      logger.d('SAVE LOCAL DATA FAIL');
    }
  }
}
