import 'package:flutter/material.dart';
import '../../themes/colors.dart';

class SimpleLoading extends StatelessWidget {
  const SimpleLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: SizedBox(
      height: 30,
      width: 30,
      child: CircularProgressIndicator(
        color: AppColors.primary,
        strokeWidth: 2,
      ),
    ));
  }
}
