import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/payment.dart';
import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../../widgets/common/text.dart';
import '../../widgets/payment/payment_details.dart';
import '../../widgets/payment/payment_method.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: PaymentController(),
        initState: (_) {
          PaymentController.to.onPressedPaymentMethod = 0;
        },
        builder: (_) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                // toolbarHeight: 55,
                elevation: 0,

                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.primary,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                centerTitle: true,
                title: CommonText(
                  text: "Payment method",
                  style: boldText(
                    color: AppColors.primary,
                    fontSize: 18,
                  ),
                ),
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
                child: Column(
                  children: [
                    ListView.builder(
                      itemCount: 2,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, int index) {
                        return PaymentMethodTile(
                          text: index == 0 ? "Razorpay" : "Paytm",
                          onTap: () {
                            PaymentController.to.onPressedPaymentMethod = index;
                          },
                          index: index,
                        );
                      },
                    ),
                    Spacer(),
                    PaymentDetailsBox(),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
