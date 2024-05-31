
import 'package:agri_app_2/order/bloc/order_bloc.dart';
import 'package:agri_app_2/order/bloc/order_event.dart';
import 'package:agri_app_2/order/bloc/order_state.dart';
import 'package:agri_app_2/order/domain/order_model.dart';
import 'package:agri_app_2/order/domain/update_order_model.dart';
import 'package:agri_app_2/order/infrastructure/repository/order_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'order_bloc_test.mocks.dart';

@GenerateMocks([OrderRepository])
void main() {
  late OrderBloc orderBloc;
  late MockOrderRepository mockOrderRepository;

  setUp(() {
    mockOrderRepository = MockOrderRepository();
    orderBloc = OrderBloc(mockOrderRepository);
  });

  tearDown(() {
    orderBloc.close();
  });

  group('OrderBloc', () {
    final testOrder = Order(cropId: '1', quantity: '10'); // Replace with actual Order model attributes
    final updatedOrder = UpdateOrderDto(quantity: '9'); // Replace with actual UpdateOrderDto attributes

    blocTest<OrderBloc, OrderState>(
      'emits [OrderLoadingState, OrderSuccessState] when CreateOrderEvent is added',
      build: () {
        when(mockOrderRepository.createOrder(any)).thenAnswer((_) async => testOrder);
        return orderBloc;
      },
      act: (bloc) => bloc.add(CreateOrderEvent(testOrder)),
      expect: () => [
        OrderLoadingState(),
        const OrderSuccessState('Order created successfully!'),
      ],
    );

    blocTest<OrderBloc, OrderState>(
      'emits [OrderLoadingState, OrderSuccessState] when DeleteOrderEvent is added',
      build: () {
        when(mockOrderRepository.deleteOrder(any)).thenAnswer((_) async => Future.value());
        return orderBloc;
      },
      act: (bloc) => bloc.add(const DeleteOrderEvent('1')),
      expect: () => [
        OrderLoadingState(),
        const OrderSuccessState('Order deleted successfully!'),
      ],
    );

    blocTest<OrderBloc, OrderState>(
      'emits [OrderLoadingState, OrderSuccessState] when UpdateOrderEvent is added',
      build: () {
        when(mockOrderRepository.updateOrder(any, any)).thenAnswer((_) async => updatedOrder);
        return orderBloc;
      },
      act: (bloc) => bloc.add(UpdateOrderEvent(orderId: '1', order: updatedOrder)),
      expect: () => [
        OrderLoadingState(),
        const OrderSuccessState('Order updated successfully!'),
      ],
    );

    blocTest<OrderBloc, OrderState>(
      'emits [OrderLoadingState, OrderLoadedState] when GetOrdersByIdEvent is added',
      build: () {
        when(mockOrderRepository.getOrderById(any)).thenAnswer((_) async => [testOrder]);
        return orderBloc;
      },
      act: (bloc) => bloc.add(GetOrdersByIdEvent(orderId: 1)),
      expect: () => [
        OrderLoadingState(),
        OrderLoadedState([testOrder]),
      ],
    );

    blocTest<OrderBloc, OrderState>(
      'emits [OrdersLoadingState, OrderLoadedState] when GetOrdersEvent is added',
      build: () {
        when(mockOrderRepository.getOrders()).thenAnswer((_) async => [testOrder]);
        return orderBloc;
      },
      act: (bloc) => bloc.add(const GetOrdersEvent()),
      expect: () => [
        const OrdersLoadingState(),
        OrderLoadedState([testOrder]),
      ],
    );

    blocTest<OrderBloc, OrderState>(
      'emits [OrdersLoadingState, OrderLoadedState] when GetAllOrdersEvent is added',
      build: () {
        when(mockOrderRepository.getAllOrders()).thenAnswer((_) async => [testOrder]);
        return orderBloc;
      },
      act: (bloc) => bloc.add(const GetAllOrdersEvent()),
      expect: () => [
        const OrdersLoadingState(),
        OrderLoadedState([testOrder]),
      ],
    );
  });
}