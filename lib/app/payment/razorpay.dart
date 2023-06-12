import 'package:flutter/cupertino.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPaymentService {
  Razorpay _razorPay = Razorpay();

  initPaymentGateway() {
    _razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, externalwallet);
    _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS,  paymentSuccess);
    _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, paymentError);
  }

  void externalwallet(ExternalWalletResponse response) {
    print(response.walletName);
  }

  void paymentSuccess(PaymentSuccessResponse response) {
    print("SUCCESS: " + response.paymentId.toString());
  }

  void paymentError(PaymentFailureResponse response) {
    print("ERROR: ${response.message} - ${response.code}");
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
      _razorPay.open(options);
    } catch (e) {}
  }
}
