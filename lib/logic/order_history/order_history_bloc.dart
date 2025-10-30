import 'package:bloc_project/data/local_data/local_data.dart';
import 'package:bloc_project/logic/order_history/order_history_event.dart';
import 'package:bloc_project/logic/order_history/order_history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent,OrderHistoryState>{

  OrderHistoryBloc():super(OrderHistoryState()){
    on<OrderHistoryLoaded>((event,emit){
      emit(OrderHistoryState(orderHistoryList: LocalData.productList));
    });
  }

}