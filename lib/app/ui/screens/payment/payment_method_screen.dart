import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/app/controller/payment.dart';
import 'package:template/app/ui/themes/font_size.dart';
import 'package:template/app/ui/widgets/common/common_rupee_text.dart';
import 'package:template/app/ui/widgets/common/text.dart';

import '../../themes/colors.dart';
import '../../widgets/payment/paymentmethod_tile.dart';
import '../../widgets/payment/paymentdetails_box.dart';

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
                  icon: Icon(
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
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Column(
                  children: [
                    ListView.builder(
                      itemCount: 4,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, int index) {
                        return PaymentMethodTile(
                          text: 'Credit/Debit Card',
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
