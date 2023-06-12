import 'package:flutter/material.dart';
import 'package:template/app/controller/order.dart';
import 'package:template/app/ui/themes/font_size.dart';
import 'package:template/app/ui/widgets/common/text.dart';



class DeliverStatusBar extends StatelessWidget {
  const DeliverStatusBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 2,
              ),
              height: 12,
              width: 100,
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
              height: 12,
              width: 100,
              decoration: BoxDecoration(
                color: OrderController.to.orderStatus == 'processing'
                    ? Colors.transparent
                    : OrderController.to.orderStatus == 'delivered'
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
              height: 12,
              width: 100,
              decoration: BoxDecoration(
                color: OrderController.to.orderStatus == 'processing'
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
