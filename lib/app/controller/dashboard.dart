import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:template/app/config/config.dart';
import 'package:template/app/controller/main.dart';

import '../data/repository/home.dart';

class DashboardController extends GetxController {
  static DashboardController get to => Get.put(DashboardController());

  final _selectedIndex = 0.obs;

  get selectedIndex => _selectedIndex.value;

  set selectedIndex(value) {
    _selectedIndex.value = value;
  }
  static List<String> slideImagesURL=[

  ];

  final repository = DashboardRepository();

  getCategories() async {
    try {
      var res = await repository.getCategories();
      if (statusCode == 200) {
        print("controller categories is ${res[0]['id']}");
      }
    } catch (e) {}
  }

  getProducts() async {
    try {
      var res = await repository.getProducts();
      if (statusCode == 200) {
        print("controller products is ${res[0]['id']}");
      }
    } catch (e) {}
  }

  getTodayOfferProducts() async {
    try {
      var res = await repository.getTodayOffersProducts(
          tagId: AppConfig.todayOffersProductTagId);
      if (statusCode == 200) {
        print("controller products is ${res[0]['id']}");
      }
    } catch (e) {}
  }

  getTopSellingProducts() async {
    try {
      var res = await repository.getTopSellingProducts(
          tagId: AppConfig.topSellingProductTagId);
      if (statusCode == 200) {
        print("controller products is ${res[0]['id']}");
      }
    } catch (e) {}
  }
}
