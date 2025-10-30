import 'package:bloc_project/data/models/get_user_model.dart';
import 'package:equatable/equatable.dart';

class PersonState extends Equatable{
  final UserModel? userModel;
   const PersonState({this.userModel});

   @override
  List<Object?> get props => [userModel];
}

class PersonInitial extends PersonState{

}
class PersonLoading extends PersonState {
}

class PersonError extends PersonState{
  final String profileError;
 const  PersonError(this.profileError);

  @override
  List<Object?> get props => [profileError];
}

