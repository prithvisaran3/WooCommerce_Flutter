import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:template/app/config/config.dart';
import 'package:template/app/controller/main.dart';
import 'package:template/app/data/model/slider.dart';

import '../data/repository/home.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.put(HomeController());
  final repository = DashboardRepository();
  final ScrollController scrollController = ScrollController();

  final _selectedIndex = 0.obs;

  get selectedIndex => _selectedIndex.value;

  set selectedIndex(value) {
    _selectedIndex.value = value;
  }

  final _banners = <String>[].obs;

  get banners => _banners.value;

  set banners(value) {
    _banners.value = value;
  }

  final _loading = false.obs;

  get loading => _loading.value;

  set loading(value) {
    _loading.value = value;
  }

  final _categoryDetails = <dynamic>[].obs;

  get categoryDetails => _categoryDetails.value;

  set categoryDetails(value) {
    _categoryDetails.value = value;
  }

  final _categoryLoading = false.obs;

  get categoryLoading => _categoryLoading.value;

  set categoryLoading(value) {
    _categoryLoading.value = value;
  }

  final _categoryEmpty = false.obs;

  get categoryEmpty => _categoryEmpty.value;

  set categoryEmpty(value) {
    _categoryEmpty.value = value;
  }

  final _productsLoading = false.obs;

  get productsLoading => _productsLoading.value;

  set productsLoading(value) {
    _productsLoading.value = value;
  }

  final _productsEmpty = false.obs;

  get productsEmpty => _productsEmpty.value;

  set productsEmpty(value) {
    _productsEmpty.value = value;
  }

  final _productsDetails = <dynamic>[].obs;

  get productsDetails => _productsDetails.value;

  set productsDetails(value) {
    _productsDetails.value = value;
  }

  final _topSellingLoading = false.obs;

  get topSellingLoading => _topSellingLoading.value;

  set topSellingLoading(value) {
    _topSellingLoading.value = value;
  }

  final _topSellingEmpty = false.obs;

  get topSellingEmpty => _topSellingEmpty.value;

  set topSellingEmpty(value) {
    _topSellingEmpty.value = value;
  }

  final _topSellingDetails = <dynamic>[].obs;

  get topSellingDetails => _topSellingDetails.value;

  set topSellingDetails(value) {
    _topSellingDetails.value = value;
  }

  getCategories({perPage}) async {
    categoryLoading = true;
    var params = "&page=2&per_page=$pageSize";
    try {
      var res = await repository.getCategories();
      if (statusCode == 200) {
        categoryLoading = false;
        if (res.isNotEmpty) {
          categoryDetails = res;
          categoryEmpty = false;
          debugPrint("categories get successfully with data: $categoryDetails");
        } else {
          categoryEmpty = true;
          debugPrint("categories get successfully but no data");
        }
      } else {
        categoryLoading = false;
      }
    } catch (e) {
      categoryLoading = false;
      debugPrint("Error from get categories on controller $e");
    }
  }

  final _pageSize = 10.obs;

  get pageSize => _pageSize.value;

  set pageSize(value) {
    _pageSize.value = value;
  }

  getProducts({categoryId}) async {
    var search = "";
    var pageNumber = "";
    var tag = "";
    var orderBy = "";
    var sort = "";
    var params =
        "&search=$search&per_page=$pageSize&page=$pageNumber&tag=$tag&category=$categoryId&orderby=$orderBy&order=$sort";
    productsLoading = true;
    try {
      // var res = await repository.getProducts(params: "&category=$categoryId");
      var res = await repository.getProducts();
      if (statusCode == 200) {
        productsLoading = false;
        if (res.isNotEmpty) {
          productsDetails = res;
          productsEmpty = false;
          debugPrint("products get successfully with data: $productsDetails");
        } else {
          productsEmpty = true;
          debugPrint("categories get successfully but no data");
        }
      } else {
        productsLoading = false;
      }
    } catch (e) {
      productsLoading = false;
      debugPrint("Error from get products on controller $e");
    }
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
    topSellingLoading = true;
    try {
      var res = await repository.getTopSellingProducts(
          tagId: AppConfig.topSellingProductTagId);
      if (statusCode == 200) {
        topSellingLoading = false;
        if (res.isNotEmpty) {
          topSellingDetails = res;
          topSellingEmpty = false;
          debugPrint(
              "topSelling products get successfully with data: $topSellingDetails");
        } else {
          topSellingEmpty = true;
          debugPrint("topSelling products get successfully but no data");
        }
      } else {
        topSellingLoading = false;
      }
    } catch (e) {
      topSellingLoading = false;
      debugPrint("Error from get topSelling products on controller $e");
    }
  }

  getDashboard() async {
    loading = true;
    try {
      var res = await repository.getDashboard();
      if (statusCode == 200) {
        if (res != null) {
          if (res['banner'] != null) {
            loading = false;
            banners.clear();
            var list = res['banner'];
            var model = list.map((e) => SliderModel.fromJson(e)).toList();
            for (var element in model) {
              banners.add(element.image);
            }
            print("banner get successfully $banners");
          } else {
            print("banner get successfully  bt no data ${res}");
          }
        }
      }
    } catch (e) {}
  }
}
