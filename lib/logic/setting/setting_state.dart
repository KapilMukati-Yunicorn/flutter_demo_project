import 'package:equatable/equatable.dart';

class SettingState extends Equatable{
  final int refreshing;
   final List<Map<String,dynamic>> settingList;
  const SettingState({this.settingList=const [],this.refreshing=0});

  @override
  List<Object?> get props => [settingList];
}