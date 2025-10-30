import 'package:equatable/equatable.dart';

import '../../data/models/get_user_model.dart';

abstract class EditProfileEvent extends Equatable{
   const EditProfileEvent();
   @override
  List<Object?> get props => [];

}

class FetchProfileData extends EditProfileEvent{
  final UserModel userModel;
  const FetchProfileData(this.userModel);
  @override
  List<Object?> get props => [userModel];

}
class ChangeEmail extends EditProfileEvent{
  final String email;
  const ChangeEmail(this.email);
  @override
  List<Object?> get props => [email];
}

class ChangeName extends EditProfileEvent{
  final String name;
  const ChangeName(this.name);
  @override
  List<Object?> get props => [name];
}

class ChangePhone extends EditProfileEvent{
  final String phone;
  const ChangePhone(this.phone);
  @override
  List<Object?> get props => [phone];
}

class ChangeAddress extends EditProfileEvent{
  final String address;
  const ChangeAddress(this.address);
  @override
  List<Object?> get props => [address];
}
class UpdateProfileData extends EditProfileEvent{

}