import 'package:flutter/material.dart';
import 'package:flutter_html_v3/flutter_html.dart';
import 'package:get/get.dart';
import 'package:steels/app/controller/product.dart';

import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../common/text.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({Key? key, required this.description}) : super(key: key);
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Html(
          data: description,
          style: {
            "div": Style(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                fontSize: FontSize.medium)
          },
        ),
        // Align(
        //     child: Obx(() => GestureDetector(
        //           onTap: () {
        //             ProductController.to.shortDescription =
        //                 !ProductController.to.shortDescription;
        //           },
        //           child: CommonText(
        //             text: ProductController.to.shortDescription == true
        //                 ? "Show Less"
        //                 : description == ""
        //                     ? "No Short Description Found\nShow Detail"
        //                     : "Show More",
        //             style: regularText(color: AppColors.primary),
        //           ),
        //         )))
      ],
    );
  }
}
