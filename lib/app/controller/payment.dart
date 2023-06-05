import 'package:get/get.dart';

class PaymentController extends GetxController {
  static PaymentController get to => Get.put(PaymentController());

  final _onPressedPaymentMethod = 0.obs;

  get onPressedPaymentMethod => _onPressedPaymentMethod.value;

  set onPressedPaymentMethod(value) {
    _onPressedPaymentMethod.value = value;
  }
}
