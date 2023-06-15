import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/app/controller/coupon.dart';
import 'package:template/app/ui/themes/colors.dart';
import 'package:template/app/ui/themes/font_size.dart';
import 'package:template/app/ui/widgets/common/common_rupee_text.dart';
import 'package:template/app/ui/widgets/common/text.dart';
import 'package:template/app/ui/widgets/dashboard/bottom_pricebar.dart';
import 'package:template/app/utility/utility.dart';

import '../../controller/dashboard.dart';
import '../../controller/product.dart';
import '../../controller/review.dart';
import '../widgets/common/loading.dart';
import '../widgets/home/produts.dart';
import '../widgets/products/availability.dart';
import '../widgets/products/details.dart';
import '../widgets/products/review.dart';
import '../widgets/products/services.dart';
import '../widgets/products/select_productdetails.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails({Key? key, this.data}) : super(key: key);
  dynamic data;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ProductController(),
        initState: (_) {
          ProductController.to.imageIndicator = 0;
          ProductController.to.shortDescription = false;
          CouponController.to.isCouponApplied = false;

        },
        builder: (_) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              bottomNavigationBar: BottomPriceBar(),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        child: Stack(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: CarouselSlider.builder(
                                itemCount: data['images'].length,
                                itemBuilder: (context, index, pageIndex) {
                                  return Image.network(
                                    "${data['images'][index]['src']}",
                                    fit: BoxFit.fill,
                                  );
                                },
                                options: CarouselOptions(
                                    autoPlay: false,
                                    enlargeCenterPage: true,
                                    viewportFraction: 1,
                                    aspectRatio: 1.0,
                                    onPageChanged: (index, reason) {
                                      ProductController.to.imageIndicator =
                                          index;
                                    }),
                              ),
                            ),
                            Positioned(
                                bottom: 10,
                                right: 0,
                                left: 0,
                                child: SizedBox(
                                  height: 15,
                                  child: Center(
                                    child: ListView.builder(
                                        itemCount: data['images'].length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Obx(() => Container(
                                                height: 8,
                                                width: 8,
                                                margin: const EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: index ==
                                                            ProductController.to
                                                                .imageIndicator
                                                        ? AppColors.primary
                                                        : AppColors.grey
                                                            .withOpacity(.4)),
                                              ));
                                        }),
                                  ),
                                ))
                          ],
                        )),
                    const SizedBox(height: 15),
                    Container(
                        padding: const EdgeInsets.all(5),
                        width: Get.width,
                        // height: Get.height,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(40)),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                const SizedBox(height: 15),
                                CommonText(
                                  text: "${data['name']}",
                                  style: boldText(fontSize: 18),
                                ),
                                data['attributes'] != null &&
                                        data['attributes'].length > 0
                                    ? CommonText(
                                        text:
                                            "${data['attributes'][0].options.join("-")}"
                                            "${data['attributes'][0]['name']}",
                                        style: regularText(fontSize: 14),
                                      )
                                    : const SizedBox(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RupeeText(
                                      amount: "${data['regular_price']}",
                                      color: AppColors.red,
                                      fontSize: 20,
                                      type: 'medium',
                                      textDecoration:
                                          TextDecoration.lineThrough,
                                    ),
                                    const SizedBox(width: 10),
                                    Obx(
                                      () => RupeeText(
                                        amount: CouponController
                                                    .to.isCouponApplied ==
                                                false
                                            ? "${data['sale_price']}"
                                            : "${CouponController.to.afterCouponPrice}",
                                        color: AppColors.black,
                                        fontSize: 40,
                                        type: 'bold',
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Obx(
                                  () => CouponController.to.isCouponApplied ==
                                          true
                                      ? Column(
                                          children: [
                                            CommonText(
                                              text:
                                                  "Your coupon ${CouponController.to.couponByIDdetails['code']} is applied",
                                              style: mediumText(),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CommonText(
                                                  text:
                                                      "Coupon savings amount:  ",
                                                  style:
                                                      mediumText(fontSize: 14),
                                                ),
                                                RupeeText(
                                                    amount:
                                                        "${CouponController.to.couponAppliedAmount}",
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    type: 'bold'),
                                              ],
                                            )
                                          ],
                                        )
                                      : SizedBox(),
                                ),
                                Container(
                                  // height: Get.height * 0.6,
                                  width: Get.width,
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: AppColors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            AppColors.black.withOpacity(0.18),
                                        spreadRadius: 0,
                                        blurRadius: 5,
                                      )
                                    ],
                                  ),
                                  child: Obx(
                                    () => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            ProductOptionsCard(
                                              selectTitle: 'Availability',
                                              onTap: () {
                                                ProductController
                                                    .to.selectIndex = 0;
                                              },
                                              index: 0,
                                            ),
                                            ProductOptionsCard(
                                              selectTitle: 'Detail',
                                              onTap: () {
                                                ProductController
                                                    .to.selectIndex = 1;
                                              },
                                              index: 1,
                                            ),
                                            ProductOptionsCard(
                                              selectTitle: 'Reviews',
                                              onTap: () {
                                                ProductController
                                                    .to.selectIndex = 2;
                                                ReviewController
                                                    .to.reviewCount = 0;
                                                ReviewController.to
                                                    .getAllReviews();
                                              },
                                              index: 2,
                                            ),
                                          ],
                                        ),
                                        Container(
                                          // height: ProductController
                                          //             .to.selectIndex ==
                                          //         1
                                          //     ? Get.height * 0.41
                                          //     : null,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                ProductController
                                                            .to.selectIndex ==
                                                        0
                                                    ? ProductAvailability(
                                                        productPrice:
                                                            double.parse(
                                                          data['sale_price'],
                                                        ),
                                                      )
                                                    : ProductController.to
                                                                .selectIndex ==
                                                            1
                                                        ? ProductDetail(
                                                            description: ProductController
                                                                        .to
                                                                        .shortDescription ==
                                                                    true
                                                                ? "${data['description']}"
                                                                : "${data['short_description']}",
                                                          )
                                                        : ProductReview(
                                                            id: data['id'],
                                                          ),

                                                // ProductController
                                                //             .to.selectIndex ==
                                                //         0
                                                //     ? ProductDetail(
                                                //         description: ProductController
                                                //                     .to
                                                //                     .shortDescription ==
                                                //                 true
                                                //             ? "${data['description']}"
                                                //             : "${data['short_description']}",
                                                //       )
                                                //     : ProductController.to
                                                //                 .selectIndex ==
                                                //             1
                                                //         ?  ProductReview(
                                                //               id: data['id'],
                                                //             )
                                                //         : ProductRelated(),
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
                            Visibility(
                              visible: calculateDiscount(
                                      regularPrice:
                                          int.parse(data['regular_price']),
                                      salePrice:
                                          int.parse(data['sale_price'])) >
                                  0,
                              child: Positioned(
                                left: 10,
                                top:
                                    CouponController.to.isCouponApplied == false
                                        ? 50
                                        : 35,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: AppColors.green,
                                      ),
                                      child: CommonText(
                                        text:
                                            "${calculateDiscount(regularPrice: int.parse(data['regular_price']), salePrice: int.parse(data['sale_price']))}% OFF",
                                        style: boldText(
                                          color: AppColors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Obx(
                                      () => CouponController
                                                  .to.isCouponApplied ==
                                              true
                                          ? Column(
                                              children: [
                                                CommonText(
                                                  text: "+",
                                                  style: boldText(
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    color: AppColors.green,
                                                  ),
                                                  child: CommonText(
                                                    text:
                                                        "${CouponController.to.couponPercentage}% OFF",
                                                    style: boldText(
                                                      color: AppColors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : SizedBox(),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Row(
                        children: [
                          CommonText(
                              text: "Related Products",
                              style: mediumText(color: AppColors.black)),
                          Spacer(),
                          CommonText(
                              text: "View All",
                              style: boldText(
                                  color: AppColors.primary, fontSize: 15)),
                        ],
                      ),
                    ),
                    Obx(() => HomeController.to.productsLoading == true
                        ? const SimpleLoading()
                        : HomeController.to.productsEmpty == true
                            ? const Text("empty")
                            : SizedBox(
                                height: 160,
                                child: ListView.builder(
                                    itemCount: HomeController
                                        .to.crossSellProducts.length,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, int index) {
                                      return Products(
                                        name:
                                            "${HomeController.to.crossSellProducts[index]['name']}",
                                        image: HomeController
                                                .to
                                                .crossSellProducts[index]
                                                    ['images']
                                                .isEmpty
                                            ? "null"
                                            : "${HomeController.to.crossSellProducts[index]['images'][0]['src']}",
                                        regularPrice:
                                            "${HomeController.to.crossSellProducts[index]['regular_price'] == "" ? "0" : HomeController.to.crossSellProducts[index]['regular_price']}",
                                        salePrice:
                                            "${HomeController.to.crossSellProducts[index]['sale_price'] == "" ? "0" : HomeController.to.crossSellProducts[index]['sale_price']}",
                                      );
                                    }),
                              )),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
