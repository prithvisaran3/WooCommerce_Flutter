import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:template/app/controller/main.dart';
import 'package:template/app/ui/themes/colors.dart';
import 'package:template/app/ui/themes/font_size.dart';
import 'package:template/app/ui/widgets/common/text.dart';

import '../../widgets/profile/select_language/language_tile.dart';

class SelectLanguageScreen extends StatelessWidget {
  const SelectLanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 5),
                  Icon(
                    Ionicons.arrow_back,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 10),
                  CommonText(
                    text: "Select Language",
                    style: boldText(
                      fontSize: 20,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            CommonText(
              text: "Currently Selected Language",
              style: boldText(
                fontSize: 18,
                color: AppColors.primary,
              ),
            ),
            SelectLanguageTile(
              language: 'English',
              onTap: () {},
            ),
            SizedBox(height: 30),
            CommonText(
              text: "Available Languages",
              style: boldText(
                fontSize: 18,
                color: AppColors.primary,
              ),
            ),
            ListView.builder(
              itemCount: 4,
              shrinkWrap: true,
              itemBuilder: (context, int index) {
                return SelectLanguageTile(
                  index: index,
                  language: 'Tamil',
                  onTap: () {
                    MainController.to.isSelectLanguage=index;
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
