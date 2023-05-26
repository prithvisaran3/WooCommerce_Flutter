import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/app/controller/auth.dart';
import 'package:template/app/ui/screens/home/homemain.dart';
import 'package:template/app/ui/themes/colors.dart';
import 'package:template/app/ui/themes/font_size.dart';
import 'package:template/app/ui/widgets/auth/auth_button.dart';
import 'package:template/app/ui/widgets/auth/auth_textformfield.dart';
import 'package:template/app/ui/widgets/common/button.dart';
import 'package:template/app/ui/widgets/common/common_textform.dart';
import 'package:template/app/ui/widgets/common/text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                gradient:
                LinearGradient(
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
                padding: EdgeInsets.all(10),
                height: Get.height * 0.39,
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
                      text: "Welcome Back!",
                      style: headText(
                        fontSize: 24,
                        fontFamily: 'bold',
                      ),
                    ),
                    AuthTextFormField(
                      hintText: "Enter your email ",
                      controller: AuthController.to.lEmail,
                    ),
                    AuthTextFormField(
                      hintText: "Enter your password ",
                      controller: AuthController.to.lPassword,
                    ),
                    SizedBox(height: 20),
                    AuthButton(
                      text: "Sign In",
                      onTap: () {
                        Get.to(()=>HomeMain());
                      },
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
