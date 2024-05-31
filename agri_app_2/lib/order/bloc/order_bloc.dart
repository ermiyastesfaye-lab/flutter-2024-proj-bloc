import 'package:agri_app_2/order/bloc/order_event.dart';
import 'package:agri_app_2/order/bloc/order_state.dart';
import 'package:agri_app_2/order/model/order_model.dart';
import 'package:agri_app_2/order/model/update_order_model.dart';
import 'package:agri_app_2/order/repository/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository
      orderRepository; // Use OrderRepository instead of OrderDataProvider

  OrderBloc(this.orderRepository) : super(OrderInitialState()) {
    on<CreateOrderEvent>((event, emit) => _createOrder(event.order, emit));
    on<DeleteOrderEvent>((event, emit) => _deleteOrder(event.orderId, emit));
    on<UpdateOrderEvent>(
        (event, emit) => _updateOrder(event.orderId, event.order, emit));
    on<GetOrdersByIdEvent>(
        (event, emit) => _getOrderById(event.orderId, emit));
    on<GetOrdersEvent>((event, emit) => _getOrders(emit));
    on<GetAllOrdersEvent>((event, emit) => _getAllOrders(emit));

  }

  Future<void> _createOrder(Order order, Emitter<OrderState> emit) async {
    try {
      emit(OrderLoadingState());
      await orderRepository
          .createOrder(order);
      emit(const OrderSuccessState("Order created successfully!"));
    } catch (error) {
      emit(OrderErrorState(error.toString()));
    }
  }

  Future<void> _deleteOrder(String? orderId, Emitter<OrderState> emit) async {
    try {
      emit(OrderLoadingState());
      await orderRepository
          .deleteOrder(orderId); // Use OrderRepository instead of OrderDataProvider
      emit(const OrderSuccessState("Order deleted successfully!"));
    } catch (error) {
      emit(OrderErrorState(error.toString()));
    }
  }

  Future<void> _updateOrder(
      String orderId, UpdateOrderDto order, Emitter<OrderState> emit) async {
    try {
      emit(OrderLoadingState());
      await orderRepository.updateOrder(
          orderId, order);
      emit(const OrderSuccessState("Order updated successfully!"));
      // emit(OrderLoadedState(Orders));

    } catch (error) {
      emit(OrderErrorState(error.toString()));
    }
  }

  Future<void> _getOrderById(int OrderId, Emitter<OrderState> emit) async {
    try {
      emit(OrderLoadingState());
      final orders = await orderRepository.getOrderById(
          OrderId); // Use OrderRepository instead of OrderDataProvider
      emit(OrderLoadedState(orders));
    } catch (error) {
      emit(OrderErrorState(error.toString()));
    }
  }

  Future<void> _getOrders(Emitter<OrderState> emit) async {
    try {
      emit(const OrdersLoadingState());
      final orders = await orderRepository.getOrders(); // Use OrderRepository instead of OrderDataProvider
      emit(OrderLoadedState(orders));
    } catch (error) {
      emit(OrderErrorState(error.toString()));
      // emit(
      //     OrderInitialState()); // Revert back to initial state if an error occurs
    }
  }

  Future<void> _getAllOrders(Emitter<OrderState> emit) async {
    try {
      emit(const OrdersLoadingState());
      final crops = await orderRepository.getAllOrders(); // Use CropRepository instead of CropDataProvider
      emit(OrderLoadedState(crops));
    } catch (error) {
      emit(OrderErrorState(error.toString()));
      // emit(
      //     CropInitialState()); // Revert back to initial state if an error occurs
    }
  }
  
}
