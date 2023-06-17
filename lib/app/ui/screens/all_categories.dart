import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:steels/app/ui/widgets/common/loading.dart';

import '../../controller/dashboard.dart';
import '../themes/colors.dart';
import '../themes/font_size.dart';
import '../widgets/common/button.dart';
import '../widgets/common/text.dart';
import '../widgets/home/categories.dart';
import 'product/category_wise_product.dart';

class AllCategories extends StatelessWidget {
  const AllCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomeController(),
        initState: (_) {
          HomeController.to.categoryLoadMoreFunction();
          HomeController.to.categorySearch.text = "";
          HomeController.to.categoryPageNumber = 1;
          HomeController.to.categorySearch.addListener(() {
            if (HomeController.to.categoryEmpty != true) {
              HomeController.to.searchCategories();
            }
            if (HomeController.to.categorySearch.text == "") {
              HomeController.to.categoryPageNumber = 1;
            } else {
              HomeController.to.categoryPageNumber = 1;
              HomeController.to.searchCategories();
            }
          });
          Future.delayed(const Duration(seconds: 0), () {
            HomeController.to.getCategories(isInitial: false);
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
                text: "All Categories",
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
                  // margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Flexible(
                          child: TextFormField(
                        controller: HomeController.to.categorySearch,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            hintText: "Search",
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            fillColor: const Color(0xffe6e6ec),
                            filled: true),
                      )),
                      const SizedBox(
                        width: 0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9.0),
                            color: const Color(0xffe6e6ec)),
                        // child: PopupMenuButton(
                        //   elevation: 5,
                        //   shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(10.0)),
                        //   onSelected: (data) {},
                        //   itemBuilder: (context) {
                        //     return sortByOptions.map((e) {
                        //       return PopupMenuItem(value: e, child: Text(e.text));
                        //     }).toList();
                        //   },
                        //   icon: const Icon(Icons.tune),
                        // ),
                      )
                    ],
                  ),
                ),
                Obx(() => HomeController.to.categoryLoading == true
                    ? SimpleLoading()
                    : HomeController.to.categoryEmpty == true
                        ? Padding(
                            padding: EdgeInsets.only(top: Get.height / 4),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.category_outlined,
                                    color: AppColors.grey.withOpacity(.5),
                                    size: 100,
                                  ),
                                  CommonText(
                                    text: "No Categories",
                                    style: mediumText(
                                        fontSize: 16,
                                        color: AppColors.grey.withOpacity(.6)),
                                  ),
                                  const SizedBox(height: 10),
                                  CommonButton(
                                    text: "Got to Shop",
                                    onTap: () {
                                      Get.back();
                                      HomeController.to.selectedIndex = 0;
                                    },
                                    fontColor: AppColors.white,
                                  )
                                ],
                              ),
                            ),
                          )
                        : Flexible(
                            child: GridView.builder(
                              itemCount:
                                  HomeController.to.categoryDetails.length,
                              controller:
                                  HomeController.to.categoryScrollController,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, childAspectRatio: 1.5),
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return Categories(
                                  name:
                                      "${HomeController.to.categoryDetails[index]['name']}",
                                  image:
                                      "${HomeController.to.categoryDetails[index]['image']}",
                                  onTap: () async {
                                    await Get.to(() => CategoryProducts(
                                          categoryId:
                                              "${HomeController.to.categoryDetails[index]['id']}",
                                          categoryName:
                                              "${HomeController.to.categoryDetails[index]['name']}",
                                        ));
                                    // HomeController.to.getProducts(
                                    //     categoryId:
                                    //         "${HomeController.to.categoryDetails[index]['id']}");
                                    // await Get.to(() => CategoryProducts(
                                    //       categoryId:
                                    //           "${HomeController.to.categoryDetails[index]['id']}",
                                    //     ));
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
