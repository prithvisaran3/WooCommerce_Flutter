import 'package:get/get.dart';

class MyOrderController extends GetxController {
  static MyOrderController get to => Get.put(MyOrderController());

  final _orderStatus = ''.obs;

  get orderStatus => _orderStatus.value;

  set orderStatus(value) {
    _orderStatus.value = value;
  }
}
