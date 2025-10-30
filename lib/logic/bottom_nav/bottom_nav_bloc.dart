import 'package:bloc_project/logic/bottom_nav/bottom_nav_event.dart';
import 'package:bloc_project/logic/bottom_nav/bottom_nav_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBloc extends Bloc<BottomNavEvent,BottomNavState>{

  BottomNavBloc():super(BottomNavState.initial()){
    on<BottomNavItemSelected>((event,emit){
       emit(state.copyWith(index: event.index));
    });
  }

}