import 'package:equatable/equatable.dart';

import '../../data/models/get_user_model.dart';

abstract class PersonEvent extends Equatable{
  const PersonEvent();

  @override
  List<Object?> get props => [];
}
class PersonDataLoad extends PersonEvent{

}
class PersonDataUpdate extends PersonEvent{
  final UserModel userModel;
  const PersonDataUpdate(this.userModel);
  @override
  List<Object?> get props => [userModel];
}
class ClickOnItemMenu extends PersonEvent{
   final int index;
   const ClickOnItemMenu(this.index);

@override
  List<Object?> get props => [index];
}