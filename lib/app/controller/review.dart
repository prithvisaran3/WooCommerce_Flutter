import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steels/app/controller/main.dart';
import 'package:steels/app/controller/profile.dart';
import 'package:steels/app/data/repository/review.dart';

class ReviewController extends GetxController {
  static ReviewController get to => Get.put(ReviewController());
  final TextEditingController reviewDescription = TextEditingController();

  final repository = ReviewRepository();

  final _onPressedRatingBar = false.obs;

  get onPressedRatingBar => _onPressedRatingBar.value;

  set onPressedRatingBar(value) {
    _onPressedRatingBar.value = value;
  }

  final _activateReviewBar = 100.obs;

  get activateReviewBar => _activateReviewBar.value;

  set activateReviewBar(value) {
    _activateReviewBar.value = value;
  }

  final _reviewLoading = false.obs;

  get reviewLoading => _reviewLoading.value;

  set reviewLoading(value) {
    _reviewLoading.value = value;
  }

  final _allReviewDetails = <dynamic>[].obs;

  get allReviewDetails => _allReviewDetails.value;

  set allReviewDetails(value) {
    _allReviewDetails.value = value;
  }

  final _reviewCount = 0.obs;

  get reviewCount => _reviewCount.value;

  set reviewCount(value) {
    _reviewCount.value = value;
  }

  final _starRating = 0.0.obs;

  get starRating => _starRating.value;

  set starRating(value) {
    _starRating.value = value;
  }

  getAllReviews() async {
    reviewLoading = true;
    try {
      var res = await repository.getAllReviews();
      Future.delayed(Duration(seconds: 3), () {
        if (statusCode == 200 || statusCode == 201) {
          if (res.isNotEmpty) {
            reviewLoading = false;

            print("All reviews got successfully with data");
            allReviewDetails = res;
          } else {
            reviewLoading = false;

            print("All reviews got successfully without data");
          }
        } else {
          reviewLoading = false;

          print("ALL REVIEWS not received ");
        }
      });
    } catch (e) {
      reviewLoading = false;

      print("ALL REVIEWS Exception\n$e");
    }
  }

  sendReview({required dynamic productId}) async {

    reviewLoading = true;
    var reviewBody = {
      "product_id": "$productId",
      "review": "${reviewDescription.text}",
      "reviewer": "${ProfileController.to.profileDetails.username} ",
      "reviewer_email": "${ProfileController.to.profileDetails.email}",
      "rating": "$starRating"
    };

    try {
      print("BODY: $reviewBody");
      var res = await repository.sendReview(body: reviewBody);
      if (statusCode == 200 || statusCode == 201) {
        reviewLoading = false;
        print("Review sent successfully");
        reviewDescription.text="";
        starRating=0.0;
      } else {
        reviewLoading = false;

        print("Review not sent");
      }
    } catch (e) {
      reviewLoading = false;
      print("Send Review Exception \n $e");
    }
  }
}
