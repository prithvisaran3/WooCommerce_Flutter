import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/auth.dart';
import 'auth/login.dart';
import 'home/main.dart';

class Initial extends StatefulWidget {
  const Initial({Key? key}) : super(key: key);

  @override
  State<Initial> createState() => _InitialState();
}

class _InitialState extends State<Initial> {
  String? isLogin;

  @override
  Widget build(BuildContext context) {
    debugPrint('initial auth test');
    return Scaffold(
      body: GetBuilder<AuthController>(
          init: AuthController(),
          initState: (state) async {
            AuthController.to.checkIsUpdateAvailable();
            bool login = await AuthController.to.loginCheck();
            debugPrint("is Login: $login");
            // bool onBoarding = await AuthController.to.checkOnBoarding();
            // debugPrint("onBoarding value $onBoarding");
            //   if (onBoarding == true) {
            //     setState(() {
            //       isLogin = 'onBoarding';
            //     });
            //   } else if (login == true) {
            //     setState(() {
            //       isLogin = "isLogin";
            //     });
            //   } else {
            //     debugPrint("logged in $isLogin");
            //   }
            // },

            if (login == true) {
              setState(() {
                isLogin = "isLogin";
              });
            }
          },
          builder: (controller) =>
              isLogin == "isLogin" ? HomeMain() : const Login()),
    );
  }
}
