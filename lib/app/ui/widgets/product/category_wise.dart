// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../common/common_rupee_text.dart';
import '../common/text.dart';

class CategoryProductsCard extends StatelessWidget {
  const CategoryProductsCard(
      {Key? key,
      required this.name,
      required this.image,
      required this.regularPrice,
      required this.salePrice,
      required this.discount,
      required this.onTap})
      : super(key: key);
  final String name;
  final String image;
  final String regularPrice;
  final String salePrice;
  final String discount;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, offset: Offset(0, 5), blurRadius: 10)
            ],
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        image: image == "null"
                            ? const DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage("assets/images/no_image.png"))
                            : DecorationImage(
                                fit: BoxFit.fill, image: NetworkImage(image))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CommonText(
                        text: name.length > 12
                            ? "${name.substring(0, 8)}..."
                            : name,
                        style: regularText()),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RupeeText(
                          amount: regularPrice,
                          color: AppColors.red,
                          fontSize: 12,
                          type: 'medium',
                          textDecoration: TextDecoration.lineThrough,
                        ),
                        const SizedBox(width: 5),
                        RupeeText(
                          amount: salePrice,
                          color: AppColors.black,
                          fontSize: 14,
                          type: 'bold',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: int.parse(discount) > 0,
                child: Positioned(
                    left: 10,
                    top: 8,
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: AppColors.green,
                        ),
                        child: CommonText(
                          text: "$discount% OFF",
                          style: boldText(
                            color: AppColors.white,
                            fontSize: 12,
                          ),
                        ))),
              )
            ],
          )),
    );
  }
}
