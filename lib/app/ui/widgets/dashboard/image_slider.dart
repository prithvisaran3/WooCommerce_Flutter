import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';

import '../../../controller/dashboard.dart';

class DashboardImageSlider extends StatelessWidget {
  const DashboardImageSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FanCarouselImageSlider(
      sliderHeight: 180,
      imageFitMode: BoxFit.fill,
      imageRadius: 15,
      expandedCloseChild: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
      ),
      // imagesLink: HomeController.to.banners,
      imagesLink: [
        'https://chandransteelsonline.com/wp-content/uploads/2023/01/web-slide-scaled.jpg',
        'https://chandransteelsonline.com/wp-content/uploads/2023/01/Backup_of_web-poster-1-scaled.jpg',
        'https://chandransteelsonline.com/wp-content/uploads/2023/01/Backup_of_Untitled-7-scaled.jpg',
        'https://chandransteelsonline.com/wp-content/uploads/2023/01/copperwares-scaled.jpg',
        'https://chandransteelsonline.com/wp-content/uploads/2023/01/steelware-1-scaled.jpg',
        'https://chandransteelsonline.com/wp-content/uploads/2023/01/bg-brass-wares-1-scaled.jpg',
        'https://chandransteelsonline.com/wp-content/uploads/2023/01/barware-1-scaled.jpg'
      ],
      isAssets: false,
    );
  }
}
