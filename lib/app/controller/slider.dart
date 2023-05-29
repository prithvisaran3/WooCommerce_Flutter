import 'package:get/get.dart';

import 'dashboard.dart';


class SliderController extends GetxController {
  static SliderController get to => Get.put(SliderController());
  final _imageSlider = <String>[].obs;

  get imageSlider => _imageSlider.value;

  set imageSlider(value) {
    _imageSlider.value = value;
  }

  final _loadingSliders = false.obs;

  bool get loadingSliders => _loadingSliders.value;

  set loadingSliders(bool value) {
    _loadingSliders.value = value;
  }

  final _dbImage = false.obs;

  get dbImage => _dbImage.value;

  set dbImage(value) {
    _dbImage.value = value;
  }

  getImageSliders() async {
    try {
      loadingSliders = true;
      dbImage = false;
      if (HomeController.to.banners != null ||
          HomeController.to.banners.isNotEmpty) {
        print("images sliders get from homecontroller");
        dbImage = true;
        loadingSliders = false;
        HomeController.to.banners.forEach((element) {
          imageSlider = HomeController.to.banners;
        });
      } else {
        print("failed tp images sliders get from homecontroller");
        dbImage = true;
        loadingSliders = false;
      }

      // SliderImagesRes res = await repository.getSliderImages();
      // print("slider response from controller ${res.status}");
      // print(" slider response from controller ${res.data![0].image}");
      // if (res.status == 200 || res.status == 201) {
      //   res.data!.forEach((element) {
      //     imageSlider.remove(element.image);
      //     update();
      //     imageSlider.add(element.image);
      //     update();
      //   });
      //   loadingSliders = false;
      //   print(
      //       "slider response after from controller data status ${imageSlider.status}");
      //   print(
      //       "slider response after from controller data  ${imageSlider.data.length()}");
      // }
    } catch (e) {
      loadingSliders = false;
    }
  }
}
