import 'package:bloc_project/core/colors/colors.dart';
import 'package:bloc_project/core/constants/string_constants.dart';
import 'package:bloc_project/core/widgets/common_widgets.dart';
import 'package:bloc_project/logic/order_history/order_history_bloc.dart';
import 'package:bloc_project/logic/order_history/order_history_event.dart';
import 'package:bloc_project/logic/order_history/order_history_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/themes/app_text_style.dart';
import '../../data/models/get_product_model.dart';

class OrderHistoryScreen extends StatelessWidget{
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return BlocProvider(
         create: (BuildContext context)=>OrderHistoryBloc()..add(OrderHistoryLoaded()),
         child: BlocListener<OrderHistoryBloc,OrderHistoryState>(
             listener: (context,state){

             },
           child: BlocBuilder<OrderHistoryBloc,OrderHistoryState>(
               builder: (context,state){
                 return Scaffold(
                   backgroundColor: AppColors.backGroundColor,
                   appBar: CommonWidgets.appBar(title: StringConstants.orderHistory),
                   body: state.orderHistoryList.isNotEmpty?Column(
                     children: [
                       ListView.builder(
                           itemCount: state.orderHistoryList.length,
                           shrinkWrap: true,
                           itemBuilder: (context,index){
                             Product item=state.orderHistoryList[index];
                             return Column(
                               children: [
                                 Padding(
                                   padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                                   child: Row(

                                     children: [
                                       Container(
                                         height: 90.h,width: 100.w,
                                         padding:EdgeInsets.all(15.h),
                                         decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(20.r),
                                             color: Color(0xFF4C5770)
                                         ),
                                         child: CommonWidgets.appIcons(
                                           assetName: item.image,
                                         )
                                         ,
                                       ),
                                       Expanded(
                                         child: Container(
                                           height: 90.h,
                                           padding:  EdgeInsets.only(left: 10.w,top: 10.h,bottom: 10.h),
                                           child: Column(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               Text(item.title,style: AppTextStyle.titleStyle16bw,),
                                               Text('\$ ${item.price}',style: AppTextStyle.titleStyle14gr,),
                                               Text('Completed',style: AppTextStyle.titleStyle14bw,),
                                             ],
                                           ),
                                         ),
                                       )
                                     ],
                                   ),
                                 ),
                                 Divider(thickness: 1.h,color: AppColors.lightWhite,)
                               ],
                             );
                           }
                       ),

                     ],
                   ):
                   Center(
                     child: Text(StringConstants.productNotFound,style: AppTextStyle.titleStyle16bw,),
                   ),
                 );
               }
           ),
         )
     );
  }
}