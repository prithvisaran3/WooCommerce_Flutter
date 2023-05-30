import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:template/app/ui/themes/colors.dart';
import 'package:template/app/ui/themes/font_size.dart';
import 'package:template/app/ui/widgets/common/common_rupee_text.dart';
import 'package:template/app/ui/widgets/common/text.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
        color: Colors.white,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            // AppColors.primary,
            AppColors.primary,
            AppColors.secondary,
          ],
        ),
      ),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
          Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CommonText(
                text: "Steel Plate",
                style: boldText(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              RupeeText(
                  amount: "1400",
                  color: Colors.white,
                  fontSize: 18,
                  type: 'medium')
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                margin: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.grey,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Ionicons.remove, size: 20),
                    SizedBox(width: 20),
                    CommonText(
                      text: "1",
                      style: regularText(fontSize: 15),
                    ),
                    SizedBox(width: 15),
                    Icon(
                      Ionicons.add,
                      size: 20,
                    )
                  ],
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.primary,
                    ),
                    child: Icon(
                      Ionicons.heart_outline,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 5),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.red,
                    ),
                    child: Icon(
                      Ionicons.trash_bin_outline,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
