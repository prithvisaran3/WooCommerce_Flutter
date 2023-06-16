import 'package:flutter/material.dart';
import 'package:steels/app/controller/order.dart';
import 'package:steels/app/ui/themes/font_size.dart';
import 'package:steels/app/ui/widgets/common/text.dart';

class DeliverStatusBar extends StatelessWidget {
  const DeliverStatusBar({Key? key, required this.status}) : super(key: key);
final String status;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 2,
              ),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              // height: 12,
              // width: 100,
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            CommonText(text: "Processing", style: regularText())
          ],
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 2,
              ),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              decoration: BoxDecoration(
                color: status == 'processing'
                    ? Colors.transparent
                    : status == 'delivered'
                        ? Colors.black
                        : Colors.black,
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            CommonText(text: "Shipping", style: regularText())
          ],
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 2,
              ),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              decoration: BoxDecoration(
                color: status == 'processing'
                    ? Colors.transparent
                    : Colors.black,
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            CommonText(text: "Delivery", style: regularText())
          ],
        ),
      ],
    );
  }
}
