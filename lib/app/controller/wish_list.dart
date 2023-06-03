import 'package:get/get.dart';
import 'package:template/app/data/repository/wish_list.dart';

class WishListController extends GetxController {
  static WishListController get to => Get.put(WishListController());

  final repository = WishListRepository();

  var _isWishlistItem=false.obs;

  get isWishlistItem => _isWishlistItem.value;

  set isWishlistItem(value) {
    _isWishlistItem.value = value;
  }

  getWishList() async {
    try {
      var res = await repository.getWishList();
    } catch (e) {}
  }
}
