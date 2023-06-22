import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steels/app/controller/review.dart';
import 'package:steels/app/ui/widgets/common/loading.dart';

import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../common/text.dart';
import 'individualreview_tile.dart';

class ProductReview extends StatelessWidget {
  ProductReview({Key? key, required this.id}) : super(key: key);
  int id;

  @override
  Widget build(BuildContext context) {
    // ReviewController.to.totalStarRating = 0.0;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: Column(
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ReviewController.to.reviewLoading == true
                      ? Text("...")
                      : Text(
                          "${ReviewController.to.calculateRating(totalRating: ReviewController.to.totalStarRating, reviewCount: ReviewController.to.reviewCount)}",
                          style: TextStyle(fontFamily: 'medium', fontSize: 38),
                        ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: AppColors.secondary,
                            ),
                            Icon(
                              Icons.star,
                              color: AppColors.secondary,
                            ),
                            Icon(
                              Icons.star,
                              color: AppColors.secondary,
                            ),
                            Icon(
                              Icons.star,
                              color: AppColors.secondary,
                            ),
                            Icon(
                              Icons.star,
                              color: AppColors.grey,
                            ),
                          ],
                        ),
                        ReviewController.to.reviewLoading == true
                            ? Text("...")
                            : CommonText(
                                text:
                                    "${ReviewController.to.reviewCount.toString()} reviews",
                                style: regularText(),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Obx(
            () => ReviewController.to.reviewLoading == true
                ? SimpleLoading()
                : ListView.builder(
                    itemCount: ReviewController.to.allReviewDetails.length,
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, int index) {
                      calculateReviewCountAndTotalRating(index);
                      ReviewController.to.allReviewDetails[index]
                                  ['product_id'] ==
                              id
                          ? ReviewController.to.totalStarRating +=
                              ReviewController.to.allReviewDetails[index]
                                      ['rating'] &
                                  ReviewController.to.reviewCount++
                          : null;

                      print(
                          "REVIEW Rating: ${ReviewController.to.totalStarRating}");
                      print("REVIEW Count: ${ReviewController.to.reviewCount}");

                      return ReviewController.to.allReviewDetails[index]
                                  ['product_id'] ==
                              id
                          ? IndividualReviewTile(
                              reviewer:
                                  "${ReviewController.to.allReviewDetails[index]['reviewer']}",
                              reviewerEmail:
                                  "${ReviewController.to.allReviewDetails[index]['reviewer_email']}",
                              review:
                                  "${ReviewController.to.allReviewDetails[index]['review']}",
                              rating: ReviewController
                                  .to.allReviewDetails[index]['rating'],
                            )
                          : SizedBox();
                    },
                  ),
          ),
          ReviewController.to.reviewCount == 0
              ? CommonText(
                  text: "No Reviews found",
                  style: regularText(fontSize: 18),
                )
              : SizedBox(),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  void calculateReviewCountAndTotalRating(int index) {
    ReviewController.to.allReviewDetails[index]['product_id'] == id
        ? ReviewController.to.totalStarRating +=
            ReviewController.to.allReviewDetails[index]['rating'] &
                ReviewController.to.reviewCount++
        : null;
  }
}
