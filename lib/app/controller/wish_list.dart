import 'package:get/get.dart';
import 'package:template/app/data/repository/wish_list.dart';

class WishListController extends GetxController {
  static WishListController get to => Get.put(WishListController());

  final repository = WishListRepository();

  getWishList() async {
    try {
      var res = await repository.getWishList();
    } catch (e) {}
  }
}
