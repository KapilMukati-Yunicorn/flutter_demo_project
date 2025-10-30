import 'package:bloc_project/core/colors/colors.dart';
import 'package:bloc_project/core/constants/string_constants.dart';
import 'package:bloc_project/core/themes/app_text_style.dart';
import 'package:bloc_project/core/widgets/common_widgets.dart';
import 'package:bloc_project/logic/notifications/notification_bloc.dart';
import 'package:bloc_project/logic/notifications/notification_event.dart';
import 'package:bloc_project/logic/notifications/notification_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatelessWidget{
  const NotificationScreen({super.key});
  @override
  Widget build(BuildContext context) {
   return BlocProvider(create: (context)=> NotificationBloc()..add(NotificationsLoading()),
     child:BlocListener<NotificationBloc,NotificationState>(listener: (context,state){

     },
       child: BlocBuilder<NotificationBloc,NotificationState>(builder: (context,state){
        return Scaffold(
          backgroundColor: AppColors.backGroundColor,
          appBar: CommonWidgets.appBar(title: StringConstants.notifications),
          body: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
            child: ListView.builder(
              itemCount: state.notificationList.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                Map<String,String> item=state.notificationList[index];
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
                    Text(item['title']??'',style: AppTextStyle.titleStyle18bw,),
                    Text(item['message']??'',style: AppTextStyle.titleStyle16w,),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(item['date']??'',style: AppTextStyle.titleStyle14w,),
                    )
                  ],
                ),
              );
            }),
          ),
        ) ;
       }
       ),
     ) ,
   );
  }
}