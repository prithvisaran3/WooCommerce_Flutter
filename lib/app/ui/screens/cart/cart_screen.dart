import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/app/ui/screens/payment/payment_method_screen.dart';
import 'package:template/app/ui/themes/colors.dart';
import 'package:template/app/ui/themes/font_size.dart';
import 'package:template/app/ui/widgets/cart/cart_item_tile.dart';
import 'package:template/app/ui/widgets/cart/pay_now_tile.dart';
import 'package:template/app/ui/widgets/common/text.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
      child: Stack(
        children: [
          Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    textAlign: TextAlign.start,
                    text: "My Cart",
                    style: boldText(fontSize: 25),
                  ),
                  Container(
                    height: Get.height * 0.70,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: 10,
                      shrinkWrap: true,
                      itemBuilder: (context, int index) {
                        return CartItemTile(
                          imageUrl:
                              "https://rukminim1.flixcart.com/image/416/416/l4hcx3k0/plate-tray-dish/r/n/0/designer-heavy-gauge-4-dinner-plate-leroyal-original-imagfdqzptbz2zch.jpeg?q=70",
                          name: "Steel Plate",
                          cost: "1400",
                          qty: "2",
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: PayNowTile(
              Tquantity: "3",
              Tcost: "4200",
              onPayTap: () {
                Get.to(() => PaymentMethodScreen());
              },
              Tsaved: '200',
            ),
          ),
        ],
      ),
    );
  }
}
