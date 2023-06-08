import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../../widgets/common/text.dart';

class Error500 extends StatelessWidget {
  const Error500({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary.withOpacity(.4),
        body: Stack(
          children: [
            Positioned(
              right: 15,
              top: 15,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.white),
                  child: const Icon(
                    Icons.close,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: ListView(
                children: [
                  CommonText(
                      text: "500",
                      style: boldText(fontSize: 50, color: AppColors.white)),
                  CommonText(
                      text: "Something is wrong",
                      style: mediumText(fontSize: 25, color: AppColors.white)),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonText(
                      text: "We are having an issue, please try again later",
                      style: mediumText(fontSize: 15, color: AppColors.grey)),
                  Image.asset('assets/images/500.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
