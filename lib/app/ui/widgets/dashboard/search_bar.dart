import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../themes/colors.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
