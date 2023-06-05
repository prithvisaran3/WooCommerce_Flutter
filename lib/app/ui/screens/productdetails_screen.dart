import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/app/ui/themes/colors.dart';
import 'package:template/app/ui/themes/font_size.dart';
import 'package:template/app/ui/widgets/cart_add_remove.dart';
import 'package:template/app/ui/widgets/common/common_rupee_text.dart';
import 'package:template/app/ui/widgets/common/text.dart';
import 'package:template/app/ui/widgets/common_offer_box.dart';
import 'package:template/app/ui/widgets/dashboard/bottom_pricebar.dart';
import 'package:template/app/ui/widgets/products/moreproducts_tile.dart';

import '../../controller/product.dart';
import '../../controller/wish_list.dart';
import '../widgets/products/details.dart';
import '../widgets/products/review.dart';
import '../widgets/products/availability.dart';
import '../widgets/products/select_productdetails.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      initState: (_) {
        ProductController.to.onPressedCheckPincode = false;
        ProductController.to.onPressedApplyCoupon = false;

      },
      init: ProductController(),
      builder: (_) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            // extendBodyBehindAppBar: true,
            appBar:

            appbar(context),
            body: Stack(
              children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ImageSection(),
                      SizedBox(height: 15),
                      Container(
                        padding: EdgeInsets.all(5),
                        width: Get.width,
                        // height: Get.height,
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
                        child:
                        Column(
                          children: [
                            SizedBox(height: 20),
                            ProductTitleSection(),
                            SizedBox(height: 10),
                            ProductPriceSection(),
                            SizedBox(height: 20),
                            ProductDescriptionSection(),
                            SizedBox(height: 20),
                            RelatedProductSection(),
                            SizedBox(height: 120),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                BottomCostBar(),
              ],
            ),
          ),
        );
      },
    );
  }

  Positioned BottomCostBar() {
    return Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: BottomPriceBar(
                  amount: '50,000',
                  onTap: () {},
                ),
              );
  }

  Column RelatedProductSection() {
    return Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                text: "Related Products",
                                style: boldText(
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                height: 250,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: ListView.builder(
                                  itemCount: 5,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, int index) {
                                    return MoreProductsTile(
                                      image:
                                          'https://rukminim1.flixcart.com/image/416/416/xif0q/mobile/2/s/7/-original-imagmg6gktts6sfy.jpeg?q=70',
                                      name:
                                          'SAMSUNG Galaxy S23 Ultra 5G (Green, 256 GB)  (12 GB RAM)', cost:'30,000',
                                    );
                                  },
                                ),
                              )
                            ],
                          );
  }

  Container ProductDescriptionSection() {
    return Container(
                            height: Get.height * 0.5,
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
                                        selectTitle: 'Availability',
                                        onTap: () {
                                          ProductController.to.selectIndex =
                                              0;
                                        },
                                        index: 0,
                                      ),
                                      ProductOptionsCard(
                                        selectTitle: 'Details'
                                            '',
                                        onTap: () {
                                          ProductController.to.selectIndex =
                                              1;
                                        },
                                        index: 1,
                                      ),
                                      ProductOptionsCard(
                                        selectTitle: 'Reviews',
                                        onTap: () {
                                          ProductController.to.selectIndex =
                                              2;
                                        },
                                        index: 2,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: Get.height * 0.42,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          ProductController.to.selectIndex ==
                                                  0
                                              ? ProductAvailability()
                                              : ProductController
                                                          .to.selectIndex ==
                                                      1
                                                  ? ProductDetail()
                                                  : ProductReview(),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
  }

  Row ProductPriceSection() {
    return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommonOffer(
                                discount: '50%',
                              ),
                              SizedBox(width: 10),
                              RupeeText(
                                amount: "1,00,000",
                                color: AppColors.black,
                                fontSize: 20,
                                type: 'medium',
                                textDecoration: TextDecoration.lineThrough,
                              ),
                              SizedBox(width: 10),
                              RupeeText(
                                amount: "50,000",
                                color: AppColors.black,
                                fontSize: 40,
                                type: 'bold',
                              ),
                            ],
                          );
  }

  Column ProductTitleSection() {
    return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CommonText(
                                text: "Tech Products",
                                style: mediumText(
                                  fontSize: 16,
                                ),
                              ),
                              CommonText(
                                text: "Apple iPhone 14 (128 GB) - Silver",
                                style: boldText(fontSize: 24),
                              ),
                            ],
                          );
  }

  Container ImageSection() {
    return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 25),
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
                    );
  }

  AppBar appbar(BuildContext context) {
    return AppBar(
            // toolbarHeight: 55,
            elevation: 0,
            actions: [
              Obx(
                () => GestureDetector(
                  onTap: () {
                    WishListController.to.isWishlistItem =
                        !WishListController.to.isWishlistItem;
                  },
                  child: Icon(
                    WishListController.to.isWishlistItem == false
                        ? Icons.favorite_outline
                        : Icons.favorite_outlined,
                    color: WishListController.to.isWishlistItem == false
                        ? AppColors.primary
                        : AppColors.red,
                    size: 30,
                  ),
                ),
              ),
              SizedBox(width: 20),
            ],
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.primary,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          );
  }
}
