import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:steels/app/ui/widgets/common/shimmer_loader.dart';
import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../common/common_rupee_text.dart';
import '../common/text.dart';

class Products extends StatelessWidget {
  const Products(
      {Key? key,
      required this.name,
      required this.image,
      required this.regularPrice,
      required this.salePrice,
      required this.onTap})
      : super(key: key);
  final String name;
  final String image;
  final String regularPrice;
  final String salePrice;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          // color: Colors.grey.shade200,
          // gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   colors: [
          //     AppColors.primary.withOpacity(0.5),
          //     AppColors.secondary.withOpacity(0.5),
          //   ],
          // ),
          borderRadius: BorderRadius.circular(10),
        ),
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
                // image: image == "null"
                //     ? const DecorationImage(
                //         fit: BoxFit.fill,
                //         image: AssetImage("assets/images/no_image.png"))
                //     : DecorationImage(
                //         fit: BoxFit.fill,
                //         image: NetworkImage(image),
                //       ),
              ),
              child: image == "null"
                  ? Image.asset('assets/images/no_image.png')
                  : CachedNetworkImage(
                      imageUrl: image,
                      // placeholder: (context, url) =>
                      //     CircularProgressIndicator(),
                      placeholder: (context, url) => ShimmerLoader(
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CommonText(
                  text: name.length > 12
                      ? "${name.substring(0, 12)}\n${name.substring(12)}"
                      : name,
                  style: regularText()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                  color: AppColors.primary,
                  fontSize: 14,
                  type: 'bold',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
