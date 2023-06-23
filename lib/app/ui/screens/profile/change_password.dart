import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:steels/app/ui/widgets/auth/auth_button.dart';

import '../../../controller/auth.dart';
import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../../widgets/auth/auth_textformfield.dart';
import '../../widgets/common/text.dart';

class CHangePasswordScreen extends StatelessWidget {
  const CHangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController.to.isForgotPasswordNote = false;
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          width: Get.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primary,
                AppColors.secondary,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 10),
                    Icon(
                      Icons.arrow_back_ios,
                      size: 30,
                      color: AppColors.white,
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(20),
                width: Get.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  // color: Color(0xFFdedff3),
                  color: Colors.white.withOpacity(1),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonText(
                      textAlign: TextAlign.start,
                      text: "Change Password",
                      style: headText(
                        fontSize: 24,
                        fontFamily: 'bold',
                      ),
                    ),
                    SizedBox(height: 20),
                    AuthTextFormField(
                      hintText: "Enter your email ",
                      controller: AuthController.to.forgotEmail,
                      validator: (data) {
                        if (data == null || data == "") {
                          return "Please enter email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    AuthButton(
                      text: "Send reset link",
                      onTap: () {
                        AuthController.to.forgotPassword();
                      },
                    ),
                    SizedBox(height: 20),
                    Obx(
                      () => AuthController.to.isForgotPasswordNote == true
                          ? CommonText(
                              text:
                                  "Note : If email not found in inbox\nCheck Spam :)",
                              style: regularText(),
                            )
                          : SizedBox(),
                    ),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
