import 'dart:convert';

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
    var params = "&customer=$id";
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

  createOrder() async {
    var body = {
      'payment_method': "razorpay",
      'payment_method_title': "Direct Bank Transfer",
      'set_paid': "false",
      'status': "processing",
      'customer_id': "32",
      'billing': {
        'first_name': "John",
        'last_name': "Doe",
        'company': "Test",
        'address_1': "969 Market",
        'address_2': "",
        'city': "San Francisco",
        'state': "CA",
        'postcode': "94103",
        'country': "US",
        'email': "john.doe@example.com",
        'phone': "(555) 555 - 5555"
      },
      'shipping': {
        'first_name': "John",
        'last_name': "Doe",
        'company': "Test",
        'address_1': "969 Market",
        'address_2': "",
        'city': "San Francisco",
        'state': "CA",
        'postcode': "94103",
        'country': "US",
      },
      'line_items': [
        {'product_id': "5205", 'quantity': "2"},
      ],
      'shipping_lines': [
        {
          'method_id': "flat_rate",
          'method_title': "Flat Rate",
          'total': "10.00"
        }
      ]
    };
    print("body is $body");
    try {
      var res = await repository.createOrder(body: jsonEncode(body));
      Future.delayed(Duration(seconds: 3), () {
        if (statusCode == 200 || statusCode == 201) {
          // commonToast(msg: "Create order successfully");
        } else if (statusCode == 408) {
          commonToast(msg: "Timeout");
        }
      });
    } catch (e) {
      debugPrint("Error from server on create order$e");
    }
  }

  deleteOrders({required id}) async {
    try {
      var res = await repository.deleteOrder(body: "", id: "$id");
      Future.delayed(const Duration(seconds: 3), () {
        if (statusCode == 200 || statusCode == 201) {
          print("order deleted successfully");
          // commonToast(msg: "Create order successfully");
        } else if (statusCode == 408) {
          commonToast(msg: "Timeout");
        } else if (statusCode == 404) {
          commonToast(msg: "${res['message']} or Already deleted");
        }
      });
    } catch (e) {
      debugPrint("Error from server on create order$e");
    }
  }
}
