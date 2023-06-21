import 'package:flutter/material.dart';
import '../../themes/colors.dart';

class SimpleBoxLoading extends StatelessWidget {
  const SimpleBoxLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 80,
        width: 80,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(10)),
        child: CircularProgressIndicator(
          color: AppColors.primary,
          strokeWidth: 2,
        ),
      ),
    );
  }
}
