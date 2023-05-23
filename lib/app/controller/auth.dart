import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/app/controller/main.dart';

import '../data/repository/auth.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.put(AuthController());
  final repository = AuthRepository();

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
}
