import 'package:flutter/cupertino.dart';
import '../../themes/colors.dart';
import '../../themes/font_size.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({Key? key, required this.text, required this.onTap})
      : super(key: key);
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        alignment: Alignment.center,
        width: media.width / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: AppColors.black,
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            tileMode: TileMode.mirror,
            colors: [AppColors.primary, AppColors.secondary],
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: boldText(
            fontSize: 16,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
