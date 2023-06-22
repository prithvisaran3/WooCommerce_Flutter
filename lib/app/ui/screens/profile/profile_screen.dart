import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:steels/app/controller/auth.dart';
import 'package:steels/app/controller/order.dart';
import 'package:steels/app/ui/screens/auth/onboarding.dart';
import 'package:steels/app/ui/widgets/common/box_loading.dart';
import '../../../controller/profile.dart';
import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../../widgets/common/alert.dart';
import '../../widgets/common/button.dart';
import '../../widgets/common/loading.dart';
import '../../widgets/common/text.dart';
import '../../widgets/profile/profileoptions_tile.dart';
import 'selectlanguage_screen.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ProfileController.to.getProfile();
    return GetBuilder(
      init: ProfileController(),
      initState: (_) {
        ProfileController.to.getProfile();
      },
      builder: (_) {
        return SafeArea(
          child: Stack(
            children: [
              Container(
                height: Get.height,
                child: Stack(
                  children: [
                    Positioned(
                      top: 260,
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        // height: Get.height,
                        width: Get.width,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.primary,
                              AppColors.primary,
                              AppColors.primary,
                              AppColors.white,
                            ],
                          ),
                        ),
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Align(
                                  alignment: Alignment.center,
                                  child: Obx(
                                    () => CommonText(
                                      text: ProfileController
                                                  .to.profileDetails.username ==
                                              true
                                          ? "..."
                                          : "Welcome, ${ProfileController.to.profileDetails.username}",
                                      style: boldText(
                                        color: AppColors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  )),
                              const SizedBox(height: 25),
                              CommonText(
                                textAlign: TextAlign.start,
                                text: "Account Settings",
                                style:
                                    boldText(fontSize: 20, color: Colors.white),
                              ),
                              const SizedBox(height: 10),
                              ProfileOptionsTile(
                                icon: Ionicons.pencil_outline,
                                text: "Edit Profile",
                                onTap: () {
                                  Get.toNamed('/edit_profile');
                                },
                              ),

                              // ProfileOptionsTile(
                              //   icon: Ionicons.card_outline,
                              //   text: "Payment Options",
                              //   onTap: () {},
                              // ),
                              // ProfileOptionsTile(
                              //   icon: Ionicons.language_outline,
                              //   text: "Select Language",
                              //   onTap: () {
                              //     Get.to(() => const SelectLanguageScreen());
                              //   },
                              // ),
                              // ProfileOptionsTile(
                              //   icon: Ionicons.notifications_outline,
                              //   text: "Notification Settings",
                              //   onTap: () {},
                              // ),
                              const SizedBox(height: 20),
                              CommonText(
                                textAlign: TextAlign.start,
                                text: "Feedback & Information",
                                style:
                                    boldText(fontSize: 20, color: Colors.white),
                              ),
                              const SizedBox(height: 10),
                              ProfileOptionsTile(
                                icon: Ionicons.document_text_outline,
                                text: "Terms and Conditions",
                                onTap: () {
                                  OrderController.to.createOrder();
                                  // OrderController.to.deleteOrders(id:"8726");
                                },
                              ),
                              ProfileOptionsTile(
                                icon: Ionicons.document_lock_outline,
                                text: "Privacy Policy",
                                onTap: () {
                                  OrderController.to.createOrder();
                                  // OrderController.to.deleteOrders(id:"8726");
                                },
                              ),

                              ProfileOptionsTile(
                                icon: Ionicons.help_circle_outline,
                                text: "Contact Us",
                                onTap: () {},
                              ),
                              const SizedBox(height: 20),
                              Align(
                                alignment: Alignment.center,
                                child: CommonButton(
                                  text: "Log out",
                                  onTap: () {
                                    // AuthController.to.readIDfromFirebase(email: 'email');
                                    commonAlertDialog(
                                      context,
                                      content: 'Are you sure to logout?',
                                      confirmButtonPressed: () {
                                        Get.back();

                                        AuthController.to.logout();
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 180,
                            width: 180,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  spreadRadius: 1.3,
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(150),
                              child: Obx(
                                () => ProfileController.to.getProfileLoading ==
                                        true
                                    ? Center(child: SimpleLoading())
                                    : ProfileController
                                                .to.profileDetails.avatarUrl ==
                                            null
                                        ? Image.asset(
                                            'assets/images/no_profile.jpg')
                                        : Image.network(
                                            "${ProfileController.to.profileDetails.avatarUrl}",
                                            fit: BoxFit.cover,
                                          ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
              ),
              Obx(
                () => AuthController.to.logoutLoading == true
                    ? Center(
                        child: Container(
                          height: Get.height,
                          width: Get.width,
                          color: AppColors.grey.withOpacity(.3),
                          child: const SimpleBoxLoading(),
                        ),
                      )
                    : const SizedBox(),
              )
            ],
          ),
        );
      },
    );
  }
}
