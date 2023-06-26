import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steels/app/ui/widgets/common/button.dart';
import '../../../controller/auth.dart';
import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../../widgets/auth/auth_button.dart';
import '../../widgets/auth/auth_textformfield.dart';
import '../../widgets/common/loading.dart';
import '../../widgets/common/text.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

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
                  text: "Create an account",
                  style: headText(
                    fontSize: 24,
                    fontFamily: 'bold',
                  ),
                ),
                Form(
                    key: AuthController.to.registerKey,
                    child: Column(
                      children: [
                        AuthTextFormField(
                          hintText: "First Name",
                          controller: AuthController.to.fName,
                          validator: (data) {
                            if (data == null || data == "") {
                              return "Please enter name";
                            }
                            return null;
                          },
                        ),
                        AuthTextFormField(
                          hintText: "User Name",
                          controller: AuthController.to.uName,
                          validator: (data) {
                            if (data == null || data == "") {
                              return "Please enter mobile";
                            }
                            return null;
                          },
                        ),
                        AuthTextFormField(
                          hintText: "Email",
                          controller: AuthController.to.email,
                          validator: (data) {
                            if (data == null || data == "") {
                              return "Please enter email";
                            }
                            return null;
                          },
                        ),
                        AuthTextFormField(
                          hintText: "Password",
                          controller: AuthController.to.password,
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
                    )),
                const SizedBox(height: 20),
                Obx(
                  () => AuthController.to.registerLoading == true
                      ?  SimpleLoading()
                      : AuthButton(
                          text: "Sign Up",
                          onTap: () {
                            if (AuthController.to.registerKey.currentState!
                                .validate()) {
                              AuthController.to.register();
                            }
                          },
                        ),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonText(
                      text: "Already have an account?",
                      style: regularText(),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: CommonText(
                        text: "Log in",
                        style: mediumText(
                          fontSize: 14,
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
      ),
    );
  }
}
