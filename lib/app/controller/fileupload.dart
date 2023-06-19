import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../ui/themes/colors.dart';

class FileUploadController extends GetxController {
  static FileUploadController get to => Get.put(FileUploadController());

  final _imageFile = "".obs;

  get imageFile => _imageFile.value;

  set imageFile(value) {
    _imageFile.value = value;
  }

  final _isFilePicked = false.obs;

  get isFilePicked => _isFilePicked.value;

  set isFilePicked(value) {
    _isFilePicked.value = value;
  }

  Future<void> showSelectionDialog({required bool profileMode}) {
    return Get.dialog(AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Please choose!",
              style: TextStyle(),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              InkWell(
                splashColor: AppColors.secondary,
                child: Row(
                  children: [
                    Icon(
                      Icons.photo,
                      color: AppColors.primary,
                      size: 25,
                    ),
                    const SizedBox(width: 10),
                    const Text("Gallery"),
                  ],
                ),
                onTap: () {
                  getFromGallery(profileMode: profileMode);
                },
              ),
              const Padding(padding: EdgeInsets.all(8.0)),
              InkWell(
                splashColor: AppColors.secondary,
                child: Row(
                  children: [
                    Icon(
                      Icons.camera,
                      color: AppColors.primary,
                      size: 25,
                    ),
                    const SizedBox(width: 10),
                    const Text("Camera"),
                  ],
                ),
                onTap: () {
                  openCamera(profileMode: profileMode);
                },
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 30,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primary,
                      ),
                      child: const Center(
                          child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ],
                ),
              )
            ],
          ),
        )));
  }

  getFromGallery({required bool profileMode}) async {
    Get.back();
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    print("IMAGE TYPE: ${pickedFile.runtimeType}");
    cropImage(pickedFile?.path, profileMode: profileMode);
  }

  openCamera({required bool profileMode}) async {
    Get.back();
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    print("IMAGE TYPE: ${pickedFile.runtimeType}");

    cropImage(pickedFile?.path, profileMode: profileMode);
  }

  cropImage(filePath, {required bool profileMode}) async {
    final croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop image ',
            toolbarColor: AppColors.primary,
            toolbarWidgetColor: Colors.white,
            statusBarColor: AppColors.primary,
            activeControlsWidgetColor: AppColors.primary,
            cropFrameColor: AppColors.primary,
            backgroundColor: AppColors.primary,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
      ],
    );
    if (croppedImage != null) {
      print("CROPPED IMAGE TYPE: ${croppedImage.path}");
      isFilePicked = true;
      imageFile = croppedImage.path;
      update();
    }
  }
}
