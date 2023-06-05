import 'package:flutter/material.dart';

import '../../themes/colors.dart';
import '../../themes/font_size.dart';
import '../common/text.dart';

class ServiceTile extends StatelessWidget {
  const ServiceTile({Key? key, required this.servicetext}) : super(key: key);
  final String servicetext;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: CommonText(
        text: servicetext,
        style: boldText(
          fontSize: 14,
          color: AppColors.white,
        ),
      ),
    );
  }
}
