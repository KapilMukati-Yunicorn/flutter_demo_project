import 'package:bloc_project/core/colors/colors.dart';
import 'package:bloc_project/core/constants/string_constants.dart';
import 'package:bloc_project/core/widgets/common_widgets.dart';
import 'package:bloc_project/logic/favorite/favorite_bloc.dart';
import 'package:bloc_project/logic/favorite/favorite_event.dart';
import 'package:bloc_project/logic/favorite/favorite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/image_constants.dart';
import '../../core/themes/app_text_style.dart';
import '../../data/models/get_product_model.dart';

class FavoriteScreen extends StatelessWidget{

  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoriteBloc,FavoriteState>(listener: (context,state){

    },
      child: BlocBuilder<FavoriteBloc,FavoriteState>(builder: (context,state){

        return Scaffold(
          backgroundColor: AppColors.backGroundColor,
          appBar: CommonWidgets.appBar(title: StringConstants.favoriteProducts,wantBackButton: false),
          body:Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 50.h),
            padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    ImageConstants.imgBg,
                  ),
                  fit: BoxFit.cover
              ),

            ),
            child: Column(
              children: [
                state.favoriteProducts.isNotEmpty?
                Expanded(
                    child: GridView.builder(
                        padding: EdgeInsets.zero,
                        itemCount:state.favoriteProducts.length ,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20.h,mainAxisSpacing: 20.h,
                            childAspectRatio: 165.w/220.h
                        ),
                        itemBuilder: (context,index){
                          Product item=state.favoriteProducts[index];
                          return GestureDetector(
                            onTap: (){
                              context.read<FavoriteBloc>().add(ClickOnFavoriteItem(item));
                            },
                            child: Container(
                              height:220.h,width: 165.w,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CommonWidgets.appIcons(
                                      assetName: ImageConstants.imgProductBg,
                                      height:220.h,width: 165.w
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      CommonWidgets.verticalSpace(height: 20),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                          onTap: (){
                                            context.read<FavoriteBloc>().add(AddRemoveProductToFavorite(item));
                                          },
                                          child: Padding(
                                            padding:  EdgeInsets.only(right: 15.w),
                                            child: Icon(Icons.favorite_border_rounded,size: 25,color: item.isFavorite?AppColors.errorColor:AppColors.white,),
                                          ),
                                        ),
                                      ),
                                      CommonWidgets.appIcons(
                                          assetName: item.image,
                                          height:100.h,width: 120.w
                                      ),
                                      Spacer(),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,

                                        children: [
                                          Text('${item.title} ',style: AppTextStyle.titleStyle14w,),
                                          Text('PEUGEOT - LR01 ',style: AppTextStyle.titleStyle16bw,),
                                          Text('\$ ${item.price}',style: AppTextStyle.titleStyle14w,),
                                        ],
                                      ),
                                      CommonWidgets.verticalSpace(height: 30),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          );
                        }
                    )
                ):
                Center(child: Text(StringConstants.favoriteProductsNotAvailable,style: AppTextStyle.titleStyle20bw,)),
              ],
            ),
          ) ,
        );

      }),
    );
  }
}