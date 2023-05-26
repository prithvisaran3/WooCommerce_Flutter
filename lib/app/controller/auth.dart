// ignore_for_file: prefer_conditional_assignment

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/app/controller/main.dart';
import '../data/repository/auth.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.put(AuthController());
  final repository = AuthRepository();

  dynamic loginDetails;


  final TextEditingController lEmail=TextEditingController();
  final TextEditingController lPassword=TextEditingController();


  var _loginLoading = false.obs;

  get loginLoading => _loginLoading.value;

  set loginLoading(value) {
    _loginLoading.value = value;
  }

  final _logoutLoading = false.obs;

  get logoutLoading => _logoutLoading.value;

  set logoutLoading(value) {
    _logoutLoading.value = value;
  }

  register() async {
    var body = {
      "email": "test@gmail.com",
      "first_name": "test",
      "last_name": "1",
      "username": "TestUser",
      "password": "12345678",
    };
    try {
      var res = repository.register(body: body);
      if (statusCode == 201) {
        debugPrint("$res");
      } else if (statusCode == 400) {
        debugPrint("error is $res");
      }
    } catch (e) {}
  }

  login() async {
    var body = {
      "username": "test@gmail.com",
      "password": "12345678",
    };
    try {
      var res = repository.login(body: body);

      if (statusCode == 200) {
        res.then((value) {
          if (loginDetails == null) {
            loginDetails = value;
          }
          print("email is: ${loginDetails['user_email']}");
        });
      } else if (statusCode == 400) {
        debugPrint("error is $res");
      }
    } catch (e) {}
  }
}
