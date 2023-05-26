import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.put(HomeController());

  final _selectedIndex = 0.obs;

  get selectedIndex => _selectedIndex.value;

  set selectedIndex(value) {
    _selectedIndex.value = value;
  }
}
