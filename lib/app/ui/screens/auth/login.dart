import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/auth.dart';
import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../../widgets/auth/auth_button.dart';
import '../../widgets/auth/auth_textformfield.dart';
import '../../widgets/common/loading.dart';
import '../../widgets/common/text.dart';
import 'forgot_password.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(0.9),
                // gradient: LinearGradient(
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                //   colors: [
                //     AppColors.primary,
                //     AppColors.primary,
                //     AppColors.white,
                //   ],
                // ),
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                padding: const EdgeInsets.all(10),
                width: Get.width,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      spreadRadius: 1,
                      blurRadius: 1,
                    )
                  ],
                  borderRadius: BorderRadius.circular(20),
                  // color: Color(0xFFdedff3),
                  color: Colors.white.withOpacity(1),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonText(
                      textAlign: TextAlign.start,
                      text: "Welcome Back!",
                      style: headText(
                        color: AppColors.primary,
                        fontSize: 24,
                        fontFamily: 'bold',
                      ),
                    ),
                    Form(
                      key: AuthController.to.loginKey,
                      child: Column(
                        children: [
                          AuthTextFormField(
                            hintText: "Enter your email ",
                            controller: AuthController.to.lEmail,
                            validator: (data) {
                              if (data == null || data == "") {
                                return "Please enter email";
                              }
                              return null;
                            },
                          ),
                          AuthTextFormField(
                            hintText: "Enter your password ",
                            controller: AuthController.to.lPassword,
                            obscureText: true,
                            validator: (data) {
                              if (data == null || data == "") {
                                return "Please enter password";
                              } else if (data.length < 8) {
                                return "Password must be 8 character";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => ForgotPassword());
                            },
                            child: CommonText(
                              text: "Forgot password?",
                              style:
                                  mediumText(fontSize: 13, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Obx(() => AuthController.to.loginLoading == true
                        ? const SimpleLoading()
                        : AuthButton(
                            text: "Sign In",
                            onTap: () {
                              if (AuthController.to.loginKey.currentState!
                                  .validate()) {
                                AuthController.to.login();
                              }
                            },
                          )),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonText(
                          text: "Don't have an account?",
                          style: regularText(),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/register');

                            AuthController.to.registerFieldsEmpty();
                          },
                          child: CommonText(
                              text: "Sign up",
                              style: mediumText(
                                  fontSize: 14, color: AppColors.primary)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Positioned(
            //   top: 40,
            //   right: 0,
            //   left: 0,
            //   child: Container(
            //     padding: EdgeInsets.all(15),
            //     margin: EdgeInsets.symmetric(horizontal: 10),
            //     width: Get.width,
            //     decoration: BoxDecoration(
            //       // color: Colors.white,
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //     child: Image.asset(
            //       'assets/images/new_logo_modified.png',
            //       width: Get.width,
            //       fit: BoxFit.fill,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
