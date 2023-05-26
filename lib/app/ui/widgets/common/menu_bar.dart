import 'package:flutter/material.dart';

import '../../themes/colors.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Positioned(
        top: MediaQuery.of(context).padding.top + 12.5,
        right: MediaQuery.of(context).padding.left + 12.5,
        child: SizedBox(
          width: media.width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: media.width * 0.1,
                width: media.width * 0.1,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2,
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2)
                    ],
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(media.width * 0.02)),
                child: StatefulBuilder(builder: (context, setState) {
                  return InkWell(
                      onTap: () async {
                        print("drawer status is");
                        Scaffold.of(context).openDrawer();
                      },
                      child: const Icon(Icons.menu));
                }),
              ),
            ],
          ),
        ));
  }
}
