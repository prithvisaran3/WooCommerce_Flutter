import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/repository/order.dart';
import '../ui/widgets/common/toast.dart';
import 'main.dart';

class OrderController extends GetxController {
  static OrderController get to => Get.put(OrderController());

  final repository = OrderRepository();

  final _getOrdersLoading = false.obs;

  get getOrdersLoading => _getOrdersLoading.value;

  set getOrdersLoading(value) {
    _getOrdersLoading.value = value;
  }

  final _ordersEmpty = false.obs;

  get ordersEmpty => _ordersEmpty.value;

  set ordersEmpty(value) {
    _ordersEmpty.value = value;
  }

  getOrders() async {
    getOrdersLoading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString('userId');
    var params = "&customer=$id";
    try {
      var res = await repository.getOrders(params: params);
      if (statusCode == 200) {
        getOrdersLoading = false;
        if (res.isNotEmpty) {
          ordersEmpty = false;
          debugPrint("orders get successfully with data");
        } else {
          ordersEmpty = true;
          debugPrint("orders get successfully but no data");
        }
      } else if (statusCode == 408) {
        getOrdersLoading = false;
        commonToast(msg: "Server Timeout");
        debugPrint("orders get failed");
      } else {
        getOrdersLoading = false;
        debugPrint("orders get failed");
      }
    } catch (e) {
      getOrdersLoading = false;
      if (statusCode == 408) {
        getOrdersLoading = false;
        commonToast(msg: "Server Timeout");
        debugPrint("orders get failed");
      } else {
        debugPrint("Error from server on get orders $e");
      }
    }
  }
}
