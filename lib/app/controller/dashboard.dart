import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:steels/app/config/config.dart';
import 'package:steels/app/controller/main.dart';
import 'package:steels/app/controller/product.dart';
import 'package:steels/app/data/model/slider.dart';
import 'package:steels/app/ui/screens/errors/500.dart';

import '../data/model/order_by.dart';
import '../data/repository/home.dart';
import '../ui/screens/all_categories.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.put(HomeController());
  final repository = DashboardRepository();

  final ScrollController scrollController = ScrollController();
  final ScrollController allProductscrollController = ScrollController();

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

  final _crossSellProducts = <dynamic>[].obs;

  get crossSellProducts => _crossSellProducts.value;

  set crossSellProducts(value) {
    _crossSellProducts.value = value;
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

  order(SortBy sort) {
    orderBy = sort;
    update();
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

  final _pageNumber = 1.obs;

  get pageNumber => _pageNumber.value;

  set pageNumber(value) {
    _pageNumber.value = value;
  }

  final _orderBy = "".obs;

  get orderBy => _orderBy.value;

  set orderBy(value) {
    _orderBy.value = value;
  }

  final _params = "".obs;

  get params => _params.value;

  set params(value) {
    _params.value = value;
  }

  final _sort = "asc".obs;

  get sort => _sort.value;

  set sort(value) {
    _sort.value = value;
  }

  final _crossSellIds = <dynamic>[].obs;

  get crossSellIds => _crossSellIds.value;

  set crossSellIds(value) {
    _crossSellIds.value = value;
  }

  getProducts({categoryId, indexId}) async {
    var search = "";
    var tag = "";
    if (search.isNotEmpty) {
      params = "&search=$search";
    }
    if (crossSellIds.isNotEmpty) {
      params =
          "&per_page=$pageSize&page=$pageNumber&order=$sort&include=${crossSellIds.join(",").toString()}";
    } else {
      if (orderBy != "") {
        if (ProductController.to.productSearch.text != "") {
          params =
              "&per_page=$pageSize&page=$pageNumber&order=$sort&orderby=$orderBy&search=${ProductController.to.productSearch.text}";
        } else {
          params =
              "&per_page=$pageSize&page=$pageNumber&order=$sort&orderby=$orderBy";
        }
      } else if (ProductController.to.productSearch.text != "") {
        params =
            "&per_page=$pageSize&page=$pageNumber&order=$sort&search=${ProductController.to.productSearch.text}";
      } else {
        params = "&per_page=$pageSize&page=$pageNumber&order=$sort";
      }
    }
    if (tag.isNotEmpty) {
      params = "&tag=$tag";
    }
    if (categoryId != null) {
      params = "&category=$categoryId";
    }

    print("params is $params");
    productsLoading = true;
    try {
      // var res = await repository.getProducts(params: "&category=$categoryId");
      var res = await repository.getProducts(params: params);
      if (statusCode == 200) {
        productsLoading = false;
        ProductController.to.loadMore = false;
        if (res.isNotEmpty) {
          productsDetails = res;
          if (indexId != null || indexId != "") {
            print("index id is $indexId");
            // crossSellIds = res[indexId]['cross_sell_ids'];
            // crossSellProducts = res;
          }
          productsEmpty = false;
          ProductController.to.loadMore = false;

          debugPrint("products get successfully with data: $productsDetails");
        } else {
          productsEmpty = true;
          ProductController.to.loadMore = false;

          debugPrint("categories get successfully but no data");
        }
      } else if (statusCode == 500) {
        productsLoading = false;
        Get.to(() => const Error500());
      } else {
        productsLoading = false;
        ProductController.to.loadMore = false;
      }
    } catch (e) {
      productsLoading = false;
      ProductController.to.loadMore = false;
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
