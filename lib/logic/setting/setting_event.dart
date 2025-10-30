import 'package:equatable/equatable.dart';

abstract class SettingEvent extends Equatable{
  const SettingEvent();

  @override
  List<Object?> get props => [];
}

class SettingLoading  extends  SettingEvent{

}

class SettingToggle extends SettingEvent{
  final int index;
  const SettingToggle(this.index);

  @override
  List<Object?> get props => [index];
}