import 'package:bloc_project/core/colors/colors.dart';
import 'package:bloc_project/core/constants/image_constants.dart';
import 'package:bloc_project/core/constants/length.dart';
import 'package:bloc_project/core/constants/string_constants.dart';
import 'package:bloc_project/core/navigation/navigation_service.dart';
import 'package:bloc_project/core/themes/app_text_style.dart';
import 'package:bloc_project/core/widgets/common_widgets.dart';
import 'package:bloc_project/data/models/get_address_model.dart';
import 'package:bloc_project/logic/delivery_address/delivery_address_bloc.dart';
import 'package:bloc_project/logic/delivery_address/delivery_address_state.dart';
import 'package:bloc_project/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryAddressScreen extends StatelessWidget{
  const DeliveryAddressScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocListener<DeliveryAddressBloc,DeliveryAddressState>(listener: (context,state){

    },
      child: BlocBuilder<DeliveryAddressBloc,DeliveryAddressState>(builder: (context,state){
        return Scaffold(
          backgroundColor: AppColors.backGroundColor,
          appBar: CommonWidgets.appBar(title: StringConstants.deliveryAddress),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: CommonWidgets.customBackgroundFrame(
            width: AppLength.screenFullWidth(),
              height: 50.h,
              buttonMargin: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
              onPressed: (){
                NavigationService.pushNamed(AppRoutes.addAddress);
              },
              context: context,
            child: Text(StringConstants.addNewAddress,style: AppTextStyle.titleStyle18bw,)
          ),
          body: Container(
            height: AppLength.screenFullHeight(),
            width: AppLength.screenFullWidth(),
            padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(ImageConstants.imgBg),fit: BoxFit.fill)
            ),
            child:
            Column(
              children: [
                state.addressList.isEmpty?
                    Align(
                      alignment: Alignment.center,
                      child: Text('Address not found ....',style: AppTextStyle.titleStyle20bw,),
                    ):
                ListView.builder(
                    itemCount: state.addressList.length,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      Address item=state.addressList[index];
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                        margin: EdgeInsets.symmetric(vertical: 5.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(10.r),
                                bottomLeft: Radius.circular(10.r),bottomRight: Radius.circular(10.r)
                            ),
                            border: Border.all(color: AppColors.lightWhite,width: 1.w)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.type??'',style: AppTextStyle.titleStyle18bw,),
                            Text(item.address??'',style: AppTextStyle.titleStyle16w,),
                            Text(item.pinCode??'',style: AppTextStyle.titleStyle14w,)
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
        ) ;
      }
      ),
    );
  }
}