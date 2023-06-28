import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:steels/app/controller/order.dart';
import 'package:steels/app/controller/order.dart';
import 'package:steels/app/ui/widgets/common/toast.dart';

class RazorPaymentService {
  Razorpay razorPay = Razorpay();
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  initPaymentGateway() {
    razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, externalWallet);
    razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, paymentSuccess);
    razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, paymentError);
  }

  void externalWallet(ExternalWalletResponse response) {
    debugPrint("EXTERNAL: ${response.walletName}");
  }

  void paymentSuccess(PaymentSuccessResponse response) {
    debugPrint("SUCCESS: ${response.paymentId}");
    OrderController.to.createOrder(transactionId: response.paymentId);
  }

  void paymentError(PaymentFailureResponse response) {
    debugPrint("ERROR: ${response.message} - ${response.code}");
    Get.back();
    commonToast(msg: "Cancelled by user");
  }

  getPayment(BuildContext context, {amount, phone, email, name}) async{
    var key = "";
    await firebase.collection('payment_gateway').doc('razorpay').get().then(
      (value) {
        if (value['isLive'] == true) {
          key = value['live_key'];
        } else {
          key = value['test_key'];
        }
      },
    );
    print("Payment Key is ${key}");
    debugPrint(
        "Amount Details: Name: $name, Email: $email, Phone: $phone, Amount: $amount");
    var options = {
      'key': key,
      'amount': amount * 100,
      'description': 'Payment for our products',
      'prefill': {"contact": "$phone", "email": "$email"},
      'name': '$name'
    };

    try {
      razorPay.open(options);
    } catch (e) {
      debugPrint("Error from server on razorpay payment $e");
    }
  }
}
