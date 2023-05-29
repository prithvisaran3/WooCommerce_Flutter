import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/app/ui/screens/auth/login_screen.dart';

import '../../../controller/auth.dart';
import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../../widgets/auth/auth_button.dart';
import '../../widgets/auth/auth_textformfield.dart';
import '../../widgets/common/text.dart';
import '../home/homemain.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xFFedf0ed),
                    Color(0xFFccdaea),
                    Color(0xFF928ef7),
                    Color(0xFF4e49f0),
                    Color(0xFF192453),
                    Colors.black,
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                // alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                height: Get.height * 0.6,
                width: Get.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  // color: Color(0xFFdedff3),
                  color: Colors.white.withOpacity(1),
                ),
                child: Column(
                  children: [
                    CommonText(
                      textAlign: TextAlign.start,
                      text: "Create an account",
                      style: headText(
                        fontSize: 24,
                        fontFamily: 'bold',
                      ),
                    ),
                    AuthTextFormField(
                      hintText: "Name ",
                      controller: AuthController.to.lEmail,
                    ),
                    AuthTextFormField(
                      hintText: "Mobile number ",
                      controller: AuthController.to.lEmail,
                    ),
                    AuthTextFormField(
                      hintText: "Email ",
                      controller: AuthController.to.lEmail,
                    ),
                    AuthTextFormField(
                      hintText: "Password ",
                      controller: AuthController.to.lPassword,
                    ),
                    AuthTextFormField(
                      hintText: "Confirm Password ",
                      controller: AuthController.to.lEmail,
                    ),
                    SizedBox(height: 20),
                    AuthButton(
                      text: "Sign Up",
                      onTap: () {
                        Get.to(() => LoginScreen());
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonText(
                          text: "Already have an account?",
                          style: regularText(),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => SignupScreen());
                          },
                          child: CommonText(
                            text: " Log in",
                            style: regularText(
                              color: AppColors.primary,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
