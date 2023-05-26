import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:template/app/ui/screens/product_details.dart';
import 'package:template/app/ui/themes/colors.dart';
import 'package:template/app/ui/widgets/common/text.dart';
import 'package:template/app/ui/widgets/dashboard/category_tile.dart';
import 'package:template/app/ui/widgets/dashboard/search_bar.dart';
import 'package:template/app/ui/widgets/dashboard/topsavers_tile.dart';

import '../../themes/font_size.dart';
import '../../widgets/dashboard/image_slider.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                SearchBar(),
                SizedBox(height: 20),
                DashboardImageSlider(),
                SizedBox(height: 20),
                CategorySection(),
                TopSaversSection(),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Column TopSaversSection() {
    return Column(
                children: [
                  Row(
                    children: [
                      CommonText(
                        text: "Top Savers",
                        style: boldText(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      CommonText(
                        text: "View all",
                        style: boldText(
                          color: AppColors.primary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      physics: ScrollPhysics(),
                      itemCount: 10,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, int index) {
                        return TopSaversTile();
                      },
                    ),
                  ),
                ],
              );
  }

  Column CategorySection() {
    return Column(
      children: [
        Row(
          children: [
            CommonText(
              text: "Category",
              style: boldText(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            Spacer(),
            CommonText(
              text: "More Category",
              style: boldText(
                color: AppColors.primary,
                fontSize: 14,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 130,
          child: ListView.builder(
            physics: ScrollPhysics(),
            itemCount: 10,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, int index) {
              return CategoryTile(
                categoryName: 'Shirt',
                categoryIcon: Ionicons.shirt_outline,
              );
            },
          ),
        ),
      ],
    );
  }
}
