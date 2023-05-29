import 'package:flutter/material.dart';
import 'package:template/app/ui/themes/font_size.dart';
import 'package:template/app/ui/widgets/common/common_rupee_text.dart';

import '../common/text.dart';

class TopSellingBigTile extends StatelessWidget {
  const TopSellingBigTile({Key? key, required this.onTap}) : super(key: key);
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // height: 100,
        // width: 100,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(height: 5),
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
                  'https://rukminim1.flixcart.com/image/416/416/xif0q/monitor/e/0/v/sa241y-full-hd-23-8-um-qs1si-a01-acer-original-imaghtgedbzrhuzs.jpeg?q=70'),
            ),
            SizedBox(height: 5),
            CommonText(text: "Steel Plate", style: mediumText(fontSize: 12)),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RupeeText(
                  amount: "24,000",
                  color: Colors.red,
                  fontSize: 10,
                  type: 'regular',
                  textDecoration: TextDecoration.lineThrough,
                ),
                SizedBox(width: 3),
                RupeeText(
                    amount: "15,000",
                    color: Colors.black,
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
