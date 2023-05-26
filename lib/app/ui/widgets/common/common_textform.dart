import 'package:flutter/material.dart';
import '../../themes/colors.dart';

class CommonTextFormField extends StatefulWidget {
  const CommonTextFormField(
      {Key? key,
      required this.hintText,
      required this.controller,
      this.validator,
      this.obscureText,
      this.maxLength,
      this.errorText})
      : super(key: key);
  final String hintText;
  final String? errorText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final int? maxLength;

  @override
  State<CommonTextFormField> createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        style: const TextStyle(
          fontFamily: "medium",
          fontSize: 14,
        ),
        validator: widget.validator,
        cursorColor: AppColors.primary,
        controller: widget.controller,
        maxLength: widget.maxLength,
        maxLines: 1,
        obscuringCharacter: "*",
        obscureText: widget.obscureText == true ? !passwordVisible : false,
        decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            hintText: widget.hintText,
            errorText: widget.errorText,
            hintStyle: const TextStyle(
              fontFamily: "medium",
              color: AppColors.grey,
            ),
            counterText: "",
            contentPadding: const EdgeInsets.only(left: 15),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: AppColors.grey.withOpacity(.3), width: 2),
              borderRadius: BorderRadius.circular(8.0),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.primary,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.grey.withOpacity(.3), width: 2),
                borderRadius: BorderRadius.circular(8.0)),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.red, width: 1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            suffixIcon: showPassword()),
      ),
    );
  }

  bool passwordVisible = false;

  Widget showPassword() {
    if (widget.obscureText == true) {
      return ButtonTheme(
          child: TextButton(
              style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
              onPressed: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              },
              child: Icon(
                passwordVisible == true
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: AppColors.grey.withOpacity(.3),
              )));
    } else {
      return const SizedBox.shrink();
    }
  }
}
