import 'package:bloc_project/core/colors/colors.dart';
import 'package:bloc_project/core/constants/icons_constant.dart';
import 'package:bloc_project/core/constants/length.dart';
import 'package:bloc_project/core/themes/app_text_style.dart';
import 'package:bloc_project/core/widgets/common_widgets.dart';
import 'package:bloc_project/logic/edit_profile/edit_profile_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bloc_project/logic/person/person_bloc.dart';
import 'package:bloc_project/logic/person/person_event.dart';
import 'package:bloc_project/logic/person/person_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/string_constants.dart';
import '../../data/models/get_user_model.dart';

class PersonScreen extends StatefulWidget {
  const PersonScreen({super.key});

  @override
  State<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  List<Map<String,dynamic>> itemList=[
    {
      'title':StringConstants.editProfile,
      'icon':Icons.person
    },
    {
      'title':StringConstants.deliveryAddress,
      'icon':Icons.delivery_dining_outlined
    },
    {
      'title':StringConstants.orderHistory,
      'icon':Icons.local_shipping
    },
    {
      'title':StringConstants.reels,
      'icon':Icons.video_call_outlined
    },
    {
      'title':StringConstants.notifications,
      'icon':Icons.notifications
    },
    {
      'title':StringConstants.settings,
      'icon':Icons.settings
    },
    {
      'title':StringConstants.logout,
      'icon':Icons.logout
    },
  ];
  @override
  void initState() {
    super.initState();
    context.read<PersonBloc>().add(PersonDataLoad());

  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PersonBloc, PersonState>(
      listener: (context, state) {
        if (state is PersonError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.profileError)),
          );
        }
      },
      child: BlocBuilder<PersonBloc, PersonState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.primary,
            body:Container(

              child:  state is PersonLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: AppLength.screenFullHeight()*0.3,
                        child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height:100.h,
                                            width: 100.h,
                                            decoration:BoxDecoration(
                                              color: AppColors.primary2,
                                             shape: BoxShape.circle,
                                              border: Border.all(color: AppColors.white,
                                              width: 2.w)
                                        ),
                                            child: CommonWidgets.appIcons(
                                              assetName: state.userModel?.image??'',
                                              height: 100

                                            ),
                                          ),
                        CommonWidgets.verticalSpace(height: 20),
                        Text('${state.userModel?.name}',style: AppTextStyle.titleStyle20bw,),
                        Text('${state.userModel?.email}',style: AppTextStyle.titleStyle14bw,),
                                        ],
                                      ),
                      ),
                      Expanded(
                        child: Container(
                         // height: AppLength.screenFullHeight()*0.55,
                          width: AppLength.screenFullWidth(),
                          padding: EdgeInsets.only(top: 20.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(50.r)),
                            color: AppColors.backGroundColor
                          ),
                          child: ListView.builder(
                             itemCount: itemList.length,
                             padding: EdgeInsets.symmetric(vertical: 10.h),
                             shrinkWrap: true,
                             itemBuilder: (context,index){
                                return Column(
                                  children: [
                                    ListTile(
                                onTap:(){
                                  context.read<PersonBloc>().add(ClickOnItemMenu(index));
                                },
                                      title: Text(itemList[index]['title'],style: AppTextStyle.titleStyle16bw,),
                                      leading: Icon(itemList[index]['icon'],size: 25.h,color: AppColors.white,),
                                      trailing: Icon(Icons.arrow_forward_ios_sharp,size: 20.h,color: AppColors.lightWhite,),
                                    ),
                                    Divider(thickness: 1.h,color: AppColors.lightWhite,),
                                    CommonWidgets.verticalSpace(height: 10)
                                  ],
                                );
                          }),

                        ),
                      )
                    ],
                  )
            )
          );
        },
      ),
    );
  }

}
