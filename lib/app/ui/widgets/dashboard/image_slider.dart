import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';

class DashboardImageSlider extends StatelessWidget {
  const DashboardImageSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  FanCarouselImageSlider(
      sliderHeight: 230,
      imageFitMode: BoxFit.fitHeight,
      imagesLink: [
        'https://img.freepik.com/free-psd/sneakers-sale-banner-template_23-2148748556.jpg?w=1060&t=st=1685103389~exp=1685103989~hmac=8e467f6c5bf334bb12262b5ecb5ba9f367318c568e118addb343b25172ecf9d8',
        'https://img.freepik.com/free-psd/horizontal-banner-template-big-sale-with-woman-shopping-bags_23-2148786755.jpg?size=626&ext=jpg&ga=GA1.2.1693520121.1685102965&semt=ais',
        'https://img.freepik.com/free-vector/gradient-sale-background-with-discount_23-2149038128.jpg?w=900&t=st=1685103018~exp=1685103618~hmac=7392ee267df526cfcb4d6f3128d5af26e8a52279e6708d8ecae022d7e6af0cad',
      ],
      isAssets: false,
    );
  }
}
