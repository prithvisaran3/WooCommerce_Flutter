import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steels/app/controller/main.dart';
import 'package:steels/app/ui/themes/colors.dart';
import 'package:steels/app/ui/themes/font_size.dart';
import 'package:steels/app/ui/widgets/common/text.dart';

class SelectLanguageTile extends StatelessWidget {
  const SelectLanguageTile(
      {Key? key, required this.language, required this.onTap, this.index})
      : super(key: key);
  final String language;
  final Function() onTap;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Obx(
        () => Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            gradient: MainController.to.isSelectLanguage == index
                ? LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.secondary,
                    ],
                  )
                : null,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primary,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonText(
                text: language,
                style: MainController.to.isSelectLanguage == index
                    ? boldText(
                        fontSize: 16,
                        color: Colors.white,
                      )
                    : mediumText(
                        fontSize: 16,
                        color: AppColors.primary,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
