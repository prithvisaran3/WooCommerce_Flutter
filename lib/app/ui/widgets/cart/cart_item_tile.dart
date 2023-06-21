import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:steels/app/controller/cart.dart';
import 'package:steels/app/ui/themes/colors.dart';
import 'package:steels/app/ui/themes/font_size.dart';
import 'package:steels/app/ui/widgets/common/common_rupee_text.dart';
import 'package:steels/app/ui/widgets/common/text.dart';

import '../cart_add_remove.dart';

class CartItemContainer extends StatelessWidget {
  const CartItemContainer(
      {Key? key,
      required this.image,
      required this.name,
      required this.salePrice,
      required this.regularPrice,
      required this.count,
      required this.onChanged,
      required this.deletePressed})
      : super(key: key);
  final String image;
  final String name;
  final String salePrice;
  final String regularPrice;
  final int count;
  final Function(dynamic) onChanged;
  final Function() deletePressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
        color: AppColors.white,
        // gradient: const LinearGradient(
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        //   colors: [
        //     // AppColors.primary,
        //     AppColors.secondary,
        //     AppColors.white,
        //   ],
        // ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(5.0),
            height: 80,
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
              image,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                textAlign: TextAlign.start,
                text: name.length > 15
                    ? "${name.substring(0, 15)}\n${name.substring(15)}"
                    : name,
                style: mediumText(fontSize: 16),
              ),
              Row(
                children: [
                  RupeeText(
                      amount: regularPrice,
                      color: AppColors.black,
                      fontSize: 12,
                      textDecoration: TextDecoration.lineThrough,
                      type: 'medium'),
                  SizedBox(width: 5),
                  RupeeText(
                      amount: salePrice,
                      color: AppColors.primary,
                      fontSize: 16,
                      type: 'bold'),
                ],
              )
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CartAddRemove(
                lowerLimit: 0,
                upperLimit: 1000,
                stepValue: 1,
                iconSize: 22,
                value: count,
                onChanged: onChanged,
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Container(
                  //   padding: EdgeInsets.all(5),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     color: AppColors.black,
                  //   ),
                  //   child: Icon(
                  //     Ionicons.heart_outline,
                  //     color: Colors.white,
                  //     size: 20,
                  //   ),
                  // ),
                  // SizedBox(width: 5),
                  GestureDetector(
                    onTap: deletePressed,
                    child: Container(
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
