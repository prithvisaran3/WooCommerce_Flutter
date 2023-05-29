import 'package:flutter/material.dart';

class TopSaversTile extends StatelessWidget {
  const TopSaversTile({Key? key, required this.onTap}) : super(key: key);
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        height: 120,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(
                'https://rukminim1.flixcart.com/image/416/416/l4hcx3k0/plate-tray-dish/r/n/0/designer-heavy-gauge-4-dinner-plate-leroyal-original-imagfdqzptbz2zch.jpeg?q=70'),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 1,
              blurRadius: 1,
            ),
          ],
        ),
      ),
    );
  }
}
