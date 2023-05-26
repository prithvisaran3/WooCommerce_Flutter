import 'package:flutter/cupertino.dart';
import '../../themes/colors.dart';
import '../../themes/font_size.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({Key? key, required this.text, required this.onTap})
      : super(key: key);
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        alignment: Alignment.center,
        width: media.width / 2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: AppColors.white,
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                AppColors.primary,
                AppColors.secondary,
                AppColors.background,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.grey,
                spreadRadius: 0,
                blurRadius: 5,
              )
            ]),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: boldText(fontSize: 16, color: AppColors.black),
        ),
      ),
    );
  }
}
