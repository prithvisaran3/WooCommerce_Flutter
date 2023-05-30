import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/app/ui/themes/colors.dart';
import 'package:template/app/ui/themes/font_size.dart';
import 'package:template/app/ui/widgets/common/common_rupee_text.dart';
import 'package:template/app/ui/widgets/common/text.dart';
import 'package:template/app/ui/widgets/common_offer_box.dart';
import 'package:template/app/ui/widgets/dashboard/bottom_pricebar.dart';

import '../../controller/product.dart';
import '../widgets/products/details.dart';
import '../widgets/products/review.dart';
import '../widgets/products/services.dart';
import '../widgets/products/select_productdetails.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          // toolbarHeight: 55,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body:
        Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                    height: Get.height * 0.3,
                    width: Get.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,

                      boxShadow: [
                        BoxShadow(
                          color: AppColors.background,
                          spreadRadius: 0,
                          blurRadius: 2,
                        )
                      ],
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(
                          "https://m.media-amazon.com/images/I/61lKQWyMdDL._SL1500_.jpg",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.all(5),
                    width: Get.width,
                    height: Get.height,
                    decoration: BoxDecoration(
                      // color: Colors.grey.shade300,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary.withOpacity(0.5),
                          AppColors.secondary.withOpacity(0.5),
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        CommonText(
                          text: "Apple iPhone 14 (128 GB) - Silver",
                          style: boldText(fontSize: 20),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonOffer(
                              discount: '10%',
                            ),
                            SizedBox(width: 5),
                            RupeeText(
                              amount: "27,000",
                              color: AppColors.black,
                              fontSize: 20,
                              type: 'medium',
                              textDecoration: TextDecoration.lineThrough,
                            ),
                            SizedBox(width: 10),
                            RupeeText(
                              amount: "10,000",
                              color: AppColors.black,
                              fontSize: 40,
                              type: 'bold',
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: Get.height * 0.6,
                          width: Get.width,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withOpacity(0.18),
                                spreadRadius: 0,
                                blurRadius: 5,
                              )
                            ],
                          ),
                          child: Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ProductOptionsCard(
                                      selectTitle: 'Details',
                                      onTap: () {
                                        ProductController.to.selectIndex = 0;
                                      },
                                      index: 0,
                                    ),
                                    ProductOptionsCard(
                                      selectTitle: 'Reviews',
                                      onTap: () {
                                        ProductController.to.selectIndex = 1;
                                      },
                                      index: 1,
                                    ),
                                    ProductOptionsCard(
                                      selectTitle: 'Related',
                                      onTap: () {
                                        ProductController.to.selectIndex = 2;
                                      },
                                      index: 2,
                                    ),
                                  ],
                                ),
                                Container(
                                  height: Get.height * 0.41,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ProductController.to.selectIndex == 0
                                            ? ProductDetail()
                                            : ProductController
                                                        .to.selectIndex ==
                                                    1
                                                ? ProductReview()
                                                : ProductRelated(),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(bottom: 0, right: 0, left: 0, child: BottomPriceBar()),
          ],
        ),
      ),
    );
  }
}
