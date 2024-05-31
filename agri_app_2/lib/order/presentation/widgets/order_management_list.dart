import 'package:agri_app_2/crop/domain/crop_model.dart';
import 'package:agri_app_2/order/presentation/pages/order.dart';
import 'package:agri_app_2/auth/domain/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrderListManagement extends StatelessWidget {
  final Crop  crop;

  const OrderListManagement({super.key, required this.crop});

  @override
  Widget build(context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 12, 0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Center(
                  child: Image.asset(
               'assets/fruits.jpg',
                width: 150,
              ))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    crop.price,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: myColor.tertiary),
                  ),
                  Text(
                    crop.cropName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: myColor.tertiary),
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: () {
              GoRouter.of(context).go("/order", extra: crop);
                },
                icon: Icon(Icons.shopping_cart, color: myColor.tertiary),
                label: const Text(''),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
