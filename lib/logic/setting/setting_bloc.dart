import 'package:bloc_project/logic/setting/setting_event.dart';
import 'package:bloc_project/logic/setting/setting_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingBloc extends  Bloc<SettingEvent,SettingState>{
  int _refreshCount=1;
  SettingBloc():super(SettingState()){
    on<SettingLoading>((event,emit){
      emit(SettingState(
        settingList: [
          {
            'title':'App Update',
            'status':false,
          },
          {
            'title':'Offer Update',
            'status':false,
          },
          {
            'title':'Sound',
            'status':false,
          },
          {
            'title':'Vibration',
            'status':false,
          }
        ]
      ));
    });
    on<SettingToggle>((event,emit){
      _refreshCount++;
      List<Map<String, dynamic>> updatedList = List<Map<String, dynamic>>.from(state.settingList);
      updatedList[event.index] = Map<String, dynamic>.from(updatedList[event.index]);
      updatedList[event.index]['status'] = !(updatedList[event.index]['status']);

      emit(SettingState(settingList: updatedList, refreshing: _refreshCount));

    });
  }
}