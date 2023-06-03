import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../controller/dashboard.dart';
import '../../../data/model/order_by.dart';
import '../../../utility/utility.dart';
import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../../widgets/common/loading.dart';
import '../../widgets/common/text.dart';
import '../../widgets/product/category_wise.dart';

class CategoryProducts extends StatelessWidget {
  CategoryProducts({Key? key, required this.categoryId}) : super(key: key);
  final String categoryId;
  final sortByOptions = [
    SortBy("popularity", "Popularity", "asc"),
    SortBy("modified", "Latest", "asc"),
    SortBy("price", "Price: High to Low", "desc"),
    SortBy("price", "Price: High to Low", "asc"),
  ];

  @override
  Widget build(BuildContext context) {
    print("id is $categoryId");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        elevation: 0,
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: true,
        title: CommonText(
          text: "Woo Commerce",
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
                  child: PopupMenuButton(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    onSelected: (data) {},
                    itemBuilder: (context) {
                      return sortByOptions.map((e) {
                        return PopupMenuItem(value: e, child: Text(e.text));
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
                  ? Text("jkjhkh")
                  : Flexible(
                      child: GridView.builder(
                        itemCount: HomeController.to.productsDetails.length,
                        controller: HomeController.to.scrollController,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 0.95),
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return CategoryProductsCard(
                            name:
                                "${HomeController.to.productsDetails[index]['name']}",
                            image: HomeController
                                    .to.productsDetails[index]['images'].isEmpty
                                ? "null"
                                : "${HomeController.to.productsDetails[index]['images'][0]['src']}",
                            regularPrice: HomeController
                                            .to.productsDetails[index]
                                        ['regular_price'] ==
                                    ""
                                ? "0"
                                : "${HomeController.to.productsDetails[index]['regular_price']}",
                            salePrice: HomeController.to.productsDetails[index]
                                        ['sale_price'] ==
                                    ""
                                ? "0"
                                : "${HomeController.to.productsDetails[index]['sale_price']}",
                            discount:
                                "${calculateDiscount(regularPrice: int.parse(HomeController.to.productsDetails[index]['regular_price'] == "" ? "0" : "${HomeController.to.productsDetails[index]['regular_price']}"), salePrice: int.parse(HomeController.to.productsDetails[index]['sale_price'] == "" ? "0" : "${HomeController.to.productsDetails[index]['sale_price']}"))}",
                            onTap: () {},
                          );
                        },
                      ),
                    )),
        ],
      ),
    );
  }
}

