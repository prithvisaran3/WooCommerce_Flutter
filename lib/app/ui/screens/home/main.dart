import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/app/config/config.dart';
import 'package:template/app/ui/screens/all_categories.dart';
import '../../../controller/home.dart';
import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../../widgets/common/button.dart';
import '../../widgets/common/loading.dart';
import '../../widgets/common/slider.dart';
import '../../widgets/common/text.dart';
import '../../widgets/home/categories.dart';
import '../../widgets/home/hot_selling.dart';
import '../../widgets/home/produts.dart';
import '../product/category_wise_product.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // HomeController.to.getDashboard();
    // HomeController.to.getCategories();
    return Scaffold(
      // appBar: AppBar(),
      body: Container(
        color: AppColors.white,
        child: ListView(
          children: [
            Obx(
              () => HomeController.to.loading == true
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
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          CommonSlider(imageSliders: HomeController.to.banners),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText(
                      text: "All Categories", style: mediumText(fontSize: 16)),
                  GestureDetector(
                    onTap: () async {
                      await HomeController.to.getCategories();
                      Get.to(() => const AllCategories());
                    },
                    child: CommonText(
                        text: "View All",
                        style:
                            mediumText(fontSize: 14, color: AppColors.primary)),
                  ),
                ],
              ),
            ),
            Obx(() => HomeController.to.categoryLoading == true
                ? const SimpleLoading()
                : HomeController.to.categoryEmpty == true
                    ? const Text("empty")
                    : SizedBox(
                        height: 130,
                        child: ListView.builder(
                            itemCount: HomeController.to.categoryDetails.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, int index) {
                              return Categories(
                                name:
                                    "${HomeController.to.categoryDetails[index]['name']}",
                                image:
                                    "${HomeController.to.categoryDetails[index]['image']}",
                                onTap: () async {
                                  HomeController.to.getProducts(
                                      categoryId:
                                          "${HomeController.to.categoryDetails[index]['id']}");
                                  await Get.to(() => CategoryProducts(
                                        categoryId:
                                            "${HomeController.to.categoryDetails[index]['id']}",
                                      ));
                                },
                              );
                            }),
                      )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText(
                      text: "All Products", style: mediumText(fontSize: 16)),
                  CommonText(
                      text: "View All",
                      style:
                          mediumText(fontSize: 14, color: AppColors.primary)),
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
                            itemCount: HomeController.to.productsDetails.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, int index) {
                              return Products(
                                name:
                                    "${HomeController.to.productsDetails[index]['name']}",
                                image: HomeController
                                        .to
                                        .productsDetails[index]['images']
                                        .isEmpty
                                    ? "null"
                                    : "${HomeController.to.productsDetails[index]['images'][0]['src']}",
                                regularPrice:
                                    "${HomeController.to.productsDetails[index]['regular_price'] == "" ? "0" : HomeController.to.productsDetails[index]['regular_price']}",
                                salePrice:
                                    "${HomeController.to.productsDetails[index]['sale_price'] == "" ? "0" : HomeController.to.productsDetails[index]['sale_price']}",
                              );
                            }),
                      )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText(
                      text: "Hot Selling Products",
                      style: mediumText(fontSize: 16)),
                  CommonText(
                      text: "View All",
                      style:
                          mediumText(fontSize: 14, color: AppColors.primary)),
                ],
              ),
            ),
            Obx(() => HomeController.to.topSellingLoading == true
                ? const SimpleLoading()
                : HomeController.to.topSellingEmpty == true
                    ? const Text("empty")
                    : SizedBox(
                        height: 160,
                        child: ListView.builder(
                            itemCount:
                                HomeController.to.topSellingDetails.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, int index) {
                              return HotSelling(
                                name:
                                    "${HomeController.to.topSellingDetails[index]['name']}",
                                image: HomeController
                                        .to
                                        .topSellingDetails[index]['images']
                                        .isEmpty
                                    ? "null"
                                    : "${HomeController.to.topSellingDetails[index]['images'][0]['src']}",
                                regularPrice:
                                    "${HomeController.to.topSellingDetails[index]['regular_price'] == "" ? "0" : HomeController.to.topSellingDetails[index]['regular_price']}",
                                salePrice:
                                    "${HomeController.to.topSellingDetails[index]['sale_price'] == "" ? "0" : HomeController.to.topSellingDetails[index]['sale_price']}",
                              );
                            }),
                      )),
            CommonButton(
                text: "tap",
                onTap: () {
                  // AuthController.to.login();
                  HomeController.to.getCategories(perPage: 5);
                  HomeController.to.getDashboard();
                  HomeController.to.getProducts();
                  HomeController.to.getTopSellingProducts();
                })
          ],
        ),
      ),
    );
  }
}
