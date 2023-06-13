import 'package:flutter/material.dart';
import 'package:flutter_html_v3/flutter_html.dart';
import 'package:get/get.dart';

import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../common/text.dart';

class IndividualReviewTile extends StatelessWidget {
  const IndividualReviewTile(
      {Key? key,
      required this.reviewer,
      required this.reviewerEmail,
      required this.review})
      : super(key: key);
  final String reviewer;
  final String reviewerEmail;
  final String review;

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: reviewer,
                    style: boldText(
                      fontSize: 14,
                    ),
                  ),
                  CommonText(
                    text: reviewerEmail,
                    style: mediumText(
                      fontSize: 12,
                    ),
                  ),
                ],
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
          Html(
            data: review,
            style: {
              "div": Style(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  fontSize: FontSize.medium)
            },
          ),
        ],
      ),
    );
  }
}
