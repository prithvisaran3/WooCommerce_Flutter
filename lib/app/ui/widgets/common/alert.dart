
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import 'text.dart';

commonAlertDialog(BuildContext context,
    {required String content, required Function() confirmButtonPressed}) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Container(
      height: 30,
      width: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: AppColors.grey),
      child: Center(
        child: CommonText(
          text: "Cancel",
          style: regularText(fontSize: 14, color: AppColors.black),
        ),
      ),
    ),
    onPressed: () {
      Get.back();
    },
  );
  Widget continueButton = TextButton(
    onPressed: confirmButtonPressed,
    child: Container(
      height: 30,
      width: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: AppColors.primary),
      child: Center(
        child: CommonText(
            text: "Confirm",
            style: mediumText(fontSize: 14, color: AppColors.white)),
      ),
    ),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(15.0),
      ),
    ),
    backgroundColor: Colors.grey.shade300,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
          size: 25,
        ),
        const SizedBox(
          width: 10,
        ),
        CommonText(
          text: "Alert",
          style: mediumText(),
        )
      ],
    ),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CommonText(
          text: content,
          style: regularText(),
        )
      ],
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
