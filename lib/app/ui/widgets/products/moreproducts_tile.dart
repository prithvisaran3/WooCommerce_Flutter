import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/app/controller/product.dart';
import 'package:template/app/ui/themes/colors.dart';
import 'package:template/app/ui/widgets/common/readmore.dart';

import '../../themes/font_size.dart';
import '../common/text.dart';

class MoreProductsTile extends StatelessWidget {
  const MoreProductsTile(
      {Key? key, required this.image, required this.name, required this.cost})
      : super(key: key);
  final String image;
  final String name;
  final String cost;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: 140,
        // height: 160,
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Container(
              height: 100,
              width: 100,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(fit: BoxFit.fill, image),
            ),
            SizedBox(height: 10),
            Column(
              children: [
                CommonText(
                  maxlines: ProductController.to.isReadMore == true ? 4 : 2,
                  text: name.length > 30 &&
                          ProductController.to.isReadMore == false
                      ? "${name.substring(0, 20)}..."
                      : name,
                  style: regularText(),
                ),
                ReadMoreText(
                  textStyle: regularText(
                    fontSize: 12,
                    color: AppColors.primary,
                  ),
                  onTap: () {
                    ProductController.to.isReadMore =
                        !ProductController.to.isReadMore;
                  },
                ),
              ],
            ),
            CommonText(
              text: cost,
              style: boldText(
                fontSize: 18,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
