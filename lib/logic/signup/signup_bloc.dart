import 'dart:io';

import 'package:bloc_project/core/navigation/navigation_service.dart';
import 'package:bloc_project/core/utils/app_image_picker.dart';
import 'package:bloc_project/logic/signup/signup_event.dart';
import 'package:bloc_project/logic/signup/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SignUpBloc extends Bloc<SignUpEvent,SignUpState>{
     SignUpBloc():super(SignUpState.initial()){
        on<UserNameChange>((event,emit){
          emit(state.copyWith(userName: event.userName));
        });
        on<EmailChange>((event,emit){
          emit(state.copyWith(email: event.email));
        });
        on<PasswordChange>((event,emit){
          emit(state.copyWith(password: event.password));
        });
        on<CnfPasswordChange>((event,emit){
          emit(state.copyWith(cnfPassword: event.cnfPassword));
        });

        on<PickUserProfile>((event,emit)async{
          File? selectImage=await AppImagePickerAndCropper.pickImage();
          if(selectImage!=null){
            emit(state.copyWith(userProfile: selectImage));
          }

        });

        on<ClickOnSignUpButton>((event,emit) async{
          emit(state.copyWith(isFailure: false,isSubmitting: true,isSuccess: false));
          try{
            await Future.delayed(const Duration(seconds: 2));
            emit(state.copyWith(isFailure: false,isSubmitting: false,isSuccess: true));
             NavigationService.pop();
          }catch(e){
            emit(state.copyWith(isFailure: true,isSubmitting: false,isSuccess: false));
          }
        });

        on<ClickOnLoginButton>((event,emit){
          NavigationService.pop();
        });
     }

}