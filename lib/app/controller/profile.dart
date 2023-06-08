import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/app/ui/widgets/common/toast.dart';
import '../data/model/profile.dart';
import '../data/repository/profile.dart';
import 'main.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.put(ProfileController());

  final repository = ProfileRepository();

  final _getProfileLoading = false.obs;

  get getProfileLoading => _getProfileLoading.value;

  set getProfileLoading(value) {
    _getProfileLoading.value = value;
  }

  final _profileDetails = ProfileRes().obs;

  get profileDetails => _profileDetails.value;

  set profileDetails(value) {
    _profileDetails.value = value;
  }

  getProfile() async {
    getProfileLoading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString('userId');
    try {
      var res = await repository.getProfile(userId: id);
      if (statusCode == 200) {
        getProfileLoading = false;
        profileDetails = res;
        debugPrint("Profile get successfully");
        debugPrint("Profile Details is: ${res}");
      } else if (statusCode == 401) {
        getProfileLoading = false;
        debugPrint("Consumer and Secret Key Missing");
        commonToast(msg: "Consumer and Secret Key Missing");
      } else if (statusCode == 404) {
        getProfileLoading = false;
        debugPrint("Url No-found");
        commonToast(msg: "Url No-found");
      }
    } catch (e) {
      getProfileLoading = false;
      debugPrint("Error from server on get profile $e");
      commonToast(msg: "Url No-found or Server Error");
    }
  }


}
