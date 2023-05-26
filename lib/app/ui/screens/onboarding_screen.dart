import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/app/ui/screens/home/homemain.dart';
import 'package:template/app/ui/screens/login_screen.dart';
import 'package:template/app/ui/themes/colors.dart';
import 'package:template/app/ui/widgets/common/button.dart';


class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xFFedf0ed),
                Color(0xFFedf0ed),
                Color(0xFFf5f8f5),
                Color(0xFFccdaea),
                Color(0xFF1553c8),
                Color(0xFF192453),
                Color(0xFF27131e),
                Color(0xFF251019),
                Colors.black,
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CommonButton(
                    text: "LOGIN SCREEN",
                    onTap: () {
                      Get.to(() => LoginScreen());
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
