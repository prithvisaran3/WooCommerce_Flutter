
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../common/text.dart';

class IndividualReviewTile extends StatelessWidget {
  const IndividualReviewTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.75,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: AppColors.secondary, spreadRadius: 0, blurRadius: 3),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                text: "Sukumar Raja",
                style: boldText(
                  fontSize: 14,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: AppColors.secondary,
                    size: 14,
                  ),
                  Icon(
                    Icons.star,
                    color: AppColors.secondary,
                    size: 14,
                  ),
                  Icon(
                    Icons.star,
                    color: AppColors.grey,
                    size: 14,
                  ),
                  Icon(
                    Icons.star,
                    color: AppColors.grey,
                    size: 14,
                  ),
                  Icon(
                    Icons.star,
                    color: AppColors.grey,
                    size: 14,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 5),
          CommonText(
            textAlign: TextAlign.start,
            text:
                "The place was very big and had a great ambience! Dissappointed with the service. Can do better!",
            style: regularText(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
