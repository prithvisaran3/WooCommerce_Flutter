import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';

import '../../../controller/dashboard.dart';

class DashboardImageSlider extends StatelessWidget {
  const DashboardImageSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  FanCarouselImageSlider(
      sliderHeight: 180,
      imageFitMode: BoxFit.cover,
      imageRadius: 15,
      expandedCloseChild: Padding(padding: EdgeInsets.symmetric(horizontal: 10),),
      imagesLink: HomeController.to.banners,
      isAssets: false,
    );
  }
}
