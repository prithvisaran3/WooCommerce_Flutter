import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:template/app/ui/widgets/common/loading.dart';

import '../../controller/home.dart';
import '../themes/colors.dart';
import '../themes/font_size.dart';
import '../widgets/common/text.dart';
import '../widgets/home/categories.dart';
import 'product/category_wise_product.dart';

class AllCategories extends StatelessWidget {
  const AllCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
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
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
            child: Row(
              children: [
                Flexible(
                    child: TextField(
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
                  ? Text("jkjhkh")
                  : Flexible(
                      child: GridView.builder(
                        itemCount: HomeController.to.categoryDetails.length,
                        controller: HomeController.to.scrollController,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 1.5),
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
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
                        },
                      ),
                    )),
        ],
      ),
    );
  }
}

class SortBy {
  final String value;
  final String text;
  final String sortOrder;

  SortBy(this.value, this.text, this.sortOrder);
}
