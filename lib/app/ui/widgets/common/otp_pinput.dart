import 'package:flutter/material.dart';
import '../../themes/colors.dart';

class OtpInput extends StatelessWidget {
  const OtpInput({Key? key, required this.autoFocus, required this.controller})
      : super(key: key);
  final bool autoFocus;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 45,
      child: TextField(
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        style: const TextStyle(
            color: AppColors.secondary, fontWeight: FontWeight.bold),
        cursorColor: AppColors.primary,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: AppColors.secondary)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: AppColors.primary)),
            counterText: '',
            hintStyle: const TextStyle(
                color: Colors.black, fontSize: 20.0, fontFamily: "medium")),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}
