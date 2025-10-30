import 'package:bloc_project/logic/notifications/notification_event.dart';
import 'package:bloc_project/logic/notifications/notification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationBloc extends Bloc<NotificationEvent,NotificationState>{
  NotificationBloc():super(NotificationState()){
   on<NotificationsLoading>((event,emit){
     emit(NotificationState(
         notificationList: [
       {'title':'Your order conformed !',
         'message':'Your order conformed now . your order delivered after 2 days,your order id is YC13543' ,
         'date':'2 days ago'
       },
           {'title':'Your order cancelled !',
             'message':'Your order cancelled now . your order cancelled due to incorrect phone nu.,your order id is YC13543' ,
             'date':'3 days ago'
           },
           {'title':'Your order conformed !',
             'message':'Your order conformed now . your order delivered after 2 days,your order id is YC13543' ,
             'date':'4 days ago'
           },
           {'title':'Your order cancelled !',
             'message':'Your order cancelled now . your order cancelled due to incorrect phone nu.,your order id is YC13543' ,
             'date':'5 days ago'
           },
     ]
     ));
   });
  }
}