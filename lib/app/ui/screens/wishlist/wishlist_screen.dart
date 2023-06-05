import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:template/app/controller/wish_list.dart';
import 'package:template/app/ui/themes/font_size.dart';
import 'package:template/app/ui/widgets/common/text.dart';
import 'package:template/app/ui/widgets/wishlist/wishlist_product_container.dart';

import '../../themes/colors.dart';
import '../../widgets/common/button.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
        children: [
          CommonText(
            textAlign: TextAlign.start,
            text: "Wishlist",
            style: boldText(
              fontSize: 24,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: Get.width,
            height: Get.height * 0.79,
            child: GridView.builder(
              physics: ScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // crossAxisSpacing: 2,
                  // mainAxisSpacing: 2,
                  childAspectRatio: 0.75),
              itemCount: 8,
              itemBuilder: (context, index) {
                return WishlistItemTile();
              },
            ),
          )
        ],
      ),
    );
  }
}
