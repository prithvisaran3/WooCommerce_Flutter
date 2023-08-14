// ignore_for_file: unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../common/shimmer_loader.dart';
import '../common/text.dart';

class Categories extends StatelessWidget {
  const Categories(
      {Key? key, required this.name, required this.image, required this.onTap})
      : super(key: key);
  final String name;
  final String image;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.transparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: 80,
              margin: const EdgeInsets.all(8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 5),
                      blurRadius: 10)
                ],
                // image: image == "null"
                //     ? const DecorationImage(
                //         fit: BoxFit.fill,
                //         image: AssetImage("assets/images/no_image.png"),
                //       )
                //     : DecorationImage(
                //         fit: BoxFit.fill,
                //         image: NetworkImage(image),
                //       ),
              ),
              child: image == "null"
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset('assets/images/no_image.png'))
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: image,
                        // placeholder: (context, url) =>
                        //     CircularProgressIndicator(),
                        placeholder: (context, url) =>
                            ShimmerLoader(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CommonText(
                  text: name.length > 20
                      ? "${name.substring(0, 15)}\n${name.substring(15)}"
                      : name,
                  style: regularText(fontSize: name.length > 20 ? 11 : 14)),
            )
          ],
        ),
      ),
    );
  }
}
