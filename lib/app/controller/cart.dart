import 'package:get/get.dart';

import '../data/repository/cart.dart';

class CartController extends GetxController {
  static CartController get to => Get.put(CartController());

  final repository = CartRepository();

  addCart() async {
    var body = {};
    try {
      var res = await repository.addCart(body: body);
    } catch (e) {}
  }

  getCart() async {
    var body = {};
    try {
      var res = await repository.getCart(userId: "26");
    } catch (e) {}
  }


}
