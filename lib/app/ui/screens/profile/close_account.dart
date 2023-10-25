import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steels/app/ui/themes/colors.dart';
import 'package:steels/app/ui/themes/font_size.dart';
import 'package:steels/app/ui/widgets/common/button.dart';
import 'package:steels/app/ui/widgets/common/common_snackbar.dart';
import 'package:steels/app/ui/widgets/common/text.dart';

class CloseAccountScreen extends StatelessWidget {
  const CloseAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CommonText(
                textAlign: TextAlign.center,
                text: "Do you want to close your account?",
                style: boldText(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.back();
                commonSnackBar(title: "Your request is successfully submitted");
                // Get.back();
              },
              child: Container(
                height: 45,
                alignment: Alignment.center,
                width: Get.width / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: AppColors.white,
                  // gradient: const LinearGradient(
                  //   begin: Alignment.centerLeft,
                  //   end: Alignment.centerRight,
                  //   tileMode: TileMode.mirror,
                  //   colors: [AppColors.primary, AppColors.secondary],
                  // ),
                ),
                child: Text(
                  "Yes",
                  textAlign: TextAlign.center,
                  style: boldText(fontSize: 16, color: AppColors.primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
