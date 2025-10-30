import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/colors/colors.dart';
import '../../core/constants/image_constants.dart';
import '../../core/constants/string_constants.dart';
import '../../core/themes/app_text_style.dart';
import '../../core/widgets/common_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/get_product_model.dart';
import '../../logic/bicycle/bicycle_bloc.dart';
import '../../logic/bicycle/bicycle_event.dart';
import '../../logic/bicycle/bicycle_state.dart';
import '../../logic/favorite/favorite_bloc.dart';
import '../../logic/favorite/favorite_event.dart';

class SearchProductsScreen extends StatefulWidget {
  const SearchProductsScreen({Key? key}) : super(key: key);

  @override
  State<SearchProductsScreen> createState() => _SearchProductsScreenState();
}

class _SearchProductsScreenState extends State<SearchProductsScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      // appBar: CommonWidgets.appBar(title: StringConstants.searchProducts),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstants.imgBg),
            fit: BoxFit.cover,
          ),
        ),

        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              BlocBuilder<BiCycleBloc, BiCycleState>(
                builder: (context, state) {
                  return CommonWidgets.commonTextField(
                    controller: searchController,
                    hintText: StringConstants.searchHere,
                    // labelText: StringConstants.address,
                    onChanged: (content) =>
                        context.read<BiCycleBloc>().add(SearchProduct(content)),
                  );
                },
              ),

              Expanded(
                child: BlocBuilder<BiCycleBloc, BiCycleState>(
                  builder: (BuildContext context, BiCycleState state) {
                    if (state is BiCycleLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is BiCycleError) {
                      return Center(
                        child: Text('Error: ${state.biCycleError}'),
                      );
                    }

                    return GridView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.biCycleList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20.h,
                        mainAxisSpacing: 20.h,
                        childAspectRatio: 165 / 230,
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                          padding: EdgeInsets.only(right: 15.w),
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
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
