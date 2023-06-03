// import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:template/app/ui/screens/product_details.dart';
import 'package:template/app/ui/screens/topselling_screen.dart';
import 'package:template/app/ui/themes/colors.dart';
import 'package:template/app/ui/widgets/common/text.dart';
import 'package:template/app/ui/widgets/dashboard/category_tile.dart';
import 'package:template/app/ui/widgets/dashboard/search_bar.dart';
import 'package:template/app/ui/widgets/dashboard/topsavers_tile.dart';

import '../../../controller/dashboard.dart';
import '../../themes/font_size.dart';
import '../../widgets/common/loading.dart';
import '../../widgets/dashboard/image_slider.dart';
import '../../widgets/dashboard/topselling_tile.dart';
import '../../widgets/home/categories.dart';
import '../../widgets/home/hot_selling.dart';
import '../../widgets/home/produts.dart';
import '../all_categories.dart';
import '../product/all_products.dart';
import '../product/category_wise_product.dart';
import '../topsavers_screen.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomeController(),
        initState: (_) {
          // HomeController.to.getCategories();
          HomeController.to.getProducts();
          // HomeController.to.getTopSellingProducts();
          // HomeController.to.getDashboard();
        },
        builder: (_) {
          return SafeArea(
              child: ListView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  child: SearchBar(),
                ),
                //
                // Obx(
                //   () => HomeController.to.loading == true
                //       ? const Padding(
                //           padding: EdgeInsets.all(8.0),
                //           child: Center(
                //               child: SizedBox(
                //             height: 30,
                //             width: 30,
                //             child: CircularProgressIndicator(
                //               color: AppColors.primary,
                //               strokeWidth: 2,
                //             ),
                //           )),
                //         )
                //       : Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: DashboardImageSlider()),
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //       horizontal: 15.0, vertical: 8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       CommonText(
                //           text: "All Categories",
                //           style: boldText(fontSize: 16)),
                //       GestureDetector(
                //         onTap: () async {
                //           await HomeController.to.getCategories();
                //           Get.to(() => const AllCategories());
                //         },
                //         child: CommonText(
                //             text: "View All",
                //             style: mediumText(
                //                 fontSize: 14, color: AppColors.primary)),
                //       ),
                //     ],
                //   ),
                // ),
                // Obx(() => HomeController.to.categoryLoading == true
                //     ? const SimpleLoading()
                //     : HomeController.to.categoryEmpty == true
                //         ? const Text("empty")
                //         : SizedBox(
                //             height: 130,
                //             child: ListView.builder(
                //                 itemCount:
                //                     HomeController.to.categoryDetails.length,
                //                 scrollDirection: Axis.horizontal,
                //                 shrinkWrap: true,
                //                 itemBuilder: (context, int index) {
                //                   return Categories(
                //                     name:
                //                         "${HomeController.to.categoryDetails[index]['name']}",
                //                     image:
                //                         "${HomeController.to.categoryDetails[index]['image']}",
                //                     onTap: () async {
                //                       HomeController.to.getProducts(
                //                           categoryId:
                //                               "${HomeController.to.categoryDetails[index]['id']}");
                //                       await Get.to(() => CategoryProducts(
                //                             categoryId:
                //                                 "${HomeController.to.categoryDetails[index]['id']}",
                //                           ));
                //                     },
                //                   );
                //                 }),
                //           )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText(
                          text: "All Products", style: boldText(fontSize: 16)),
                      GestureDetector(
                        onTap: (){
                          Get.to(()=>AllProducts());
                        },
                        child: CommonText(
                            text: "View All",
                            style: mediumText(
                                fontSize: 14, color: AppColors.primary)),
                      ),
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
                                itemCount:
                                    HomeController.to.productsDetails.length,
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
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       CommonText(
                //           text: "Hot Selling Products",
                //           style: boldText(fontSize: 16)),
                //       CommonText(
                //           text: "View All",
                //           style: mediumText(
                //               fontSize: 14, color: AppColors.primary)),
                //     ],
                //   ),
                // ),
                // Obx(() => HomeController.to.topSellingLoading == true
                //     ? const SimpleLoading()
                //     : HomeController.to.topSellingEmpty == true
                //         ? const Text("empty")
                //         : SizedBox(
                //             height: 160,
                //             child: ListView.builder(
                //                 itemCount:
                //                     HomeController.to.topSellingDetails.length,
                //                 scrollDirection: Axis.horizontal,
                //                 shrinkWrap: true,
                //                 itemBuilder: (context, int index) {
                //                   return HotSelling(
                //                     name:
                //                         "${HomeController.to.topSellingDetails[index]['name']}",
                //                     image: HomeController
                //                             .to
                //                             .topSellingDetails[index]['images']
                //                             .isEmpty
                //                         ? "null"
                //                         : "${HomeController.to.topSellingDetails[index]['images'][0]['src']}",
                //                     regularPrice:
                //                         "${HomeController.to.topSellingDetails[index]['regular_price'] == "" ? "0" : HomeController.to.topSellingDetails[index]['regular_price']}",
                //                     salePrice:
                //                         "${HomeController.to.topSellingDetails[index]['sale_price'] == "" ? "0" : HomeController.to.topSellingDetails[index]['sale_price']}",
                //                   );
                //                 }),
                //           )),
                // CategorySection(),
                // TopSaversSection(),
                // SizedBox(height: 20),
                // TopSellingSection(),
              ],
            ),
          ]));
        });
  }

  Column TopSaversSection() {
    return Column(
      children: [
        Row(
          children: [
            CommonText(
              text: "Top Savers",
              style: boldText(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Get.to(() => TopSaversScreen());
              },
              child: CommonText(
                text: "View all",
                style: boldText(
                  color: AppColors.primary,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 140,
          child: ListView.builder(
            physics: ScrollPhysics(),
            itemCount: 10,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, int index) {
              return TopSaversTile(
                onTap: () {},
              );
            },
          ),
        ),
      ],
    );
  }

  Column TopSellingSection() {
    return Column(
      children: [
        Row(
          children: [
            CommonText(
              text: "Top Selling",
              style: boldText(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Get.to(() => TopSellingScreen());
              },
              child: CommonText(
                text: "View all",
                style: boldText(
                  color: AppColors.primary,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 140,
          child: ListView.builder(
            physics: ScrollPhysics(),
            itemCount: 10,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, int index) {
              return TopSellingTile(
                onTap: () {},
              );
            },
          ),
        ),
      ],
    );
  }

  Column CategorySection() {
    return Column(
      children: [
        Row(
          children: [
            CommonText(
              text: "Category",
              style: boldText(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {},
              child: CommonText(
                text: "More Category",
                style: boldText(
                  color: AppColors.primary,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 130,
          child: ListView.builder(
            physics: ScrollPhysics(),
            itemCount: 10,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, int index) {
              return CategoryTile(
                categoryName: 'Shirt',
                categoryIcon: Ionicons.shirt_outline,
              );
            },
          ),
        ),
      ],
    );
  }
}
