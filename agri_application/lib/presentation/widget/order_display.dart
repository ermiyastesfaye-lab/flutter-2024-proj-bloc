import 'package:agri_app_2/order/bloc/order_bloc.dart';
import 'package:agri_app_2/order/bloc/order_event.dart';
import 'package:agri_app_2/order/model/order_model.dart';
import 'package:agri_app_2/order/presentation/order_display.dart';
import 'package:agri_app_2/presentation/data/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDisplayWidget extends StatelessWidget {
  final Order order;
  const OrderDisplayWidget({super.key, required this.order});

  @override
  Widget build(context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/fruits.jpg',
                  width: 100,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (order.cropType != null)
                      Text(
                        'Crop Name: ${order.cropName}',
                        style: TextStyle(color: myColor.primary),
                      ),
                    Row(
                      children: [
                        Text(
                          'Crop Type: ${order.cropType}',
                          style: TextStyle(color: myColor.primary),
                        ),
                        Text('(${order.orderId})',
                            style: const TextStyle(color: Colors.black)),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: myColor.secondary,
                      ),
                      child: const Row(
                        children: [
                          Text('Sold',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white))
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            TextButton.icon(
                style: TextButton.styleFrom(iconColor: myColor.primary),
                onPressed: () {
                  _deleteOrder(context, order.orderId!);
                },
                icon: const Icon(Icons.delete),
                label: const Text(''))
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          thickness: 2,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  void _deleteOrder(BuildContext context, orderId) {
    BlocProvider.of<OrderBloc>(context).add(DeleteOrderEvent(orderId));

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Order Deleted Successfully'),
            content: const Text('Your Order has been deleted successfully.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                   Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const OrderDisplayScreen()));
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
  }
}
