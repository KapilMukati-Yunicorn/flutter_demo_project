import 'package:bloc_project/data/models/get_user_model.dart';
import 'package:bloc_project/logic/edit_profile/edit_profile_event.dart';
import 'package:bloc_project/logic/edit_profile/edit_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileBloc extends Bloc<EditProfileEvent,EditProfileState>{
  EditProfileBloc():super(EditProfileState.initial()){
    on<FetchProfileData>((event,emit){
      emit(state.copyWith(userModel: event.userModel,
      email: event.userModel.email,name: event.userModel.name,phone: event.userModel.phone,
      address: event.userModel.address,));

  });
    on<UpdateProfileData>(_updateProfileData);
    on<ChangeEmail>((event,emit){
      emit(state.copyWith(email: event.email));
    });
    on<ChangeName>((event,emit){
      emit(state.copyWith(name: event.name));
    });
    on<ChangePhone>((event,emit){
      emit(state.copyWith(phone: event.phone));
    });
    on<ChangeAddress>((event,emit){
      emit(state.copyWith(address: event.address));
    });

  }

  void _updateProfileData(UpdateProfileData event, Emitter<EditProfileState> emit)async{
    emit(state.copyWith(isSubmitting: true,isFailure: false,isSuccess: false));
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(
        userModel: UserModel(id:state.userModel!.id,name: state.name,email: state.email,
        phone: state.phone,address: state.address,image: state.userModel!.image)
    ));
    emit(state.copyWith(isSubmitting: false,isFailure: false,isSuccess: true));

  }
}