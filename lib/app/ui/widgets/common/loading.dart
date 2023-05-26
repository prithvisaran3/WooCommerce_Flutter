import 'package:flutter/material.dart';
import '../../themes/colors.dart';

class SimpleLoading extends StatelessWidget {
  const SimpleLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return SizedBox(
      height: media.width * 0.07,
      width: media.width * 0.07,
      child: const Center(
        child: CircularProgressIndicator(color: AppColors.secondary),
      ),
    );
  }
}
