import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../controller/dashboard.dart';
import '../../../controller/product.dart';
import '../../../data/model/order_by.dart';
import '../../../utility/utility.dart';
import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../../widgets/common/loading.dart';
import '../../widgets/common/text.dart';
import '../../widgets/product/category_wise.dart';
import '../product_details.dart';

class CategoryProducts extends StatelessWidget {
  CategoryProducts(
      {Key? key, required this.categoryId, required this.categoryName})
      : super(key: key);
  final String categoryId;
  final String categoryName;
  final sortByOptions = [
    SortBy("popularity", "Popularity", "asc"),
    SortBy("modified", "Latest", "asc"),
    SortBy("price", "Price: High to Low", "desc"),
    SortBy("price", "Price: Low to High", "asc"),
  ];

  @override
  Widget build(BuildContext context) {
    debugPrint("category name is: $categoryName");
    debugPrint("category id is: $categoryId");
    return GetBuilder(
        init: HomeController(),
        initState: (_) {
          HomeController.to.pageNumber = 1;
          HomeController.to.orderBy = "";
          ProductController.to.productSearch.text = "";
          ProductController.to.loadMoreFunction(categoryId: categoryId);
          ProductController.to.productSearch.addListener(() {
            ProductController.to.searchProduct(categoryId: categoryId);
          });
          Future.delayed(const Duration(seconds: 0), () {
            HomeController.to
                .getProducts(categoryId: categoryId, isInitial: false);
          });
        },
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.dark),
              elevation: 0,
              backgroundColor: AppColors.primary,
              automaticallyImplyLeading: true,
              title: CommonText(
                text: "$categoryName : Products",
                style: mediumText(color: AppColors.white),
              ),
              actions: const [
                Icon(
                  Icons.notifications_none,
                  color: AppColors.white,
                  // size: 25,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.shopping_cart_sharp,
                  color: AppColors.white,
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
            body: Column(
              children: [
                Container(
                  height: 50,
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Row(
                    children: [
                      Flexible(
                          child: TextField(
                        controller: ProductController.to.productSearch,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            hintText: "Search",
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            fillColor: const Color(0xffe6e6ec),
                            filled: true),
                      )),
                      const SizedBox(
                        width: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9.0),
                            color: const Color(0xffe6e6ec)),
                        child: PopupMenuButton(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          onSelected: (data) {
                            if (data.text == "Popularity") {
                              HomeController.to.orderBy = "popularity";
                              HomeController.to.sort = "asc";
                            } else if (data.text == "Latest") {
                              HomeController.to.orderBy = "modified";
                              HomeController.to.sort = "asc";
                            } else if (data.text == "Price: High to Low") {
                              HomeController.to.orderBy = "price";
                              HomeController.to.sort = "desc";
                            } else if (data.text == "Price: Low to High") {
                              HomeController.to.orderBy = "price";
                              HomeController.to.sort = "asc";
                            }
                            HomeController.to.pageNumber = 1;
                            HomeController.to.getProducts(
                                categoryId: categoryId, isInitial: false);
                          },
                          itemBuilder: (context) {
                            return sortByOptions.map((e) {
                              return PopupMenuItem(
                                  value: e, child: Text(e.text));
                            }).toList();
                          },
                          icon: const Icon(Icons.tune),
                        ),
                      )
                    ],
                  ),
                ),
                Obx(() => HomeController.to.productsLoading == true
                    ? SimpleLoading()
                    : HomeController.to.productsEmpty == true
                        ? Padding(
                            padding: EdgeInsets.only(top: Get.height / 4),
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.hourglass_empty_outlined,
                                    size: 80,
                                    color: AppColors.primary.withOpacity(.3),
                                  ),
                                  CommonText(
                                      text: "Products Empty",
                                      style: regularText(fontSize: 16))
                                ],
                              ),
                            ),
                          )
                        : Flexible(
                            child: GridView.builder(
                              itemCount:
                                  HomeController.to.productsDetails.length,
                              controller: ProductController.to.scrollController,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.95),
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return CategoryProductsCard(
                                  name:
                                      "${HomeController.to.productsDetails[index]['name']}",
                                  image: HomeController
                                          .to
                                          .productsDetails[index]['images']
                                          .isEmpty
                                      ? "null"
                                      : "${HomeController.to.productsDetails[index]['images'][0]['src']}",
                                  regularPrice: HomeController
                                                  .to.productsDetails[index]
                                              ['regular_price'] ==
                                          ""
                                      ? "0"
                                      : "${HomeController.to.productsDetails[index]['regular_price']}",
                                  salePrice: HomeController
                                                  .to.productsDetails[index]
                                              ['sale_price'] ==
                                          ""
                                      ? "0"
                                      : "${HomeController.to.productsDetails[index]['sale_price']}",
                                  discount:
                                      "${calculateDiscount(regularPrice: int.parse(HomeController.to.productsDetails[index]['regular_price'] == "" ? "0" : "${HomeController.to.productsDetails[index]['regular_price']}"), salePrice: int.parse(HomeController.to.productsDetails[index]['sale_price'] == "" ? "0" : "${HomeController.to.productsDetails[index]['sale_price']}"))}",
                                  onTap: () {
                                    Get.to(() => ProductDetails(
                                          data: HomeController
                                              .to.productsDetails[index],
                                        ));
                                  },
                                );
                              },
                            ),
                          )),
              ],
            ),
          );
        });
  }
}
