import 'package:bloc_project/core/colors/colors.dart';
import 'package:bloc_project/core/constants/string_constants.dart';
import 'package:bloc_project/core/themes/app_text_style.dart';
import 'package:bloc_project/core/widgets/common_widgets.dart';
import 'package:bloc_project/logic/setting/setting_bloc.dart';
import 'package:bloc_project/logic/setting/setting_event.dart';
import 'package:bloc_project/logic/setting/setting_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget{
      const SettingScreen({super.key});

      @override
  Widget build(BuildContext context) {
     return BlocProvider(create: (context)=>SettingBloc()..add(SettingLoading()),
       child: BlocListener<SettingBloc,SettingState>(listener: (context,state){

       },
         child: BlocBuilder<SettingBloc,SettingState>(builder: (context,state){
           return Scaffold(
             backgroundColor: AppColors.backGroundColor,
             appBar: CommonWidgets.appBar(title: StringConstants.settings),
             body: Container(
               margin: EdgeInsets.symmetric(horizontal: 5.w),
               child: state.settingList.isNotEmpty?
               ListView.builder(
                 itemCount: state.settingList.length,
                   shrinkWrap: true,
                   itemBuilder: (context,index){
                 return ListTile(
                   title: Text(state.settingList[index]['title'],style: AppTextStyle.titleStyle16bw,),
                   trailing: Switch(
                       value: state.settingList[index]['status'],
                       inactiveThumbColor: AppColors.white,
                       inactiveTrackColor: AppColors.lightWhite,
                       activeColor: AppColors.primary,
                       activeTrackColor: AppColors.white,
                       onChanged: (value){
                         print('pressed .....');
                       context.read<SettingBloc>().add(SettingToggle(index));
                   }),
                 );
               }
               ):Center(
                 child: Text('Data is loading ....',style: AppTextStyle.titleStyle20bw,textAlign: TextAlign.center,),
               ),
             ),
           );
         }),
       ),
     );
  }
}