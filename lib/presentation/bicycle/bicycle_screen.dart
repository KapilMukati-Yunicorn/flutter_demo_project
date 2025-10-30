import 'package:bloc_project/core/colors/colors.dart';
import 'package:bloc_project/core/constants/icons_constant.dart';
import 'package:bloc_project/core/constants/length.dart';
import 'package:bloc_project/core/constants/string_constants.dart';
import 'package:bloc_project/core/navigation/navigation_service.dart';
import 'package:bloc_project/core/themes/app_text_style.dart';
import 'package:bloc_project/core/widgets/common_widgets.dart';
import 'package:bloc_project/data/models/get_product_model.dart';
import 'package:bloc_project/logic/bicycle/bicycle_bloc.dart';
import 'package:bloc_project/logic/bicycle/bicycle_event.dart';
import 'package:bloc_project/logic/bicycle/bicycle_state.dart';
import 'package:bloc_project/logic/favorite/favorite_bloc.dart';
import 'package:bloc_project/logic/favorite/favorite_event.dart';
import 'package:bloc_project/logic/favorite/favorite_state.dart';
import 'package:bloc_project/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gradient_borders/gradient_borders.dart';
import '../../core/constants/image_constants.dart';
import 'dart:math' as math;

class BiCycleScreen extends StatelessWidget {
  const BiCycleScreen({super.key});
  final List<String> imageList = const [
    ImageConstants.imgCycle1,
    ImageConstants.imgCycle2,
    ImageConstants.imgCycle3,
    ImageConstants.imgHelmet,
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BiCycleBloc()..add(LoadProducts()),
      child: Scaffold(
        backgroundColor: AppColors.backGroundColor,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 50.h),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageConstants.imgBg),
              fit: BoxFit.cover,
            ),
          ),
          child: MultiBlocListener(
            listeners: [
              BlocListener<FavoriteBloc, FavoriteState>(
                listener: (context, state) {
                  if (state is FavoriteListUpdated) {
                    context.read<BiCycleBloc>().add(LoadProducts());
                  }
                },
              ),
            ],
            child: BlocBuilder<BiCycleBloc, BiCycleState>(
              builder: (context, state) {
                if (state is BiCycleLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is BiCycleError) {
                  return Center(child: Text('Error: ${state.biCycleError}'));
                }
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          StringConstants.chooseYourBike,
                          style: AppTextStyle.titleStyle20bw,
                        ),
                        CommonWidgets.appIcons(
                          assetName: IconConstants.icSearch,
                          height: 44.h,
                          width: 44.h,
                          onTap: () {
                            NavigationService.pushNamed(AppRoutes.searchScreen);
                          },
                        ),
                      ],
                    ),
                    Container(
                      height: 220.h,
                      margin: EdgeInsets.only(top: 20.h),
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          CommonWidgets.appIcons(
                            assetName: ImageConstants.imgBannerBg,
                            height: 220.h,
                            width: AppLength.screenFullWidth(),
                            fit: BoxFit.fill,
                          ),
                          CarouselSlider.builder(
                            itemCount: imageList.length,
                            itemBuilder:
                                (
                                  BuildContext context,
                                  int itemIndex,
                                  int pageViewIndex,
                                ) => CommonWidgets.appIcons(
                                  assetName: imageList[itemIndex],
                                  height: 180.h,
                                  width: AppLength.screenWidthPart(1.7),
                                  fit: BoxFit.fill,
                                ),
                            options: CarouselOptions(
                              height: 200.h,
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.95,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration: Duration(
                                milliseconds: 100,
                              ),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.3,
                              onPageChanged: (index, pageChange) {},
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                          Positioned(
                            left: 10.w,
                            bottom: 20.h,
                            child: Text(
                              '30 % OFF',
                              style: AppTextStyle.titleStyle20bw,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Transform.rotate(
                      angle: -math.pi / 28,
                      child: Container(
                        height: 90.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 50.h,
                                width: 50.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.r),
                                  ),
                                  color: Color(0xFF222834),
                                  border: GradientBoxBorder(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFFFFFFFF),
                                        Color(0xFF000000).withOpacity(0.6),
                                        Color(0xFF000000),
                                      ],
                                    ),
                                    width: 2,
                                  ),
                                  // image:DecorationImage(image: AssetImage(ImageConstants.imgProductBg,))
                                ),
                                child: Text(
                                  'All',
                                  style: AppTextStyle.titleStyle20bw,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 50.h,
                                width: 50.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.r),
                                  ),
                                  color: Color(0xFF222834),
                                  border: GradientBoxBorder(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFFFFFFFF),
                                        Color(0xFF000000).withOpacity(0.6),
                                        Color(0xFF000000),
                                      ],
                                    ),
                                    width: 2,
                                  ),
                                  // image:DecorationImage(image: AssetImage(ImageConstants.imgProductBg,))
                                ),
                                child: CommonWidgets.appIcons(
                                  assetName: IconConstants.icBattery,
                                  height: 30.h,
                                  width: 30.w,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 50.h,
                                width: 50.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.r),
                                  ),
                                  color: Color(0xFF222834),
                                  border: GradientBoxBorder(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFFFFFFFF),
                                        Color(0xFF000000).withOpacity(0.6),
                                        Color(0xFF000000),
                                      ],
                                    ),
                                    width: 2,
                                  ),
                                  // image:DecorationImage(image: AssetImage(ImageConstants.imgProductBg,))
                                ),
                                child: CommonWidgets.appIcons(
                                  assetName: IconConstants.icRoad,
                                  height: 30.h,
                                  width: 30.w,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 50.h,
                                width: 50.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.r),
                                  ),
                                  color: Color(0xFF222834),
                                  border: GradientBoxBorder(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFFFFFFFF),
                                        Color(0xFF000000).withOpacity(0.6),
                                        Color(0xFF000000),
                                      ],
                                    ),
                                    width: 2,
                                  ),
                                  // image:DecorationImage(image: AssetImage(ImageConstants.imgProductBg,))
                                ),
                                child: CommonWidgets.appIcons(
                                  assetName: IconConstants.icCornRoad,
                                  height: 30.h,
                                  width: 30.w,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 50.h,
                                width: 50.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.r),
                                  ),
                                  color: Color(0xFF222834),
                                  border: GradientBoxBorder(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFFFFFFFF),
                                        Color(0xFF000000).withOpacity(0.6),
                                        Color(0xFF000000),
                                      ],
                                    ),
                                    width: 2,
                                  ),
                                  // image:DecorationImage(image: AssetImage(ImageConstants.imgProductBg,))
                                ),
                                child: CommonWidgets.appIcons(
                                  assetName: IconConstants.icHelmet,
                                  height: 30.h,
                                  width: 30.w,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: state.biCycleList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20.h,
                          mainAxisSpacing: 20.h,
                          childAspectRatio: 165 / 220,
                        ),
                        itemBuilder: (context, index) {
                          Product item = state.biCycleList[index];
                          return GestureDetector(
                            onTap: () {
                              context.read<BiCycleBloc>().add(
                                ClickOnProductItem(item),
                              );
                            },
                            child: Container(
                              height: 220.h,
                              width: 165.w,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CommonWidgets.appIcons(
                                    assetName: ImageConstants.imgProductBg,
                                    height: 220.h,
                                    width: 165.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CommonWidgets.verticalSpace(height: 20),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            context.read<FavoriteBloc>().add(
                                              AddRemoveProductToFavorite(item),
                                            );
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              right: 15.w,
                                            ),
                                            child: Icon(
                                              Icons.favorite_border_rounded,
                                              size: 25,
                                              color: item.isFavorite
                                                  ? AppColors.errorColor
                                                  : AppColors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      CommonWidgets.appIcons(
                                        assetName: item.image,
                                        height: 100.h,
                                        width: 120.w,
                                      ),
                                      Spacer(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,

                                        children: [
                                          Text(
                                            '${item.title} ',
                                            style: AppTextStyle.titleStyle14w,
                                          ),
                                          Text(
                                            'PEUGEOT - LR01 ',
                                            style: AppTextStyle.titleStyle16bw,
                                          ),
                                          Text(
                                            '\$ ${item.price}',
                                            style: AppTextStyle.titleStyle14w,
                                          ),
                                        ],
                                      ),
                                      CommonWidgets.verticalSpace(height: 30),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
