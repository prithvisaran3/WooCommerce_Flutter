import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:template/app/ui/themes/colors.dart';

class CommonFilter extends StatelessWidget {
  const CommonFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      padding: EdgeInsets.all(8),
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
      child: Icon(
        Ionicons.filter,
        color: AppColors.primary,
      ),
    );
  }
}
