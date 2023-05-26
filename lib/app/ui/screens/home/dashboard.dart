import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:template/app/ui/screens/product_details.dart';
import 'package:template/app/ui/widgets/common/text.dart';

import '../../themes/font_size.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                CommonText(
                  text: "Trending Now",
                  style: headText(
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() =>ProductDetails());
                  },
                  child: Container(
                    height: 100, width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade300,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
