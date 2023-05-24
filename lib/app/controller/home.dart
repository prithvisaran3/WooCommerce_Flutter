import 'package:get/get.dart';
import 'package:template/app/config/config.dart';
import 'package:template/app/controller/main.dart';

import '../data/repository/home.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.put(HomeController());

  final repository = HomeRepository();

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
