import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:template/app/ui/themes/colors.dart';
import 'package:template/app/ui/themes/font_size.dart';
import 'package:template/app/ui/widgets/common/text.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 15),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary,
                  spreadRadius: 1,
                  blurRadius: 1,
                ),
              ],
            ),
            child: Icon(
              Ionicons.checkmark_done,
              color: AppColors.primary,
            ),
          ),
          CommonText(
            text: "Your order #12345 has been placed",
            style: regularText(),
          ),
          CommonText(
            text: "14m ago",
            style: regularText(
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
