import 'package:cakeapp/data/modals/cake.dart';

abstract class LocalData {
  Future<void> saveItemCart(List<CakeResponse>? item);

  Future<List<CakeResponse>?> get getAllCart;

  Future<void> savePhoneNumber(String? phone);

  Future<String?> get getPhoneNumber;
}
