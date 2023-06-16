import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/auth.dart';
import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../../widgets/auth/auth_button.dart';
import '../../widgets/auth/auth_textformfield.dart';
import '../../widgets/common/loading.dart';
import '../../widgets/common/text.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        alignment: Alignment.center,
        width: Get.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary,
              AppColors.secondary,
            ],
          ),
        ),
        child: Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(10),
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
                text: "Welcome Back!",
                style: headText(
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
                    child: CommonText(
                      text: "Forgot password?",
                      style: regularText(color: Colors.black),
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
                        style: regularText(color: AppColors.primary)),
                  )
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
