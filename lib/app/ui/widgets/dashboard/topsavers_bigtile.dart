import 'package:flutter/material.dart';
import 'package:template/app/ui/themes/colors.dart';
import 'package:template/app/ui/themes/font_size.dart';
import 'package:template/app/ui/widgets/common/common_rupee_text.dart';
import 'package:template/app/ui/widgets/common/text.dart';

class TopSaversBigTile extends StatelessWidget {
  const TopSaversBigTile({Key? key, required this.onTap}) : super(key: key);
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // height: 100,
        // width: 100,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 20,
              width: 40,
              padding: EdgeInsets.all(3),
              margin: EdgeInsets.only(right: 100),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8),
                color: Colors.green,
              ),
              child: CommonText(
                text: '10%',
                style: boldText(
                  fontSize: 10,
                  color: AppColors.white,
                ),
              ),
            ),
            SizedBox(height: 2),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: 9, vertical: 5),
              height: 80,
              // width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    spreadRadius: 1,
                    blurRadius: 1,
                  ),
                ],
              ),
              child: Image.network(
                  'https://rukminim1.flixcart.com/image/416/416/l4hcx3k0/plate-tray-dish/r/n/0/designer-heavy-gauge-4-dinner-plate-leroyal-original-imagfdqzptbz2zch.jpeg?q=70'),
            ),
            CommonText(text: "Steel Plate", style: mediumText(fontSize: 12)),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RupeeText(
                  amount: "2400",
                  color: Colors.red,
                  fontSize: 10,
                  type: 'regular',
                  textDecoration: TextDecoration.lineThrough,
                ),
                SizedBox(width: 3),
                RupeeText(
                    amount: "1000",
                    color: AppColors.black,
                    fontSize: 12,
                    type: 'bold'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
