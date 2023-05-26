import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/app/ui/screens/home/dashboard.dart';
import '../../../controller/auth.dart';
import '../../../controller/dashboard.dart';
import '../../themes/colors.dart';

class HomeMain extends StatelessWidget {
  HomeMain({Key? key}) : super(key: key);
  final List<Widget> pages = [
    Dashboard(),
    Dashboard(),
    Dashboard(),
    Dashboard(),
    Dashboard(),
  ];

  @override
  Widget build(BuildContext context) {
    Future<bool> onWillPop() async {
      // This dialog will exit your app on saying yes
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              title: const Center(
                  child: Text(
                'Are you sure?',
                style: TextStyle(fontFamily: 'medium'),
              )),
              content: const Text('Do you want to exit an App'),
              contentTextStyle:
                  const TextStyle(fontFamily: 'medium', color: AppColors.grey),
              titleTextStyle: const TextStyle(
                  fontFamily: 'medium', color: AppColors.primary, fontSize: 16),
              actions: [
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  color: AppColors.grey,
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text(
                    'No',
                    style:
                        TextStyle(color: AppColors.white, fontFamily: 'medium'),
                  ),
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  color: AppColors.primary,
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text(
                    'Yes',
                    style: TextStyle(
                        color: AppColors.white,
                        fontFamily: 'medium',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          )) ??
          false;
    }

    return SafeArea(
      child: WillPopScope(
        onWillPop: onWillPop,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.grey.shade50,
            bottomNavigationBar: Container(
              margin: const EdgeInsets.all(15.0),
              height: 60,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary]),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildIcon(
                      index: 0,
                      icon: Icons.home_outlined,
                      onTap: () {
                        DashboardController.to.selectedIndex = 0;
                      }),
                  buildIcon(
                      index: 1,
                      icon: Icons.local_fire_department_outlined,
                      onTap: () {
                        DashboardController.to.selectedIndex = 1;
                      }),
                  buildIcon(
                      index: 2,
                      icon: Icons.shopping_cart_outlined,
                      onTap: () {
                        DashboardController.to.selectedIndex = 2;
                      }),
                  buildIcon(
                      index: 3,
                      icon: Icons.heart_broken,
                      onTap: () {
                        DashboardController.to.selectedIndex = 3;
                      }),
                  buildIcon(
                      index: 4,
                      icon: Icons.person_outline,
                      onTap: () {
                        DashboardController.to.selectedIndex = 4;
                      }),
                ],
              ),
            ),
            body: Obx(() => pages[DashboardController.to.selectedIndex]),
          ),
        ),
      ),
    );
  }

  Obx buildIcon({required index, required Function() onTap, required icon}) {
    return Obx(() => GestureDetector(
          onTap: AuthController.to.logoutLoading == true ? null : onTap,
          child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: DashboardController.to.selectedIndex == index
                      ? AppColors.white
                      : Colors.transparent),
              child: Icon(
                icon,
                color: DashboardController.to.selectedIndex == index
                    ? AppColors.primary
                    : AppColors.white,
              )),
        ));
  }
}
