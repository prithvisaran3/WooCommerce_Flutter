// ignore_for_file: prefer_conditional_assignment

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/repository/auth.dart';
import '../ui/widgets/common/toast.dart';
import 'main.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.put(AuthController());
  final repository = AuthRepository();

  final loginKey = GlobalKey<FormState>();
  final registerKey = GlobalKey<FormState>();

  dynamic loginDetails;

  //login
  final TextEditingController lEmail = TextEditingController();
  final TextEditingController lPassword = TextEditingController();

  //register
  final TextEditingController fName = TextEditingController();
  final TextEditingController uName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  final _loginLoading = false.obs;

  get loginLoading => _loginLoading.value;

  set loginLoading(value) {
    _loginLoading.value = value;
  }

  final _logoutLoading = false.obs;

  get logoutLoading => _logoutLoading.value;

  set logoutLoading(value) {
    _logoutLoading.value = value;
  }

  final _registerLoading = false.obs;

  get registerLoading => _registerLoading.value;

  set registerLoading(value) {
    _registerLoading.value = value;
  }

  storeLocalDevice({required Map body}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    body.forEach((key, value) {
      debugPrint('index=$key, value=$value');
      preferences.setString(key, value);
    });
  }

  loginCheck() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token');
    debugPrint("token $token");
    if (token != null && token.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  registerFieldsEmpty() {
    fName.text = "";
    uName.text = "";
    email.text = "";
    password.text = "";
  }

  register() async {
    registerLoading = true;
    var body = {
      "first_name": fName.text.trimRight(),
      "username": uName.text.trimRight(),
      "email": email.text.trimRight(),
      "password": password.text,
      "last_name": "",
    };
    try {
      var res = repository.register(body: body);
      Future.delayed(const Duration(seconds: 5), () {
        if (statusCode == 200 || statusCode == 201) {
          registerLoading = false;
          res.then((value) {
            Map storedData = {
              "userId": "${value['id']}",
            };
            storeLocalDevice(body: storedData);
            debugPrint("id is: ${value['id']}");
          });
          registerFieldsEmpty();
          Get.back();
          commonToast(msg: "Register Successfully");
        } else if (statusCode == 400) {
          registerLoading = false;
          res.then((value) {
            if (value['code'] == "customer_invalid_email") {
              debugPrint("invalid email");
              commonToast(msg: "Invalid Email Address");
            } else if (value['code'] == "registration-error-email-exists") {
              debugPrint("already exits");
              commonToast(msg: "An email is already registered");
            }
          });
          debugPrint("error is $res");
        } else if (statusCode == 403) {
          registerLoading = false;
          res.then((value) {
            if (value['code'] == "[jwt_auth] incorrect_password") {
              debugPrint("login failed incorrect password");
              commonToast(msg: "Wrong Password");
            } else if (value['code'] == "[jwt_auth] invalid_email") {
              debugPrint("login failed incorrect mail");
              commonToast(msg: "Wrong Email");
            } else if (value['code'] == "[jwt_auth] empty_username") {
              debugPrint("login failed username empty");
              commonToast(msg: "Username Empty");
            } else if (value['code'] == "[jwt_auth] empty_password") {
              debugPrint("login failed password empty");
              commonToast(msg: "Password Empty");
            }
          });
        } else if (statusCode == 404) {
          registerLoading = false;
          res.then((value) {
            if (value['code'] == "rest_no_route") {
              debugPrint("Url Not-found");
              commonToast(msg: "Url Not-found, Check url");
            }
          });
        } else if (statusCode == 408) {
          registerLoading = false;
          commonToast(msg: "Sever Timeout");
        } else if (statusCode == 500) {
          registerLoading = false;
          commonToast(msg: "Sever Down");
        }
      });
    } catch (e) {
      registerLoading = false;
      debugPrint("Error from server on register $e");
      commonToast(msg: "Sever down please try again later");
    }
  }

  login() async {
    loginLoading = true;
    var body = {
      "username": lEmail.text.trimRight(),
      "password": lPassword.text,
    };
    try {
      var res = repository.login(body: body);
      Future.delayed(const Duration(seconds: 3), () {
        if (statusCode == 200) {
          loginLoading = false;
          commonToast(msg: "Login Successfully");
          res.then((value) {
            loginDetails = value;
            Map storedData = {
              "token": "${value['token']}",
              "email": "${value['user_email']}",
              "name": "${value['user_display_name']}",
            };
            storeLocalDevice(body: storedData);
            debugPrint("email is: ${loginDetails['user_email']}");
            debugPrint("token is: ${loginDetails['token']}");
          });
          Get.offNamed('/homeMain');
        } else if (statusCode == 400) {
          loginLoading = false;
          debugPrint("error is $res");
        } else if (statusCode == 403) {
          loginLoading = false;
          res.then((value) {
            if (value['code'] == "[jwt_auth] incorrect_password") {
              debugPrint("login failed incorrect password");
              commonToast(msg: "Wrong Password");
            } else if (value['code'] == "[jwt_auth] invalid_email") {
              debugPrint("login failed incorrect mail");
              commonToast(msg: "Wrong Email");
            } else if (value['code'] == "[jwt_auth] empty_username") {
              debugPrint("login failed username empty");
              commonToast(msg: "Username Empty");
            } else if (value['code'] == "[jwt_auth] empty_password") {
              debugPrint("login failed password empty");
              commonToast(msg: "Password Empty");
            }
          });
        } else if (statusCode == 404) {
          loginLoading = false;
          res.then((value) {
            if (value['code'] == "rest_no_route") {
              debugPrint("Url Not-found");
              commonToast(msg: "Url Not-found, Check url");
            }
          });
        } else if (statusCode == 408) {
          loginLoading = false;
          commonToast(msg: "Sever Timeout");
        } else if (statusCode == 500) {
          loginLoading = false;
          commonToast(msg: "Sever Down");
        }
      });
    } catch (e) {
      loginLoading = false;
      debugPrint("Error from server on login $e");
      commonToast(msg: "Sever down please try again later");
    }
  }
}
