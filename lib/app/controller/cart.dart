import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:steels/app/controller/dashboard.dart';
import 'package:steels/app/controller/main.dart';
import 'package:steels/app/controller/product.dart';
import 'package:steels/app/data/model/cart/req.dart';
import 'package:steels/app/controller/dashboard.dart';
import 'package:steels/app/controller/main.dart';
import 'package:steels/app/controller/product.dart';
import 'package:steels/app/data/model/cart/req.dart';
import 'package:steels/app/ui/widgets/common/common_snackbar.dart';
import 'package:steels/app/ui/widgets/common/toast.dart';

import '../data/repository/cart.dart';

class CartController extends GetxController {
  static CartController get to => Get.put(CartController());

  final repository = CartRepository();

  final _getCartLoading = false.obs;

  get getCartLoading => _getCartLoading.value;

  set getCartLoading(value) {
    _getCartLoading.value = value;
  }

  final _addToCartLoading = false.obs;

  get addToCartLoading => _addToCartLoading.value;

  set addToCartLoading(value) {
    _addToCartLoading.value = value;
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

  final _cartLength = 0.obs;

  get cartLength => _cartLength.value;

  set cartLength(value) {
    _cartLength.value = value;
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

  final _addCartDetails = <dynamic>[].obs;

  get addCartDetails => _addCartDetails.value;

  set addCartDetails(value) {
    _addCartDetails.value = value;
  }

  final _cartTotalAmount = 0.obs;

  get cartTotalAmount => _cartTotalAmount.value;

  set cartTotalAmount(value) {
    _cartTotalAmount.value = value;
  }

  final _showAmountCard = false.obs;

  get showAmountCard => _showAmountCard.value;

  set showAmountCard(value) {
    _showAmountCard.value = value;
  }

  final _quantityUpdateAmount = 0.obs;

  get quantityUpdateAmount => _quantityUpdateAmount.value;

  set quantityUpdateAmount(value) {
    _quantityUpdateAmount.value = value;
  }

  final _isMoveToCart = false.obs;

  get isMoveToCart => _isMoveToCart.value;

  set isMoveToCart(value) {
    _isMoveToCart.value = value;
  }

  final _removeCartLoading = false.obs;

  get removeCartLoading => _removeCartLoading.value;

  set removeCartLoading(value) {
    _removeCartLoading.value = value;
  }

  final _removeLoading = false.obs;

  get removeLoading => _removeLoading.value;

  set removeLoading(value) {
    _removeLoading.value = value;
  }

  addCart({productId, userId, qty}) async {
    addToCartLoading = true;
    // cartDetails.forEach((e) {
    //   addCartProducts
    //       .add({"product_id": e['product_id'], "quantity": e['qty']});
    // });
    // if (addCartProducts.isEmpty) {
    //   addCartProducts.add({"product_id": productId, "quantity": qty});
    // } else {
    //   var isProductExits = addCartProducts.firstWhere(
    //       (pro) => pro['product_id'] == productId,
    //       orElse: () => null);
    //   print("isProductExits $isProductExits");
    //   if (isProductExits != null) {
    //     addCartProducts.remove(isProductExits);
    //   } else {
    //     addCartProducts.add({"product_id": productId, "quantity": qty});
    //     // addCartProducts.add(cartDetails.forEach((e) {
    //     //   addCartProducts
    //     //       .add({"product_id": e['product_id'], "quantity": e['qty']});
    //     // }));
    //   }
    // }
    //
    // addCartMap.addAll({"user_id": userId, "products": addCartProducts});
    debugPrint("body is: $addCartMap");

    try {
      var res = await repository.addCart(body: jsonEncode(addCartMap));

      if (statusCode == 200) {
        addToCartLoading = false;

        if (res['status'] == 200) {
          isMoveToCart = true;
          addCartMap = {};

          if (res['data'].isNotEmpty) {
            // commonToast(msg: "Added to cart successfully");
            commonSnackBar(title: "Add to Cart", msg: "Successful");
            // cartDetails = [];
            cartDetails = res['data'];
            update();
          }
        } else if (res['status'] == 404) {
          // commonToast(msg: "Try again :(");
          commonSnackBar(title: "Add to Cart", msg: "Failed");

          isMoveToCart = false;
        }
      } else {
        addToCartLoading = false;

        print("404");
      }
    } catch (e) {
      addToCartLoading = false;

      debugPrint("Error from server on add cart $e");
    }
  }

  getCart() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString('userId');
    getCartLoading = true;
    try {
      var res = await repository.getCart(userId: "$id");
      if (statusCode == 200) {
        getCartLoading = false;
        if (res['status'] == 200) {
          if (res['data'].isNotEmpty) {
            cartEmpty = false;
            cartDetails = [];
            cartDetails = res['data'];
            showAmountCard = true;
            debugPrint("Cart get successfully with data ${res['data']}");
          } else {
            cartEmpty = true;
            showAmountCard = false;
            debugPrint("Cart get successfully but no data");
          }
        }
      } else if (statusCode == 408) {
        getCartLoading = false;
        commonToast(msg: "Timeout please refresh");
        debugPrint("Cart get failed");
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
      debugPrint("product qty: ${isProductExist['qty']}");
      if (isProductExist['qty'] == 0) {
        removeLoading = true;
        Future.delayed(const Duration(seconds: 3), () {
          removeLoading = false;
          removeItem(productId: productId, isZero: true);
        });
        debugPrint("Remove Quantity is 0");
      } else {
        debugPrint("Quantity is: ${isProductExist['qty']}");
      }
    }
    update();
  }

  removeItem({productId, isZero = false}) {
    if (isZero == true) {
      var isProductExits = cartDetails
          .firstWhere((e) => e['product_id'] == productId, orElse: () => null);
      if (isProductExits != null) {
        cartDetails.remove(isProductExits);
      }
      update();
    } else {
      removeLoading = true;
      Future.delayed(const Duration(seconds: 3), () {
        removeLoading = false;
        var isProductExits = cartDetails.firstWhere(
            (e) => e['product_id'] == productId,
            orElse: () => null);
        if (isProductExits != null) {
          cartDetails.remove(isProductExits);
        }
        update();
      });
    }
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
    if (addCartDetails.isNotEmpty) {
      cartDetails = [];
      cartDetails.addAll(addCartDetails);
      onCallback(addCartDetails);
      update();
    }
  }

  removeCart({carId}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString('userId');
    removeCartLoading = true;
    var body = {};
    try {
      var res = await repository.removeCart(
          userId: "$id", cartId: "$carId", body: body);
      if (statusCode == 200) {
        removeCartLoading = false;
        if (res['status'] == 200) {
          debugPrint("${res['message']}");
          commonToast(msg: "${res['message']}");
          getCart();
        } else if (res['status'] == 404) {
          commonToast(msg: "${res['message']}");
          debugPrint("${res['message']}");
        }
      } else if (statusCode == 408) {
        removeCartLoading = false;
        commonToast(msg: "Timeout");
      } else if (statusCode == 500) {
        removeCartLoading = false;
        commonToast(msg: "Server Error");
      }
    } catch (e) {
      removeCartLoading = false;
      debugPrint("Error from server on remove cart");
    }
  }

  emptyCartAfterOrder() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString('userId');
    var body = {};
    try {
      var res = await repository.emptyCart(userId: "$id", body: body);
      if (statusCode == 200) {
        if (res['status'] == 200) {
          debugPrint("${res['message']}");
          commonToast(msg: "${res['message']}");
          getCart();
        } else if (res['status'] == 404) {
          commonToast(msg: "${res['message']}");
          debugPrint("${res['message']}");
        }
      } else if (statusCode == 408) {
        commonToast(msg: "Timeout");
      } else if (statusCode == 500) {
        commonToast(msg: "Server Error");
      }
    } catch (e) {
      debugPrint("Error from server on empty cart");
    }
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
