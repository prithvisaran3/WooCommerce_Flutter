import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:steels/app/ui/screens/product/product_details.dart';
import 'package:steels/app/ui/themes/colors.dart';
import 'package:steels/app/ui/widgets/common/text.dart';
import 'package:steels/app/ui/widgets/dashboard/search_bar.dart';

import '../../../controller/dashboard.dart';
import '../../themes/font_size.dart';
import '../../widgets/common/loading.dart';
import '../../widgets/dashboard/image_slider.dart';
import '../../widgets/home/categories.dart';
import '../../widgets/home/hot_selling.dart';
import '../../widgets/home/products.dart';
import '../all_categories.dart';
import '../product/all_products.dart';
import '../product/category_wise_product.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      initState: (_) {
        if (HomeController.to.firstLoading == false) {
          HomeController.to.getCategories(isInitial: true);
          HomeController.to.getProducts(isInitial: true);
          HomeController.to.getTopSellingProducts();
          HomeController.to.getDashboard();
        }
      },
      builder: (_) {
        return SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 200.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => HomeController.to.loading == false
                            ? const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                    child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                    strokeWidth: 2,
                                  ),
                                )),
                              )
                            : const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: DashboardImageSlider()),
                      ),
                      const SizedBox(height: 10),
                      AllCategoriesSection(),
                      AllProductsSection(),
                      HotSellingProductsSection(),
                    ],
                  ),
                ),
              ),
             const DSearchBar(),
            ],
          ),
        );
      },
    );
  }

  Column HotSellingProductsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                  text: "Hot Selling Products", style: boldText(fontSize: 16)),
              // CommonText(
              //     text: "View All",
              //     style: mediumText(
              //         fontSize: 14, color: AppColors.primary)),
            ],
          ),
        ),
        Obx(
          () => HomeController.to.topSellingLoading == true
              ? SimpleLoading()
              : HomeController.to.topSellingEmpty == true
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.hourglass_empty_outlined,
                              size: 50,
                              color: AppColors.primary.withOpacity(.3),
                            ),
                            CommonText(
                              text: "Products Empty",
                              style: regularText(fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: HomeController.to.topSellingDetails.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, int index) {
                          return HotSelling(
                            name:
                                "${HomeController.to.topSellingDetails[index]['name']}",
                            image: HomeController.to
                                    .topSellingDetails[index]['images'].isEmpty
                                ? "null"
                                : "${HomeController.to.topSellingDetails[index]['images'][0]['src']}",
                            regularPrice:
                                "${HomeController.to.topSellingDetails[index]['regular_price'] == "" ? "0" : HomeController.to.topSellingDetails[index]['regular_price']}",
                            salePrice:
                                "${HomeController.to.topSellingDetails[index]['sale_price'] == "" ? "0" : HomeController.to.topSellingDetails[index]['sale_price']}",
                            onTap: () {
                              Get.to(
                                () => ProductDetails(
                                  data: HomeController
                                      .to.initialProductDetails[index],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
        ),
      ],
    );
  }

  Column AllProductsSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(text: "All Products", style: boldText(fontSize: 16)),
              GestureDetector(
                onTap: () {
                  Get.to(() => AllProducts());
                  HomeController.to.onPressedSearch = false;
                },
                child: CommonText(
                    text: "View All",
                    style: mediumText(fontSize: 14, color: AppColors.primary)),
              ),
            ],
          ),
        ),
        Obx(() => HomeController.to.productsLoading == true
            ? SimpleLoading()
            : HomeController.to.productsEmpty == true
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.hourglass_empty_outlined,
                            size: 50,
                            color: AppColors.primary.withOpacity(.3),
                          ),
                          CommonText(
                              text: "Products Empty",
                              style: regularText(fontSize: 16))
                        ],
                      ),
                    ),
                  )
                : SizedBox(
                    height: 200,
                    child: ListView.builder(
                        itemCount:
                            HomeController.to.initialProductDetails.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, int index) {

                          return HomeController
                              .to.initialProductDetails[index]['stock_status']!='outofstock'?
                          Products(
                            name:
                                "${HomeController.to.initialProductDetails[index]['name']}",
                            image: HomeController
                                    .to
                                    .initialProductDetails[index]['images']
                                    .isEmpty
                                ? "null"
                                : "${HomeController.to.initialProductDetails[index]['images'][0]['src']}",
                            regularPrice:
                                "${HomeController.to.initialProductDetails[index]['regular_price'] == "" ? "0" : HomeController.to.initialProductDetails[index]['regular_price']}",
                            salePrice:
                                "${HomeController.to.initialProductDetails[index]['sale_price'] == "" ? "0" : HomeController.to.initialProductDetails[index]['sale_price']}",
                            onTap: () {
                              Get.to(
                                () => ProductDetails(
                                  data: HomeController
                                      .to.initialProductDetails[index],
                                ),
                              );
                            },
                          ):const SizedBox();
                        }),
                  )),
      ],
    );
  }

  Column AllCategoriesSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(text: "All Categories", style: boldText(fontSize: 16)),
              GestureDetector(
                onTap: () async {
                  Get.to(() => const AllCategories());
                },
                child: CommonText(
                    text: "View All",
                    style: mediumText(fontSize: 14, color: AppColors.primary)),
              ),
            ],
          ),
        ),
        Obx(() => HomeController.to.categoryLoading == true
            ? SimpleLoading()
            : HomeController.to.categoryEmpty == true
                ? const Text("empty")
                : SizedBox(
                    height: 150,
                    child: ListView.builder(
                        itemCount:
                            HomeController.to.initialCategoryDetails.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, int index) {
                          return Categories(
                            name:
                                "${HomeController.to.initialCategoryDetails[index]['name']}",
                            image:
                                "${HomeController.to.initialCategoryDetails[index]['image']}",
                            onTap: () async {
                              await Get.to(() => CategoryProducts(
                                  categoryId:
                                      "${HomeController.to.initialCategoryDetails[index]['id']}",
                                  categoryName:
                                      "${HomeController.to.initialCategoryDetails[index]['name']}"));
                            },
                          );
                        }),
                  )),
      ],
    );
  }
}
