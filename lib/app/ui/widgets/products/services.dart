
import 'package:flutter/material.dart';
import 'package:steels/app/ui/widgets/products/relatedproducts.dart';

class ProductRelated extends StatelessWidget {
  const ProductRelated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         ServiceTile(servicetext: 'Brushing'),
         ServiceTile(servicetext: 'Body wash & Grooming'),
         ServiceTile(servicetext: 'Hair Cut'),
         ServiceTile(servicetext: 'Anti-Dandruff treatment'),
         ServiceTile(servicetext: 'Nail Trim'),
         ServiceTile(servicetext: 'Massage'),
         ServiceTile(servicetext: 'Ear & Eye Clean'),
         ServiceTile(servicetext: 'Teeth Brush'),
         ServiceTile(servicetext: 'Flea and Tick treatment'),

        ],
      ),
    );
  }
}
