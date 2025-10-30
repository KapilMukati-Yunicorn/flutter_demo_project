import 'package:bloc_project/logic/bottom_nav/bottom_nav_bloc.dart';
import 'package:bloc_project/logic/bottom_nav/bottom_nav_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/icons_constant.dart';
import '../../core/constants/image_constants.dart';
import '../../core/widgets/common_widgets.dart';
import '../../logic/bottom_nav/bottom_nav_event.dart';

class CustomNavBar {
   Widget appNavBar(){
    return BlocBuilder<BottomNavBloc,BottomNavState>(
      builder: (context,state){
        return Container(
          height: 100.h,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    ImageConstants.imgBottomNavBg,

                  ),
                  fit: BoxFit.fill
              )
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              navBarButton(
                  currentIndex: state.index,
                  index: 0,
                  onTap: (){
                    context.read<BottomNavBloc>().add(BottomNavItemSelected(0));
                  }
              ),
              navBarButton(
                  currentIndex: state.index,
                  index: 1,
                  onTap: (){
                    context.read<BottomNavBloc>().add(BottomNavItemSelected(1));
                  }
              ),
              navBarButton(
                  currentIndex: state.index,
                  index: 2,
                  onTap: (){
                    context.read<BottomNavBloc>().add(BottomNavItemSelected(2));
                  }
              ),
              navBarButton(
                  currentIndex: state.index,
                  index: 3,
                  onTap: (){
                    context.read<BottomNavBloc>().add(BottomNavItemSelected(3));
                  }
              ),
              navBarButton(
                  currentIndex: state.index,
                  index: 4,
                  onTap: (){
                    context.read<BottomNavBloc>().add(BottomNavItemSelected(4));
                  }
              ),




            ],
          ),
        );
      },
    );
}

   Widget navBarButton({required int currentIndex,required int index,Function()? onTap}){

    List<String> tabIconList=[
      IconConstants.icBicycle,IconConstants.icMap,IconConstants.icCart,IconConstants.icPerson,IconConstants.icDoc,
    ];
    return Expanded(
      flex: 1,
      child:GestureDetector(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if(currentIndex==index)
              Padding(
                padding:  EdgeInsets.only(bottom: 10.h),
                child: CommonWidgets.appIcons(
                    assetName:IconConstants.icTabBg ,
                    height: 90.h,
                    width: 80.h,
                    fit: BoxFit.fill
                ),
              ),
            Padding(
              padding:  EdgeInsets.only(bottom: currentIndex==index?45.h:10,right: 10.w),
              child: CommonWidgets.appIcons(assetName: tabIconList[index],
                  height: 20.h,
                  width: 20.w
              ),
            ),

          ],
        ),
      ),
    );
  }
}