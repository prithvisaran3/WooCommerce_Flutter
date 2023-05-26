import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import 'text.dart';

updateAlertDialog(BuildContext context,
    {required String content, required Function() confirmButtonPressed}) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Container(
      height: 30,
      width: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.red),
      child: const Center(
        child: Text(
          "Cancel",
          style: TextStyle(color: AppColors.white),
        ),
      ),
    ),
    onPressed: () {
      if (kDebugMode) {
        print("print");
      }
      Get.back();
    },
  );
  Widget continueButton = TextButton(
    onPressed: confirmButtonPressed,
    child: Container(
      height: 30,
      width: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.green),
      child: const Center(
        child: Text(
          "Update",
          style: TextStyle(color: AppColors.white),
        ),
      ),
    ),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    alignment: Alignment.center,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(15.0),
      ),
    ),
    backgroundColor: Colors.grey.shade300,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [CommonText(text: "Update Available", style: mediumText())],
    ),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [CommonText(text: content, style: regularText())],
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
