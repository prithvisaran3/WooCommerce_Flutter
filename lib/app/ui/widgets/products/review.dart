
import 'package:flutter/material.dart';

import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../common/text.dart';
import 'individualreview_tile.dart';

class ProductReview extends StatelessWidget {
  const ProductReview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    '4.1',
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
                        Text('150 reviews')
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.green,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.thumb_up,
                      color: AppColors.white,
                    ),
                  ),
                  CommonText(
                    text: "30",
                    style: boldText(color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.thumb_down,
                      color: AppColors.white,

                    ),
                  ),
                  CommonText(
                    text: "5",
                    style: boldText(color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          IndividualReviewTile(),
          IndividualReviewTile(),
          IndividualReviewTile(),
        ],
      ),
    );
  }
}
