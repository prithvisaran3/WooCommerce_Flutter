import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController get to => Get.put(ProductController());

  final _selectIndex = 0.obs;

  get selectIndex => _selectIndex.value;

  set selectIndex(value) {
    _selectIndex.value = value;
  }
}
