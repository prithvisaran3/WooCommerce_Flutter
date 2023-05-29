// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../common/common_rupee_text.dart';
import '../common/text.dart';

class HotSelling extends StatelessWidget {
  const HotSelling(
      {Key? key,
      required this.name,
      required this.image,
      required this.regularPrice,
      required this.salePrice})
      : super(key: key);
  final String name;
  final String image;
  final String regularPrice;
  final String salePrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 100,
          width: 100,
          margin: const EdgeInsets.all(8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12, offset: Offset(0, 5), blurRadius: 10)
              ],
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
              text: name.length > 12 ? "${name.substring(0, 8)}..." : name,
              style: regularText()),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              RupeeText(
                amount: regularPrice,
                color: AppColors.red,
                fontSize: 10,
                type: 'medium',
                textDecoration: TextDecoration.lineThrough,
              ),
              const SizedBox(width: 2),
              RupeeText(
                amount: salePrice,
                color: AppColors.black,
                fontSize: 12,
                type: 'bold',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
