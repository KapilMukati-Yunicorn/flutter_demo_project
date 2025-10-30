import 'package:bloc/bloc.dart';
import 'package:bloc_project/core/constants/icons_constant.dart';
import 'package:bloc_project/core/constants/image_constants.dart';
import 'package:bloc_project/core/navigation/navigation_service.dart';
import 'package:bloc_project/core/widgets/common_widgets.dart';
import 'package:bloc_project/data/models/get_user_model.dart';
import 'package:bloc_project/logic/person/person_event.dart';
import 'package:bloc_project/logic/person/person_state.dart';
import 'package:bloc_project/logic/splash/splash_bloc.dart';
import 'package:bloc_project/logic/splash/splash_event.dart';
import 'package:bloc_project/routes/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonBloc extends Bloc<PersonEvent,PersonState>{

  PersonBloc():super(PersonInitial()){
    on<PersonDataLoad>((event,emit){
      emit(PersonLoading());

      emit(PersonState(userModel: UserModel(
          id: '1',
          name: 'Arvind Kumar',
          email: 'arvind@gmail.com',
          phone: '9352792687',
          address: 'Indore ,Vijay Nagar',
          image: ImageConstants.imgHelmet
      )));
    });

    on<ClickOnItemMenu>(_clickOnItemMenu);
    on<PersonDataUpdate>((event,emit){
      emit(PersonState(userModel: event.userModel));
      print('Also update person profile....${state.userModel!.name}');
    });
  }

  void _clickOnItemMenu(ClickOnItemMenu event, Emitter<PersonState> emit) async{
    switch (event.index){
      case 0: {
          NavigationService.pushNamed(AppRoutes.editProfile,arguments: state.userModel);
      } break;
      case 1: {
        NavigationService.pushNamed(AppRoutes.deliveryAddress);
      } break;
      case 2: {
        NavigationService.pushNamed(AppRoutes.orderHistory);
      } break;
      case 3: {
        NavigationService.pushNamed(AppRoutes.cacheReel);
      } break;
      case 4: {
        NavigationService.pushNamed(AppRoutes.notifications);
      } break;
      case 5: {
        NavigationService.pushNamed(AppRoutes.setting);
      } break;

      case 6:{
        CommonWidgets.showAlertDialog(
          onPressedYes: (){
            // NavigationService.navigatorKey.currentContext!.read<SplashBloc>().add(SplashStarted());
            // NavigationService.popUntilRoot();
            // NavigationService.pushReplacementNamed(AppRoutes.splash);
          }
        );
      }break;
    }
  }
}