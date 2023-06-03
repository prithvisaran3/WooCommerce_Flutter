import 'package:get/get.dart';

var statusCode = 0;

class MainController extends GetxController {
  static MainController get to => Get.put(MainController());

  final _isSelectLanguage=100.obs;

  get isSelectLanguage => _isSelectLanguage.value;

  set isSelectLanguage(value) {
    _isSelectLanguage.value = value;
  }
}
