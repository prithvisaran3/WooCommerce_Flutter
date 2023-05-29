import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../themes/colors.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 40,
      // width: Get.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.search_outlined,
            color: AppColors.primary,
          ),
          Spacer(),
          Icon(
            Ionicons.heart_outline,
            color: AppColors.secondary,
          ),
          SizedBox(width: 10),
          Icon(
            Ionicons.notifications_outline,
            color: AppColors.secondary,
          ),
          SizedBox(width: 5),
        ],
      ),
    );
  }
}
