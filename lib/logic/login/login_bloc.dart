import 'package:bloc_project/core/navigation/navigation_service.dart';
import 'package:bloc_project/logic/login/login_event.dart';
import 'package:bloc_project/logic/login/login_state.dart';
import 'package:bloc_project/routes/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{
  LoginBloc():super(LoginState.initial()){
    on<EmailChange>((event,emit){
     emit(state.copyWith(email: event.email));
    });

    on<PasswordChange>((event,emit){
      emit(state.copyWith(password: event.password));
    });

    on<ClickOnLoginButton>((event,emit) async{
      emit(state.copyWith(isFailure: false,isSubmitting: true,isSuccess: false));
      try{
        await Future.delayed(const Duration(seconds: 2));
        emit(state.copyWith(isFailure: false,isSubmitting: false,isSuccess: true));
        NavigationService.pushReplacementNamed(AppRoutes.bottomNav);
      }catch(e){
        emit(state.copyWith(isFailure: true,isSubmitting: false,isSuccess: false));
      }
    });

    on<ClickOnSignUpButton>((event,emit){
      NavigationService.pushNamed(AppRoutes.signup);
    });
  }


}
