import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:steels/app/ui/widgets/common/button.dart';
import 'package:steels/app/ui/widgets/common/toast.dart';
import '../data/model/profile.dart';
import '../data/repository/profile.dart';
import 'main.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.put(ProfileController());

  final repository = ProfileRepository();

  //update
  final TextEditingController userName = TextEditingController();

  //billing
  final TextEditingController bFName = TextEditingController();
  final TextEditingController bLName = TextEditingController();
  final TextEditingController bCompany = TextEditingController();
  final TextEditingController bAddress1 = TextEditingController();
  final TextEditingController bAddress2 = TextEditingController();
  final TextEditingController bCity = TextEditingController();
  final TextEditingController bPostCode = TextEditingController();
  final TextEditingController bCountry = TextEditingController();
  final TextEditingController bState = TextEditingController();
  final TextEditingController bEmail = TextEditingController();
  final TextEditingController bPhone = TextEditingController();

  //shipping
  final TextEditingController sFName = TextEditingController();
  final TextEditingController sLName = TextEditingController();
  final TextEditingController sCompany = TextEditingController();
  final TextEditingController sAddress1 = TextEditingController();
  final TextEditingController sAddress2 = TextEditingController();
  final TextEditingController sCity = TextEditingController();
  final TextEditingController sPostCode = TextEditingController();
  final TextEditingController sCountry = TextEditingController();
  final TextEditingController sState = TextEditingController();
  final TextEditingController sPhone = TextEditingController();

  //key
  final addressKey = GlobalKey<FormState>();

  final _getProfileLoading = false.obs;

  get getProfileLoading => _getProfileLoading.value;

  set getProfileLoading(value) {
    _getProfileLoading.value = value;
  }

  final _profileDetails = ProfileRes().obs;

  get profileDetails => _profileDetails.value;

  set profileDetails(value) {
    _profileDetails.value = value;
  }

  final _billingAsSameShipping = false.obs;

  get billingAsSameShipping => _billingAsSameShipping.value;

  set billingAsSameShipping(value) {
    _billingAsSameShipping.value = value;
  }

  final _updateProfileLoading = false.obs;

  get updateProfileLoading => _updateProfileLoading.value;

  set updateProfileLoading(value) {
    _updateProfileLoading.value = value;
  }

  addressFieldsEmpty() {
    //Billing Fields
    bFName.text = "";
    bLName.text = "";
    bCompany.text = "";
    bAddress1.text = "";
    bAddress2.text = "";
    bCity.text = "";
    bPostCode.text = "";
    bCountry.text = "";
    bState.text = "";
    bPhone.text = "";

    //Shipping Fields
    sFName.text = "";
    sLName.text = "";
    sCompany.text = "";
    sAddress1.text = "";
    sAddress2.text = "";
    sCity.text = "";
    sPostCode.text = "";
    sCountry.text = "";
    sState.text = "";
    sPhone.text = "";
  }

  getProfile() async {
    getProfileLoading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString('userId');
    try {
      var res = await repository.getProfile(userId: id);
      if (statusCode == 200) {
        getProfileLoading = false;
        profileDetails = res;
        debugPrint("Profile get successfully");
        debugPrint("Profile Details is: ${res.billing.isBlank}");
      } else if (statusCode == 401) {
        getProfileLoading = false;
        debugPrint("Consumer and Secret Key Missing");
        commonToast(msg: "Consumer and Secret Key Missing");
      } else if (statusCode == 404) {
        getProfileLoading = false;
        debugPrint("Url No-found");
        commonToast(msg: "Url No-found");
      }
    } catch (e) {
      getProfileLoading = false;
      debugPrint("Error from server on get profile $e");
      commonToast(msg: "Url No-found or Server Error");
    }
  }

  updateProfile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString('userId');
    var body = {
      "username": userName.text == "" || userName.text.isEmpty
          ? "${profileDetails.username}"
          : userName.text,
      "billing": {
        "first_name": bFName.text,
        "last_name": bLName.text,
        "company": bCompany.text,
        "address_1": bAddress1.text,
        "address_2": bAddress2.text,
        "city": bCity.text,
        "state": bState.text,
        "postcode": bPostCode.text,
        "country": bCountry.text,
        "email": bEmail.text == "" || bEmail.text.isEmpty
            ? "${profileDetails.email}"
            : bEmail.text,
        "phone": bPhone.text
      },
      "shipping": {
        "first_name": billingAsSameShipping == true ? bFName.text : sFName.text,
        "last_name": billingAsSameShipping == true ? bLName.text : sLName.text,
        "company":
            billingAsSameShipping == true ? bCompany.text : sCompany.text,
        "address_1":
            billingAsSameShipping == true ? bAddress1.text : sAddress1.text,
        "address_2":
            billingAsSameShipping == true ? bAddress2.text : sAddress2.text,
        "city": billingAsSameShipping == true ? bCity.text : sCity.text,
        "state": billingAsSameShipping == true ? bState.text : sState.text,
        "postcode":
            billingAsSameShipping == true ? bPostCode.text : sPostCode.text,
        "country":
            billingAsSameShipping == true ? bCountry.text : sCountry.text,
        "phone": billingAsSameShipping == true ? bPhone.text : sPhone.text
      },
    };

    try {
      var res =
          await repository.updateProfile(userId: id, body: jsonEncode(body));
      if (statusCode == 200 || statusCode == 201) {
        updateProfileLoading = false;
        debugPrint("update profile completed");
        Get.back();
        commonToast(msg: "Address updated successfully");
        addressFieldsEmpty();
      } else {
        updateProfileLoading = false;
        debugPrint("update profile failed");
      }
    } catch (e) {
      updateProfileLoading = false;
      debugPrint("Error from server on update profile $e");
      commonToast(msg: "Url No-found or Server Error");
    }
  }
}
