
import 'package:cakeapp/data/modals/cake.dart';

abstract class LocalData {
  Future<void> saveItemCart(List<CakeResponse>? item);

  Future<List<CakeResponse>?> get getAllCart;
}
