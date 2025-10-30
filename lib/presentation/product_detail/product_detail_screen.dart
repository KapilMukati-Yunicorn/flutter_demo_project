import 'package:bloc_project/core/colors/colors.dart';
import 'package:bloc_project/core/constants/string_constants.dart';
import 'package:bloc_project/core/widgets/common_widgets.dart';
import 'package:bloc_project/logic/cart/cart_bloc.dart';
import 'package:bloc_project/logic/cart/cart_event.dart';
import 'package:bloc_project/logic/product_details/product_details_bloc.dart';
import 'package:bloc_project/logic/product_details/product_details_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/image_constants.dart';
import '../../core/constants/length.dart';
import '../../core/themes/app_text_style.dart';
import '../../data/models/get_product_model.dart';
import '../../logic/product_details/product_details_state.dart';

class ProductDetailScreen extends StatelessWidget{
    final Product product;
    const ProductDetailScreen({super.key, required this.product});


    @override
  Widget build(BuildContext context) {
      return BlocProvider(
          create: (_) => ProductDetailBloc()..add(ProductLoaded(product)),
        child: Scaffold(
          backgroundColor: AppColors.backGroundColor,
          appBar: CommonWidgets.appBar(title: StringConstants.productDetail),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    ImageConstants.imgBg,
                  ),
                  fit: BoxFit.cover
              ),),
            child: BlocListener<ProductDetailBloc,ProductDetailState>(
                listener: (context,state){

                },
              child: BlocBuilder<ProductDetailBloc,ProductDetailState>(builder: (context,state){
                if (state is ProductDetailLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProductDetailLoaded) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Align(
                              alignment: Alignment.center,
                              child: CommonWidgets.appIcons(
                                  assetName:state.product.image,
                                  height: 200.h,
                                  width: AppLength.screenWidthPart(1.3),
                                  fit: BoxFit.fill
                              ),
                            ),
                            CommonWidgets.verticalSpace(height: 30.h),
                            Text('${state.product.title} ',style: AppTextStyle.titleStyle24bw,),
                            Text('PEUGEOT - LR01 ',style: AppTextStyle.titleStyle16bw,),
                            CommonWidgets.verticalSpace(height: 10.h),
                            Text('\$ ${state.product.price}',style: AppTextStyle.titleStyle16bw,),
                            CommonWidgets.verticalSpace(height: 20.h),
                            Text(StringConstants.description,style: AppTextStyle.titleStyle16bw,),
                            CommonWidgets.verticalSpace(height: 10.h),
                            Text(StringConstants.test,style: AppTextStyle.titleStyle14w,),



                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: 104.h,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.h),
                            color: AppColors.backGroundColor
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('\$ ${state.product.price}',style: AppTextStyle.titleStyle20bw,),
                            CommonWidgets.commonElevatedButton(
                              width: 160.w,height: 44.h,

                                onPressed: (){
                                  context.read<CartBloc>().add(AddProductToCart(product));
                                },
                                context: context,
                              child: Text(StringConstants.addToCart,style: AppTextStyle.titleStyle20bw,)
                            )
                          ],
                        ),
                      )
                    ],
                  );
                } else if (state is ProductDetailError) {
                  return Center(child: Text('Error: ${state.productDetailError}'));
                }
                return const SizedBox();

              }),
            ),
          ),
        ),

      );
  }
}