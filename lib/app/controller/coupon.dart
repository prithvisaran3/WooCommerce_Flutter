import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:template/app/data/repository/coupon.dart';

import 'main.dart';

class CouponController extends GetxController {
  static CouponController get to => Get.put(CouponController());

  final repository = CouponRepository();

  final TextEditingController couponCode = TextEditingController();

  final _onPressedCouponCode = 100.obs;

  get onPressedCouponCode => _onPressedCouponCode.value;

  set onPressedCouponCode(value) {
    _onPressedCouponCode.value = value;
  }

  final _selectedCouponCode = {}.obs;

  get selectedCouponCode => _selectedCouponCode.value;

  set selectedCouponCode(value) {
    _selectedCouponCode.value = value;
  }

  final _couponLoading = false.obs;

  get couponLoading => _couponLoading.value;

  set couponLoading(value) {
    _couponLoading.value = value;
  }

  final _allCouponDetails = <dynamic>[].obs;

  get allCouponDetails => _allCouponDetails.value;

  set allCouponDetails(value) {
    _allCouponDetails.value = value;
  }

  final _couponByIDdetails = {}.obs;

  get couponByIDdetails => _couponByIDdetails.value;

  set couponByIDdetails(value) {
    _couponByIDdetails.value = value;
  }

  final _couponAppliedAmount = "".obs;

  get couponAppliedAmount => _couponAppliedAmount.value;

  set couponAppliedAmount(value) {
    _couponAppliedAmount.value = value;
  }

  final _afterCouponPrice = "".obs;

  get afterCouponPrice => _afterCouponPrice.value;

  set afterCouponPrice(value) {
    _afterCouponPrice.value = value;
  }

  final _couponPercentage = "".obs;

  get couponPercentage => _couponPercentage.value;

  set couponPercentage(value) {
    _couponPercentage.value = value;
  }

  final _isCouponApplied = false.obs;

  get isCouponApplied => _isCouponApplied.value;

  set isCouponApplied(value) {
    _isCouponApplied.value = value;
  }

  final _isCouponEmpty = false.obs;

  get isCouponEmpty => _isCouponEmpty.value;

  set isCouponEmpty(value) {
    _isCouponEmpty.value = value;
  }

  var _couponMatch = 200.obs;

  get couponMatch => _couponMatch.value;

  set couponMatch(value) {
    _couponMatch.value = value;
  }

  getAllCoupons() async {
    couponLoading = true;
    try {
      var res = await repository.getAllCoupons();
      Future.delayed(Duration(seconds: 3), () {
        if (statusCode == 200 || statusCode == 201) {
          if (res.isNotEmpty) {
            couponLoading = false;
            isCouponEmpty = false;
            couponMatch++;

            print("All coupons got successfully with data");
            allCouponDetails = res;
          } else {
            couponLoading = false;
            isCouponEmpty = true;

            print("All coupons got successfully without data");
          }
        } else {
          couponLoading = false;

          print("ALL COUPONS not received ");
        }
      });
    } catch (e) {
      couponLoading = false;

      print("ALL COUPONS Exception\n$e");
    }
  }

  getCouponByID({required id}) async {
    couponLoading = true;
    try {
      var res = await repository.getCouponByID(id: id);
      Future.delayed(Duration(seconds: 3), () {
        if (statusCode == 200 || statusCode == 201) {
          if (res != null) {
            couponLoading = false;
            print("Coupon by ID got successfully with data");
            couponByIDdetails = res;
            isCouponApplied = true;
            couponMatch++;
          } else {
            couponLoading = false;

            print("Coupon by ID got successfully without data");
          }
        } else {
          couponLoading = false;

          print("COUPON BY ID not received ");
        }
      });
    } catch (e) {
      couponLoading = false;

      print("COUPON BY ID Exception\n$e");
    }
  }
}
