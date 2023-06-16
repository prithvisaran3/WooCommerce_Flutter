// ignore_for_file: prefer_conditional_assignment

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/repository/auth.dart';
import '../ui/widgets/common/app_update.dart';
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

  checkIsUpdateAvailable() async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetch();
    await remoteConfig.fetchAndActivate();
    final info = await PackageInfo.fromPlatform();

    // get local app version and change to int
    var lv = info.version;
    var split = lv.replaceAll(".", "");
    var localVersion = int.parse(split);
    debugPrint("local version $lv");
    debugPrint("convert local version $localVersion");

    // get remote app version and change to int
    var rv = remoteConfig.getString('version');
    print("rc is $rv");
    var rSplit = rv.replaceAll(".", "");
    var remoteVersion = int.parse(rSplit);
    debugPrint("remote version $rv");
    debugPrint("convert remote version $remoteVersion");

    if (localVersion > remoteVersion) {
      debugPrint("update available");
      if (Platform.isAndroid || Platform.isIOS) {
        final appId =
            Platform.isAndroid ? 'steels.woocommerce' : 'YOUR_IOS_APP_ID';
        final url = Uri.parse(
          Platform.isAndroid
              ? "https://play.google.com/store/apps/details?id=$appId"
              : "https://apps.apple.com/app/id$appId",
        );

        updateAlertDialog(Get.context!,
            content:
                "Fido app is update available\nWish you update please click update button\nOtherwise cancel or tap anywhere to close",
            confirmButtonPressed: () {
          launchUrl(
            url,
            mode: LaunchMode.externalApplication,
          );
        });
      }
    } else {
      debugPrint("update not available");
    }
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
            storeUserToFirebase(id: "${value['id']}");
            debugPrint("id is: ${value['id']}");
          });
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

  storeUserToFirebase({required id}) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc('${AuthController.to.fName.text}')
          .set({
        'id': '$id',
        'email': '${AuthController.to.email.text}',
        'name': "${AuthController.to.fName.text}",
      }, SetOptions(merge: true)).whenComplete(
              () => debugPrint("User store in firebase successful"));
    } catch (e) {
      debugPrint("FIREBASE USER STORE EXCEPTION \n $e");
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
