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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 5),
                      blurRadius: 10)
                ],
                image: image == "null"
                    ? const DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/no_image.png"))
                    : DecorationImage(
                        fit: BoxFit.fill, image: NetworkImage(image))),
          ),
          CommonText(
              text: name.length > 12
                  ? "${name.substring(0, 12)}\n${name.substring(12)}"
                  : name,
              style: regularText()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                RupeeText(
                  amount: regularPrice,
                  color: AppColors.black,
                  fontSize: 12,
                  type: 'medium',
                  textDecoration: TextDecoration.lineThrough,
                ),
                const SizedBox(width: 4),
                RupeeText(
                  amount: salePrice,
                  color: AppColors.red,
                  fontSize: 14,
                  type: 'bold',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
