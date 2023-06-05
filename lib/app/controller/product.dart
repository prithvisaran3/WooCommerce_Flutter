import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController get to => Get.put(ProductController());

  final _selectIndex = 0.obs;

  get selectIndex => _selectIndex.value;

  set selectIndex(value) {
    _selectIndex.value = value;
  }

  final _onPressedCheckPincode = false.obs;

  get onPressedCheckPincode => _onPressedCheckPincode.value;

  set onPressedCheckPincode(value) {
    _onPressedCheckPincode.value = value;
  }

  final _onPressedApplyCoupon = false.obs;

  get onPressedApplyCoupon => _onPressedApplyCoupon.value;

  set onPressedApplyCoupon(value) {
    _onPressedApplyCoupon.value = value;
  }

  final _isReadMore = false.obs;

  get isReadMore => _isReadMore.value;

  set isReadMore(value) {
    _isReadMore.value = value;
  }

  final _onPressedColors = 0.obs;

  get onPressedColors => _onPressedColors.value;

  set onPressedColors(value) {
    _onPressedColors.value = value;
  }
}
