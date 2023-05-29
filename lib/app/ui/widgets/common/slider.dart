import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../../config/config.dart';
import '../../themes/colors.dart';

class CommonSlider extends StatefulWidget {
  final List<String> imageSliders;
  final dynamic type;
  final bool dbImage;

  const CommonSlider(
      {super.key, required this.imageSliders, this.type, this.dbImage = false});

  @override
  State<CommonSlider> createState() => _CommonSliderState();
}

class _CommonSliderState extends State<CommonSlider> {
  int dotIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              pauseAutoPlayOnTouch: true,
              viewportFraction: 0.89,
              pageSnapping: true,
              height: 180,
              onPageChanged: (index, test) {
                setState(() {
                  dotIndex = index;
                });
              }
              // enlargeCenterPage: true,
              ),
          items: widget.imageSliders
              .map((item) => InkWell(
                    onTap: () {},
                    child: Container(
                      margin:
                          const EdgeInsets.only(left: 5.0, right: 5, bottom: 5),
                      child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          child: Image.network(item,
                              fit: BoxFit.fill, width: 1000.0, loadingBuilder:
                                  (BuildContext context, Widget child,
                                      ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                                child: SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                                strokeWidth: 2,
                              ),
                            ));
                          }, errorBuilder: (context, error, stackTrace) {
                            return Image.network(
                              "${AppConfig.baseUrl}uploads/no_astro.jpg",
                              fit: BoxFit.fill,
                              width: 800.0,
                            );
                          })),
                    ),
                  ))
              .toList(),
        ),
        widget.imageSliders.length > 1
            ? DotsIndicator(
                dotsCount: widget.imageSliders.length,
                position: dotIndex,
                decorator: DotsDecorator(
                  color: Colors.grey.withAlpha(99),
                  activeColor: AppColors.primary,
                  size: const Size.square(7.0),
                  activeSize: const Size(7.0, 7.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
