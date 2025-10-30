import 'package:bloc_project/core/colors/colors.dart';
import 'package:bloc_project/core/constants/image_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bloc_project/core/navigation/navigation_service.dart';
import 'package:bloc_project/core/widgets/common_widgets.dart';
import 'package:bloc_project/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../logic/splash/splash_bloc.dart';
import '../../logic/splash/splash_event.dart';
import '../../logic/splash/splash_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<StatefulWidget> createState()=> _SplashState();
}

class _SplashState extends State<SplashScreen>{
List<String> imageList=[ImageConstants.imgCycle1,ImageConstants.imgCycle2,ImageConstants.imgCycle3,
ImageConstants.imgHelmet];

  @override
  Widget build(BuildContext context) {
    // Trigger splash start event when this screen is opened
    context.read<SplashBloc>().add(SplashStarted());
    return  BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashFinished) {
         NavigationService.pushNamed(AppRoutes.login);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backGroundColor,
        body: BlocBuilder<SplashBloc, SplashState>(
          builder: (context, state) {
            return  Center(
              child: CarouselSlider.builder(
                  itemCount: imageList.length,
                  itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                      CommonWidgets.appIcons(
                          assetName: imageList[itemIndex],
                          height: 400.h,
                          width: MediaQuery.of(context).size.width,
                          borderRadius: 20.r
                      ),
                  options: CarouselOptions(
                    height: 400.h,
                    aspectRatio: 16/9,
                    viewportFraction: 0.9,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 1),
                    autoPlayAnimationDuration: Duration(milliseconds: 500),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    onPageChanged: (index,pageChange){

                    },
                    scrollDirection: Axis.horizontal,
                  )
              ),
            );
          },
        ),
      ),
    );

  }
}