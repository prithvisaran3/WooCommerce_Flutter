import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

commonToast({required msg, Color? fontColor = Colors.white}) async {
  Fluttertoast.showToast(
      msg: "$msg",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.grey,
      textColor: fontColor,
      fontSize: 16.0);
}
