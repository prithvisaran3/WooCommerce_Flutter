import 'package:flutter/cupertino.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:template/app/controller/order.dart';

class RazorPaymentService {
  Razorpay razorPay = Razorpay();

  initPaymentGateway() {
    razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, externalWallet);
    razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, paymentSuccess);
    razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, paymentError);
  }

  void externalWallet(ExternalWalletResponse response) {
    debugPrint(response.walletName);
  }

  void paymentSuccess(PaymentSuccessResponse response) {
    debugPrint("SUCCESS: ${response.paymentId}");
    OrderController.to.createOrder(transactionId: response.paymentId);
  }

  void paymentError(PaymentFailureResponse response) {
    debugPrint("ERROR: ${response.message} - ${response.code}");
  }

  getPayment(BuildContext context) {
    // var cartItems= getCartItems
    var options = {
      'key': 'rzp_test_jgECJhGI2uXCm8',
      'amount': 50 * 100,
      'description': 'Payment for our products',
      'prefill': {"contact": "9095023456", "email": "limitless360@"},
      'name': 'Raman'
    };

    try {
      razorPay.open(options);
    } catch (e) {
      debugPrint("Error from server on razorpay payment $e");
    }
  }
}
