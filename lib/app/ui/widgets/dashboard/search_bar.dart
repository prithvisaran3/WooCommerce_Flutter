import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:steels/app/controller/dashboard.dart';

import '../../screens/errors/500.dart';
import '../../screens/product/all_products.dart';
import '../../themes/colors.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HomeController.to.onPressedSearch = true;
        Get.to(() => AllProducts());
      },
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
                color: AppColors.grey.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 1),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.search_outlined,
              color: AppColors.primary,
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Get.to(() => Error500());
              },
              child: Icon(
                Ionicons.notifications_outline,
                color: AppColors.primary,
              ),
            ),
            SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}
