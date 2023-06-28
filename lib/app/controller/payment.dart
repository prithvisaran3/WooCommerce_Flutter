import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/repository/payment_gateway.dart';
import 'profile.dart';

class PaymentController extends GetxController {
  static PaymentController get to => Get.put(PaymentController());

  final repository = PaymentGatewayRepository();

  final _onPressedPaymentMethod = 0.obs;

  get onPressedPaymentMethod => _onPressedPaymentMethod.value;

  set onPressedPaymentMethod(value) {
    _onPressedPaymentMethod.value = value;
  }

  final _selectIndex = 0.obs;

  get selectIndex => _selectIndex.value;

  set selectIndex(value) {
    _selectIndex.value = value;
  }

  final _billingAsSameShipping = true.obs;

  get billingAsSameShipping => _billingAsSameShipping.value;

  set billingAsSameShipping(value) {
    _billingAsSameShipping.value = value;
  }

  final _billingAddressEmpty = false.obs;

  get billingAddressEmpty => _billingAddressEmpty.value;

  set billingAddressEmpty(value) {
    _billingAddressEmpty.value = value;
  }

  final _paymentGatewayDetails = <dynamic>[].obs;

  get paymentGatewayDetails => _paymentGatewayDetails.value;

  set paymentGatewayDetails(value) {
    _paymentGatewayDetails.value = value;
  }

  final _paymentMethod = "razorpay".obs;

  get paymentMethod => _paymentMethod.value;

  set paymentMethod(value) {
    _paymentMethod.value = value;
  }

  final _checkOrderPlaced=false.obs;

  get checkOrderPlaced => _checkOrderPlaced.value;

  set checkOrderPlaced(value) {
    _checkOrderPlaced.value = value;
  }

  final _billingAddressLoading = true.obs;

  get billingAddressLoading => _billingAddressLoading.value;

  set billingAddressLoading(value) {
    _billingAddressLoading.value = value;
  } //billing
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

  final addressKey = GlobalKey<FormState>();

  setData() {
    //billing data
    bFName.text = ProfileController.to.profileDetails.billing.firstName != ""
        ? ProfileController.to.profileDetails.billing.firstName
        : "";
    bLName.text = ProfileController.to.profileDetails.billing.lastName != ""
        ? ProfileController.to.profileDetails.billing.lastName
        : "";
    bAddress1.text = ProfileController.to.profileDetails.billing.address1 != ""
        ? ProfileController.to.profileDetails.billing.address1
        : "";
    bAddress2.text = ProfileController.to.profileDetails.billing.address2 != ""
        ? ProfileController.to.profileDetails.billing.address2
        : "";
    bCity.text = ProfileController.to.profileDetails.billing.city != ""
        ? ProfileController.to.profileDetails.billing.city
        : "";
    bPostCode.text = ProfileController.to.profileDetails.billing.postcode != ""
        ? ProfileController.to.profileDetails.billing.postcode
        : "";
    bCountry.text = ProfileController.to.profileDetails.billing.country != ""
        ? ProfileController.to.profileDetails.billing.country
        : "";
    bState.text = ProfileController.to.profileDetails.billing.state != ""
        ? ProfileController.to.profileDetails.billing.state
        : "";
    bEmail.text = ProfileController.to.profileDetails.billing.email != ""
        ? ProfileController.to.profileDetails.billing.email
        : "";
    bPhone.text = ProfileController.to.profileDetails.billing.phone != ""
        ? ProfileController.to.profileDetails.billing.phone
        : "";
  }

  checkBillingAddressEmpty() {
    if (ProfileController.to.profileDetails.billing.firstName == "" &&
        ProfileController.to.profileDetails.billing.lastName == "" &&
        ProfileController.to.profileDetails.billing.address1 == "" &&
        ProfileController.to.profileDetails.billing.address2 == "" &&
        ProfileController.to.profileDetails.billing.city == "" &&
        ProfileController.to.profileDetails.billing.country == "" &&
        ProfileController.to.profileDetails.billing.state == "" &&
        ProfileController.to.profileDetails.billing.email == "" &&
        ProfileController.to.profileDetails.billing.phone == "") {
      billingAddressEmpty = true;
      // commonToast(
      //     msg:
      //         "Your profile don't have saved billing address\nPlease fill the address");
    } else {
      billingAddressEmpty = false;
    }
  }

  getPaymentGateways() async {
    try {
      var res = await repository.getPaymentGateways();
      if (res.isNotEmpty) {
        paymentGatewayDetails = res;
      } else {}
    } catch (e) {
      debugPrint("Error from server on get payment gateways $e");
    }
  }
}
