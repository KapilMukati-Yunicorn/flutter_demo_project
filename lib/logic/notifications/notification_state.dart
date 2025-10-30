import 'package:equatable/equatable.dart';

class NotificationState extends Equatable{
  final List<Map<String,String>> notificationList;
  const NotificationState({this.notificationList=const []});

  @override
  List<Object?> get props => [notificationList];

}
