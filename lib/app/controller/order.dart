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

  final _orderDetails = <dynamic>[].obs;

  get orderDetails => _orderDetails.value;

  set orderDetails(value) {
    _orderDetails.value = value;
  }

  final _orderStatus = ''.obs;

  get orderStatus => _orderStatus.value;

  set orderStatus(value) {
    _orderStatus.value = value;
  }

  getOrders() async {
    getOrdersLoading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString('userId');
    print("Id is $id");
    var params = "&customer=36";
    try {
      var res = await repository.getOrders(params: params);
      if (statusCode == 200) {
        getOrdersLoading = false;
        if (res.isNotEmpty) {
          ordersEmpty = false;
          orderDetails = res;
          print("ORDER DETAILS : $orderDetails");
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
