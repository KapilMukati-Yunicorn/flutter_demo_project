import 'dart:io';

import 'package:bloc_project/core/navigation/navigation_service.dart';
import 'package:bloc_project/core/themes/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/string_constants.dart';


class AppImagePickerAndCropper {
  String string = "";
  static List<File> convertXFilesToFiles({required List<XFile> xFiles}) {
    List<File> files = xFiles.map((xFile) => File(xFile.path)).toList();
    return files;
  }

  static Future<File?> pickImage({
    bool pickImageFromGallery = false,
    bool wantCropper = false,
    Color color = Colors.blue,
  }) async {
    XFile? imagePicker;
    await showDialog(
      context: NavigationService.navigatorKey.currentContext!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text(
                StringConstants.camera,
                style: AppTextStyle.titleStyle12gr,
              ),
              onPressed: () async {
                pickImageFromGallery = false;
                try {
                  imagePicker =
                  await ImagePicker().pickImage(source: ImageSource.camera);
                } catch (e) {
                  //handle error
                  print('e:::::::::::::${e}');
                }
                NavigationService.pop();
              },
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text(
                StringConstants.gallery,
                style: AppTextStyle.titleStyle12gr,
              ),
              onPressed: () async {
                pickImageFromGallery = true;
                try {
                  imagePicker = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                } catch (e) {
                  //handle error
                  print('e:::::::::::::${e}');
                }
                NavigationService.pop();
              },
            ),
          ],
          title: Center(
            child: Text(StringConstants.selectImage,
                style: AppTextStyle.titleStyle18bb),
          ),
          content: Text(
            StringConstants.chooseImageFromTheOptionsBelow,
            style: AppTextStyle.titleStyle14bb,
          ),
        );
      },
    );

    if (imagePicker != null) {
      if (wantCropper) {
        CroppedFile? cropImage = await ImageCropper().cropImage(
          sourcePath: imagePicker!.path,
          uiSettings: [
            AndroidUiSettings(
              toolbarColor: color,
              toolbarTitle: "Cropper",
              activeControlsWidgetColor: color,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
            ),
          ],
          compressQuality: 80,
        );
        if (cropImage != null) {
          return File(cropImage.path);
        } else {
          // return File(imagePicker.path);
          return null;
        }
      } else {
        //return File(imagePicker.path);
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<List<XFile>> pickMultipleImages() async {
    final ImagePicker imagePicker = ImagePicker();
    List<XFile> imageFileList = [];

    final List<XFile> selectedImages = await imagePicker.pickMultiImage() ?? [];
    if (selectedImages.isNotEmpty) {
      imageFileList.addAll(selectedImages);
      if (kDebugMode) {
        print("Selected Image List Length:${imageFileList.length}");
      }
      return imageFileList;
    } else {
      return [];
    }
  }
}
