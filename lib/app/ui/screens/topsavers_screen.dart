import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steels/app/controller/auth.dart';
import 'package:steels/app/controller/dashboard.dart';
import 'package:steels/app/ui/themes/colors.dart';
import 'package:steels/app/ui/themes/font_size.dart';
import 'package:steels/app/ui/widgets/common/common_filter.dart';
import 'package:steels/app/ui/widgets/common/common_search.dart';
import 'package:steels/app/ui/widgets/common/search_bar.dart';
import 'package:steels/app/ui/widgets/common/text.dart';
import 'package:steels/app/ui/widgets/dashboard/topsavers_bigtile.dart';
import 'package:steels/app/ui/widgets/dashboard/topsavers_tile.dart';

import '../widgets/dashboard/search_bar.dart';

class TopSaversScreen extends StatelessWidget {
  const TopSaversScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 5),
                      CommonText(
                          text: "Top Savers",
                          style:
                              mediumText(color: AppColors.primary, fontSize: 18))
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    CommonDSearchBar(),
                    SizedBox(width: 10),
                    CommonFilter(),
                  ],
                ),
                SizedBox(height: 30),
                SizedBox(
                  height: Get.height*0.8,
                  child: GridView.builder(
                    physics: ScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.9,
                        crossAxisCount: 2),
                    itemCount: 8,
                    itemBuilder: (context, int index) {
                      return TopSaversBigTile(onTap: () {});
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
