import 'package:bloc_project/core/colors/colors.dart';
import 'package:bloc_project/core/constants/image_constants.dart';
import 'package:bloc_project/core/constants/length.dart';
import 'package:bloc_project/core/widgets/common_widgets.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget{

  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: CommonWidgets.appIcons(
          assetName: ImageConstants.imgGoogleMap,
        height: AppLength.screenFullHeight(),
        width: AppLength.screenFullWidth(),
        fit: BoxFit.fill
      ),
    );
  }
}