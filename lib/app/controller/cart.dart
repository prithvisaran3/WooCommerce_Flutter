import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/app/controller/dashboard.dart';
import 'package:template/app/controller/main.dart';
import 'package:template/app/controller/product.dart';
import 'package:template/app/data/model/cart/req.dart';

import '../data/repository/cart.dart';

class CartController extends GetxController {
  static CartController get to => Get.put(CartController());

  final repository = CartRepository();

  final _getCartLoading = false.obs;

  get getCartLoading => _getCartLoading.value;

  set getCartLoading(value) {
    _getCartLoading.value = value;
  }

  final _cartEmpty = false.obs;

  get cartEmpty => _cartEmpty.value;

  set cartEmpty(value) {
    _cartEmpty.value = value;
  }

  final _cartDetails = <dynamic>[].obs;

  get cartDetails => _cartDetails.value;

  set cartDetails(value) {
    _cartDetails.value = value;
  }

  final _addCartMap = {}.obs;

  get addCartMap => _addCartMap.value;

  set addCartMap(value) {
    _addCartMap.value = value;
  }

  final _addCartProducts = [].obs;

  get addCartProducts => _addCartProducts.value;

  set addCartProducts(value) {
    _addCartProducts.value = value;
  }

  final _addProductMap = {}.obs;

  get addProductMap => _addProductMap.value;

  set addProductMap(value) {
    _addProductMap.value = value;
  }

  addCart({productId, userId, qty}) async {
    // cartDetails.forEach((e) {
    //   addCartProducts
    //       .add({"product_id": e['product_id'], "quantity": e['qty']});
    // });

    if (addCartProducts.isEmpty) {
      addCartProducts.add({"product_id": productId, "quantity": qty});
    } else {
      var isProductExits = addCartProducts.firstWhere(
          (pro) => pro['product_id'] == productId,
          orElse: () => null);
      print("isProductExits $isProductExits");
      if (isProductExits != null) {
        addCartProducts.remove(isProductExits);
      } else {
        addCartProducts.add({"product_id": productId, "quantity": qty});
        // addCartProducts.add(cartDetails.forEach((e) {
        //   addCartProducts
        //       .add({"product_id": e['product_id'], "quantity": e['qty']});
        // }));
      }
    }

    addCartMap.addAll({"user_id": userId, "products": addCartProducts});
    debugPrint("$addCartMap");

    try {
      var res = await repository.addCart(body: jsonEncode(addCartMap));

      if (statusCode == 200) {
        if (res['status'] == 200) {
          if (res['data'].isNotEmpty) {
            // cartDetails = [];
            cartDetails.addAll(res['data']);
            update();
          }
        } else if (res['status'] == 404) {}
      } else {
        print("404");
      }
    } catch (e) {
      debugPrint("Error from server on add cart $e");
    }
  }

  getCart() async {
    getCartLoading = true;
    try {
      var res = await repository.getCart(userId: "26");
      if (statusCode == 200) {
        getCartLoading = false;
        if (res['status'] == 200) {
          if (res['data'].isNotEmpty || res['data'] != null) {
            cartEmpty = false;
            cartDetails = [];
            cartDetails = res['data'];
            debugPrint("Cart get successfully with data ${res['data']}");
          } else {
            cartEmpty = true;
            debugPrint("Cart get successfully but no data");
          }
        }
      } else {
        getCartLoading = false;
        debugPrint("Cart get failed");
      }
    } catch (e) {
      getCartLoading = false;
      debugPrint("Error from server on get cart $e");
    }
  }

  updateQty({required productId, required qty}) {
    var isProductExist = cartDetails
        .firstWhere((e) => e['product_id'] == productId, orElse: () => null);
    debugPrint("product exits $isProductExist");
    if (isProductExist != null) {
      isProductExist['qty'] = qty;
      update();
      print("product qty: ${isProductExist['qty']}");
    }
    update();
  }

  updateCart(Function onCallback) async {
    if (cartDetails == null) {
      refresh();
    }

    cartDetails.forEach((e) {
      HomeController.to.productsDetails
          .add(CartProducts(productId: e['product_id'], quantity: e['qty']));
    });
    await addCart();
    // if (addCartDetails.isNotEmpty) {
    //   cartDetails = [];
    //   cartDetails.addAll(addCartDetails);
    //   onCallback(addCartRes);
    //   update();
    // }
  }
}

class CartProducts {
  int productId;
  int quantity;

  CartProducts({
    required this.productId,
    required this.quantity,
  });

  factory CartProducts.fromMap(Map<String, dynamic> json) => CartProducts(
        productId: json["product_id"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "product_id": productId,
        "quantity": quantity,
      };
}
