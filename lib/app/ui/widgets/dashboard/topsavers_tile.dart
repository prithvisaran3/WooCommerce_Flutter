import 'package:flutter/material.dart';
import 'package:steels/app/ui/themes/colors.dart';
import 'package:steels/app/ui/themes/font_size.dart';
import 'package:steels/app/ui/widgets/common/common_rupee_text.dart';
import 'package:steels/app/ui/widgets/common/text.dart';

class TopSaversTile extends StatelessWidget {
  const TopSaversTile({Key? key, required this.onTap}) : super(key: key);
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // height: 120,
        // width: 100,
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary.withOpacity(0.5),
              AppColors.secondary.withOpacity(0.5),
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
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
            SizedBox(height: 5),
            CommonText(text: "Steel Plate", style: mediumText(fontSize: 12)),
            SizedBox(height: 5),
            Row(
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
