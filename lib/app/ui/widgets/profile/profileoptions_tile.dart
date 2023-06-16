import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:steels/app/ui/themes/font_size.dart';
import 'package:steels/app/ui/widgets/common/text.dart';

class ProfileOptionsTile extends StatelessWidget {
  const ProfileOptionsTile(
      {Key? key, required this.icon, required this.text, required this.onTap})
      : super(key: key);
  final IconData icon;
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon, color: Colors.white),
            Spacer(),
            CommonText(
              text: text,
              style: boldText(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
