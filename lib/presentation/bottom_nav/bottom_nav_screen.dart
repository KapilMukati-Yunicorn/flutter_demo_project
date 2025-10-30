import 'package:bloc_project/core/colors/colors.dart';
import 'package:bloc_project/core/keys/widget_keys.dart';
import 'package:bloc_project/logic/bottom_nav/bottom_nav_bloc.dart';
import 'package:bloc_project/logic/bottom_nav/bottom_nav_state.dart';
import 'package:bloc_project/presentation/bicycle/bicycle_screen.dart';
import 'package:bloc_project/presentation/bottom_nav/custom_nav_bar.dart';
import 'package:bloc_project/presentation/cart/cart_screen.dart';
import 'package:bloc_project/presentation/favorite/favorite_screen.dart';
import 'package:bloc_project/presentation/map/map_screen.dart';
import 'package:bloc_project/presentation/person/person_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../reel/reel_dipseek_screen.dart';


class BottomNavScreen extends StatelessWidget{
     const BottomNavScreen({super.key});

    final List<Widget> tabScreens=const [BiCycleScreen(),MapScreen(),CartScreen(),PersonScreen(),FavoriteScreen()];
    //final List<Widget> tabScreens=const [BiCycleScreen(),ReelScreen(),CartScreen(),PersonScreen(),FavoriteScreen()];
   // final List<Widget> tabScreens=const [BiCycleScreen(),CacheReelScreen(),CartScreen(),PersonScreen(),FavoriteScreen()];
     @override
  Widget build(BuildContext context) {
    return BlocListener<BottomNavBloc,BottomNavState>(
      listener: (context,state){

      },
      child:  BlocBuilder<BottomNavBloc,BottomNavState>(
          builder: (context,state){
            return  Scaffold(
              key:  WidgetKeys.bottomNavBar,
             backgroundColor: AppColors.backGroundColor,
              bottomNavigationBar: CustomNavBar().appNavBar(),
             // body: tabScreens[state.index],
              body: IndexedStack(
                index: state.index,
                children: tabScreens,
              ),


            );
          }
      )
    );
  }

}