import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:template/app/ui/screens/profile/edit_profile.dart';
import 'package:template/app/ui/screens/profile/selectlanguage_screen.dart';
import 'package:template/app/ui/themes/colors.dart';
import 'package:template/app/ui/themes/font_size.dart';
import 'package:template/app/ui/widgets/common/button.dart';
import 'package:template/app/ui/widgets/common/text.dart';

import '../../widgets/profile/profileoptions_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 40),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      'https://scontent.fcjb6-1.fna.fbcdn.net/v/t39.30808-6/283513030_5045931862170024_6741242948610213084_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=MuYqjeOYrCAAX882dCC&_nc_ht=scontent.fcjb6-1.fna&oh=00_AfDe-xE9xiTxNaUAqfdnT4M65kJEAhqFDaoP2XwyGpeDSQ&oe=647B7C7C',
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 1.3,
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: Get.width,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.secondary,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: CommonText(
                      text: "Welcome, Naviin Ju Prasad",
                      style: boldText(
                        color: AppColors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  CommonText(
                    textAlign: TextAlign.start,
                    text: "Account Settings",
                    style: boldText(fontSize: 20, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  ProfileOptionsTile(
                    icon: Ionicons.pencil_outline,
                    text: "Edit Profile",
                    onTap: () {
                      Get.to(() => EditProfile());
                    },
                  ),
                  ProfileOptionsTile(
                    icon: Ionicons.location_outline,
                    text: "Saved Addresses",
                    onTap: () {},
                  ),
                  ProfileOptionsTile(
                    icon: Ionicons.card_outline,
                    text: "Payment Options",
                    onTap: () {},
                  ),
                  ProfileOptionsTile(
                    icon: Ionicons.language_outline,
                    text: "Select Language",
                    onTap: () {
                      Get.to(() => SelectLanguageScreen());
                    },
                  ),
                  ProfileOptionsTile(
                    icon: Ionicons.notifications_outline,
                    text: "Notification Settings",
                    onTap: () {},
                  ),
                  SizedBox(height: 20),
                  CommonText(
                    textAlign: TextAlign.start,
                    text: "Feedback & Information",
                    style: boldText(fontSize: 20, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  ProfileOptionsTile(
                    icon: Ionicons.document_text_outline,
                    text: "Terms, Policies and Licenses",
                    onTap: () {},
                  ),
                  ProfileOptionsTile(
                    icon: Ionicons.help_circle_outline,
                    text: "Contact us",
                    onTap: () {},
                  ),
                  SizedBox(height: 20),
                  Align(
                      alignment: Alignment.center,
                      child: CommonButton(text: "Log out", onTap: () {}))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
