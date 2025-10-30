import 'package:bloc_project/core/colors/colors.dart';
import 'package:bloc_project/core/constants/image_constants.dart';
import 'package:bloc_project/core/constants/string_constants.dart';
import 'package:bloc_project/core/themes/app_text_style.dart';
import 'package:bloc_project/core/widgets/common_widgets.dart';
import 'package:bloc_project/data/models/get_product_model.dart';
import 'package:bloc_project/logic/bicycle/bicycle_bloc.dart';
import 'package:bloc_project/logic/bicycle/bicycle_event.dart';
import 'package:bloc_project/logic/bicycle/bicycle_state.dart';
import 'package:bloc_project/logic/favorite/favorite_bloc.dart';
import 'package:bloc_project/logic/favorite/favorite_event.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewSearchScreen extends StatelessWidget {
  const NewSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: BlocProvider(
        create: (context) => BiCycleBloc()..add(LoadProducts()),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 50,
                  left: 20,
                  right: 20,
                  bottom: 10,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: BlocBuilder<BiCycleBloc, BiCycleState>(
                  builder: (context, state) {
                    return CommonWidgets.commonTextField(
                      controller: searchController,
                      hintText: StringConstants.searchHere,
                      hintStyle: TextStyle(
                        color: AppColors.lightAppBar.withOpacity(0.6),
                      ),
                      style: TextStyle(color: AppColors.lightAppBar),
                      suffixIcon: Icon(
                        Icons.search_outlined,
                        color: AppColors.lightAppBar,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.lightAppBar),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onChanged: (content) => context.read<BiCycleBloc>().add(
                        SearchProduct(content),
                      ),
                    );
                  },
                ),
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

              // Expanded(
              //   child: BlocBuilder<SearchBloc, SearchState>(
              //     builder: (context, state) {
              //       if (state is SearchLoadingState) {
              //         return Center(child: CircularProgressIndicator());
              //       } else if (state is SearchErrorState) {
              //         return Center(
              //           child: Text("Error : ${state.searchError}"),
              //         );
              //       }

              //       // return ListView.builder(
              //       //   itemCount: state.productList.length,
              //       //   itemBuilder: (context, index) {
              //       //     final Product item = state.productList[index];
              //       //     return Padding(
              //       //       padding: const EdgeInsets.symmetric(
              //       //         horizontal: 20.0,
              //       //         vertical: 2,
              //       //       ),
              //       //       child: GestureDetector(
              //       //         onTap: () {
              //       //           context.read<SearchBloc>().add(
              //       //             OnClickProduct(item),
              //       //           );
              //       //         },
              //       //         child: Container(
              //       //           height: 150,
              //       //           decoration: BoxDecoration(
              //       //             color: AppColors.lightAppBar.withOpacity(0.5),
              //       //             borderRadius: BorderRadius.circular(12),
              //       //           ),
              //       //           padding: EdgeInsets.all(20),
              //       //           child: Row(
              //       //             spacing: 20,
              //       //             crossAxisAlignment: CrossAxisAlignment.start,
              //       //             children: [
              //       //               Container(
              //       //                 height: double.infinity,
              //       //                 width: 150,
              //       //                 decoration: BoxDecoration(
              //       //                   color: Colors.white,
              //       //                   borderRadius: BorderRadius.circular(9),
              //       //                 ),
              //       //                 child: CommonWidgets.imageView(
              //       //                   image: item.image,
              //       //                 ),
              //       //               ),
              //       //               Expanded(
              //       //                 child: Column(
              //       //                   spacing: 2,
              //       //                   crossAxisAlignment:
              //       //                       CrossAxisAlignment.start,
              //       //                   children: [
              //       //                     SizedBox(height: 5),
              //       //                     Text(
              //       //                       item.title,
              //       //                       style: TextStyle(
              //       //                         fontSize: 18,
              //       //                         fontWeight: FontWeight.w600,
              //       //                         color: Colors.white,
              //       //                       ),
              //       //                     ),
              //       //                     Text(
              //       //                       "Product_id: ${item.id}",
              //       //                       style: TextStyle(
              //       //                         color: Colors.white,
              //       //                         fontSize: 16,
              //       //                         fontWeight: FontWeight.w500,
              //       //                       ),
              //       //                     ),
              //       //                     Text(
              //       //                       "Price: ${item.price}",
              //       //                       style: TextStyle(
              //       //                         color: Colors.white,
              //       //                         fontSize: 16,
              //       //                         fontWeight: FontWeight.w500,
              //       //                       ),
              //       //                     ),
              //       //                   ],
              //       //                 ),
              //       //               ),
              //       //               IconButton(
              //       //                 onPressed: () {
              //       //                   context.read<FavoriteBloc>().add(
              //       //                     AddRemoveProductToFavorite(item),
              //       //                   );
              //       //                 },
              //       //                 icon: Icon(
              //       //                   item.isFavorite
              //       //                       ? Icons.favorite_outline
              //       //                       : Icons.favorite,
              //       //                   color: item.isFavorite
              //       //                       ? Colors.white
              //       //                       : Colors.red,
              //       //                 ),
              //       //               ),
              //       //             ],
              //       //           ),
              //       //         ),
              //       //       ),
              //       //     );
              //       //   },
              //       // );

              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
