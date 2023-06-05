import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../screens/product_details.dart';
import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../common/text.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile(
      {Key? key, required this.categoryName, required this.categoryIcon})
      : super(key: key);
  final String categoryName;
  final IconData categoryIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withOpacity(0.9),
                  AppColors.secondary.withOpacity(0.8),
                ],
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade300,
                    spreadRadius: 1,
                    blurRadius: 1),
              ],
            ),
            child: Icon(
              categoryIcon,
              color: AppColors.white,
              size: 30,
            ),
          ),
          CommonText(
              text: categoryName,
              style: regularText(color: AppColors.black.withOpacity(0.5)))
        ],
      ),
    );
  }
}
