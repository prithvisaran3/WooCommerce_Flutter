import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:template/app/ui/themes/colors.dart';
import 'package:template/app/ui/themes/font_size.dart';
import 'package:template/app/ui/widgets/common/common_rupee_text.dart';
import 'package:template/app/ui/widgets/common/text.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.cost,
      required this.qty})
      : super(key: key);
  final String imageUrl;
  final String name;
  final String cost;
  final String qty;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
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
                child: Image.network(imageUrl),
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CommonText(
                    text: name,
                    style: mediumText(
                      fontSize: 18,
                      color: AppColors.black,
                    ),
                  ),
                  RupeeText(
                    amount: cost,
                    color: AppColors.primary,
                    fontSize: 18,
                    type: 'bold',
                  )
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
                          text: qty,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonText(
                text: "You saved  " ,
                style: mediumText(fontSize: 12),
              ),
              RupeeText(
                  amount: "200",
                  color: AppColors.secondary,
                  fontSize: 14,
                  type: 'bold')
            ],
          )
        ],
      ),
    );
  }
}
