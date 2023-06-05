import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dashboard.dart';

class ProductController extends GetxController {
  static ProductController get to => Get.put(ProductController());

  final ScrollController scrollController = ScrollController();

  final TextEditingController productSearch = TextEditingController();
  Timer? debounce;

  final _selectIndex = 0.obs;

  get selectIndex => _selectIndex.value;

  set selectIndex(value) {
    _selectIndex.value = value;
  }

  final _loadMore = false.obs;

  get loadMore => _loadMore.value;

  set loadMore(value) {
    _loadMore.value = value;
  }

  final _imageIndicator = 0.obs;

  get imageIndicator => _imageIndicator.value;

  set imageIndicator(value) {
    _imageIndicator.value = value;
  }

  final _shortDescription = false.obs;

  get shortDescription => _shortDescription.value;

  set shortDescription(value) {
    _shortDescription.value = value;
  }

  loadMoreFunction() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadMore = true;
        HomeController.to.getProducts();
        HomeController.to.pageNumber = ++HomeController.to.pageNumber;
      }
    });
  }

  searchProduct() {
    if (debounce?.isActive ?? false) debounce?.cancel();

    debounce = Timer(const Duration(milliseconds: 500), () {
      HomeController.to.getProducts();
    });
  }
}
