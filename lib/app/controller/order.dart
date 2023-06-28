import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:steels/app/config/config.dart';
import 'package:steels/app/controller/cart.dart';
import '../data/repository/order.dart';
import '../ui/widgets/common/toast.dart';
import 'main.dart';
import 'payment.dart';
import 'package:http/http.dart' as http;

class OrderController extends GetxController {
  static OrderController get to => Get.put(OrderController());

  final TextEditingController orderSearch = TextEditingController();

  final repository = OrderRepository();

  final _getOrdersLoading = false.obs;

  get getOrdersLoading => _getOrdersLoading.value;

  set getOrdersLoading(value) {
    _getOrdersLoading.value = value;
  }

  final _deleteOrderLoading = false.obs;

  get deleteOrderLoading => _deleteOrderLoading.value;

  set deleteOrderLoading(value) {
    _deleteOrderLoading.value = value;
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

  final _sort = "asc".obs;

  get sort => _sort.value;

  set sort(value) {
    _sort.value = value;
  }

  var _params = "".obs;

  get params => _params.value;

  set params(value) {
    _params.value = value;
  }

  final _lineItems = [].obs;

  get lineItems => _lineItems.value;

  set lineItems(value) {
    _lineItems.value = value;
  }

  final _paymentTitle = "".obs;

  get paymentTitle => _paymentTitle.value;

  set paymentTitle(value) {
    _paymentTitle.value = value;
  }

  final _perPage = 10.obs;

  get perPage => _perPage.value;

  set perPage(value) {
    _perPage.value = value;
  }

  final _pageNumber = 1.obs;

  get pageNumber => _pageNumber.value;

  set pageNumber(value) {
    _pageNumber.value = value;
  }

  final _status = "".obs;

  get status => _status.value;

  set status(value) {
    _status.value = value;
  }

  final _showSearchBar = false.obs;

  get showSearchBar => _showSearchBar.value;

  set showSearchBar(value) {
    _showSearchBar.value = value;
  }

  getLineItems() {
    lineItems = [];
    CartController.to.cartDetails.forEach((e) {
      lineItems.add({
        'product_id': e['product_id'],
        'quantity': e['qty'],
        'variation_id': e['variation_id'],
      });
      update();
    });
    update();
    debugPrint("order items $lineItems");
  }

  Timer? debounce;

  sendMessageNotification(
      {required email, required body, required title}) async {
    var url = "https://fcm.googleapis.com/fcm/send";
    var token = "";
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(email)
          .get()
          .then((value) {
        token = value.data()!['fcmToken'];
        print("value is ${value.data()!['fcmToken']}");
      });

      http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=${AppConfig.fcmServerKey}',
        },
        body: jsonEncode(
          {
            'to': token,
            'notification': {
              'body': "$body",
              'title': "$title",
              "sound": "tone.mp3",
              "playSound": true
            },
            'priority': 'high',
            'data': {
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
          },
        ),
      );

      if (response.statusCode == 200) {
        print(
            "Push notification response body is: ${jsonDecode(response.body)}");
        var invalid = "${jsonDecode(response.body)['results'][0]['error']}";
        if (invalid == "InvalidRegistration") {
          print(
              "Push notification response body is: ${jsonDecode(response.body)['results'][0]['error']}");
        } else {
          print("send message to fcm notification successfully");
        }
      } else if (response.statusCode == 401) {
        print("Push notification response body is: ${response.body}");
        print(
            "Push notification response body is: INVALID SERVER KEY OR WRONG");
      }
    } catch (e) {
      print("Exception on sendMessageNotification\n$e");
    }
  }

  searchOrders() {
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      getOrders();
    });
  }

  getOrders() async {
    getOrdersLoading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString('userId');
    if (status == "") {
      if (orderSearch.text == "") {
        params = "&customer=$id&per_page=$perPage&page=$pageNumber";
      } else {
        params =
            "&customer=$id&per_page=$perPage&page=$pageNumber&search=${orderSearch.text}";
      }
    } else {
      if (orderSearch.text != "") {
        params =
            "&customer=$id&per_page=$perPage&page=$pageNumber&status=$status&search=${orderSearch.text}";
      } else {
        params =
            "&customer=$id&per_page=$perPage&page=$pageNumber&status=$status";
      }
    }
    try {
      var res = await repository.getOrders(params: params);
      if (statusCode == 200) {
        getOrdersLoading = false;
        if (res.isNotEmpty) {
          ordersEmpty = false;
          orderDetails = res;
          showSearchBar = true;
          print("ORDER DETAILS : $orderDetails");
          debugPrint("orders get successfully with data");
        } else {
          ordersEmpty = true;
          showSearchBar = false;
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

  methodTitle() {
    if (PaymentController.to.paymentMethod == "razorpay") {
      paymentTitle = "Razorpay";
    } else if (PaymentController.to.paymentMethod == "wallet") {
      paymentTitle = "Wallet";
    } else if (PaymentController.to.paymentMethod == "cheque") {
      paymentTitle = "Check Payments";
    } else if (PaymentController.to.paymentMethod == "bacs") {
      paymentTitle = "Direct Bank Transfer";
    } else {
      paymentTitle = "Cash on Delivery";
    }
  }

  createOrder({transactionId}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString('userId');
    getLineItems();
    methodTitle();
    var body = {
      'payment_method': "${PaymentController.to.paymentMethod}",
      'payment_method_title': "$paymentTitle",
      'set_paid': true,
      'status': "processing",
      'customer_id': "$id",
      'transaction_id': "$transactionId",
      'billing': {
        "first_name": PaymentController.to.bFName.text,
        "last_name": PaymentController.to.bLName.text,
        "company": PaymentController.to.bCompany.text,
        "address_1": PaymentController.to.bAddress1.text,
        "address_2": PaymentController.to.bAddress2.text,
        "city": PaymentController.to.bCity.text,
        "state": PaymentController.to.bState.text,
        "postcode": PaymentController.to.bPostCode.text,
        "country": PaymentController.to.bCountry.text,
        "email": PaymentController.to.bEmail.text,
        "phone": PaymentController.to.bPhone.text
      },
      'shipping': {
        "first_name": PaymentController.to.billingAsSameShipping == true
            ? PaymentController.to.bFName.text
            : PaymentController.to.sFName.text,
        "last_name": PaymentController.to.billingAsSameShipping == true
            ? PaymentController.to.bLName.text
            : PaymentController.to.sLName.text,
        "company": PaymentController.to.billingAsSameShipping == true
            ? PaymentController.to.bCompany.text
            : PaymentController.to.sCompany.text,
        "address_1": PaymentController.to.billingAsSameShipping == true
            ? PaymentController.to.bAddress1.text
            : PaymentController.to.sAddress1.text,
        "address_2": PaymentController.to.billingAsSameShipping == true
            ? PaymentController.to.bAddress2.text
            : PaymentController.to.sAddress2.text,
        "city": PaymentController.to.billingAsSameShipping == true
            ? PaymentController.to.bCity.text
            : PaymentController.to.sCity.text,
        "state": PaymentController.to.billingAsSameShipping == true
            ? PaymentController.to.bState.text
            : PaymentController.to.sState.text,
        "postcode": PaymentController.to.billingAsSameShipping == true
            ? PaymentController.to.bPostCode.text
            : PaymentController.to.sPostCode.text,
        "country": PaymentController.to.billingAsSameShipping == true
            ? PaymentController.to.bCountry.text
            : PaymentController.to.sCountry.text,
      },
      'line_items': lineItems,
      //shipping line has been 3 type and dynamic but temporarily manual
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
      Future.delayed(const Duration(seconds: 3), () {
        if (statusCode == 200 || statusCode == 201) {
          commonToast(msg: "Create order successfully");
          sendMessageNotification(
              email: PaymentController.to.bEmail.text,
              body: "Order ID: ${res['id']}\nStatus:${res['status']}",
              title: "Order created successfully");
          PaymentController.to.selectIndex = 2;
          CartController.to.emptyCartAfterOrder();
          Future.delayed(const Duration(seconds: 2), () {
            Get.back();
          });
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
      deleteOrderLoading = true;
      var res = await repository.deleteOrder(body: "", id: "$id");
      Future.delayed(const Duration(seconds: 3), () {
        if (statusCode == 200 || statusCode == 201) {
          deleteOrderLoading = false;

          print("order deleted successfully");
          commonToast(msg: "Order deleted successfully");
          getOrders();
        } else if (statusCode == 408) {
          deleteOrderLoading = false;

          commonToast(msg: "Timeout");
        } else if (statusCode == 404) {
          deleteOrderLoading = false;

          commonToast(msg: "${res['message']} or already deleted");
        }
      });
    } catch (e) {
      deleteOrderLoading = false;

      debugPrint("Error from server on create order$e");
    }
  }
}
