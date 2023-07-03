import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:steels/app/ui/themes/colors.dart';

commonToast({required msg, Color? fontColor = Colors.white}) async {
  Fluttertoast.showToast(
      msg: "$msg",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: AppColors.grey,
      textColor: fontColor,
      fontSize: 16.0);
}
