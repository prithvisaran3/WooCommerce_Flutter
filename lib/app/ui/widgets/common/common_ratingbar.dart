import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:template/app/controller/review.dart';

import '../../themes/font_size.dart';
import 'text.dart';

class CommonRatingBar extends StatefulWidget {
  final double rating;
  final double? ratingBarSize;
  final int index;

  const CommonRatingBar(
      {Key? key, this.rating = 0, this.ratingBarSize = 30, required this.index})
      : super(key: key);

  @override
  State<CommonRatingBar> createState() => _CommonRatingBarState();
}

dynamic value;

class _CommonRatingBarState extends State<CommonRatingBar> {
  @override
  void initState() {
    ReviewController.to.onPressedRatingBar = false;

    setState(() {
      value = 0;
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RatingBar.builder(
          initialRating: widget.rating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: widget.ratingBarSize!,
          unratedColor: Colors.grey,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            ReviewController.to.onPressedRatingBar = true;
            ReviewController.to.activateReviewBar = widget.index;
            ReviewController.to.starRating = rating;

            setState(() {
              value = rating;
              print("VALUE : $value");
            });
          },
        ),
        CommonText(
          text: value == 0 ? "0.0" : "${value.toString()}",
          style: mediumText(
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
