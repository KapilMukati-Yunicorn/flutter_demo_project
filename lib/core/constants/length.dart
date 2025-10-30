import 'package:bloc_project/core/navigation/navigation_service.dart';
import 'package:bloc_project/routes/app_router.dart';
import 'package:flutter/cupertino.dart';

class AppLength{
  static double screenFullHeight(){
    return MediaQuery.of(NavigationService.navigatorKey.currentContext!).size.height;
  }
  static double screenHeightPart(double part){
    return MediaQuery.of(NavigationService.navigatorKey.currentContext!).size.height/part;
  }
  static double screenFullWidth(){
    return MediaQuery.of(NavigationService.navigatorKey.currentContext!).size.width;
  }
  static double screenWidthPart(double part){
    return MediaQuery.of(NavigationService.navigatorKey.currentContext!).size.width/part;
  }
}