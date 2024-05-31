import 'package:agri_app_2/order/presentation/order_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agri_app_2/crop/model/crop_model.dart';
import 'package:agri_app_2/crop/presentation/crop_management.dart';
import 'package:agri_app_2/order/bloc/order_bloc.dart';
import 'package:agri_app_2/order/bloc/order_event.dart';
import 'package:agri_app_2/order/model/order_model.dart';
import 'package:agri_app_2/presentation/data/dummy_data.dart';
import 'package:agri_app_2/presentation/widget/app_bar.dart';
import 'package:agri_app_2/presentation/widget/bottom_nav_bar.dart';
import 'package:agri_app_2/presentation/widget/logo.dart';
import 'package:agri_app_2/presentation/widget/menu_bar.dart';

class OrderPage extends StatefulWidget {
  final Crop crop;
  const OrderPage({Key? key, required this.crop}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int _quantity = 0;
   String _userRole = '';

  Future<void> _getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userRole = prefs.getString('role') ?? 'BUYER'; // Default to 'user' if not found
    });
  }

  void _incrementQuantity() {
    setState(() {
      if (_quantity < 100) {
        _quantity++;
      }
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 0) {
        _quantity--;
      }
    });
  }

  Future<void> _submitOrder(BuildContext context, String userRole) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final userId = sharedPreferences.getInt('userId');

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User ID not found. Please log in again.'),
        ),
      );
      return;
    }

    final order = Order(
      cropId: widget.crop.cropId.toString(),
      quantity: _quantity.toString(),
    );

    BlocProvider.of<OrderBloc>(context).add(CreateOrderEvent(order));

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Order Created Successfully'),
          content: const Text('Your order has been created successfully.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (userRole == "BUYER") {
            GoRouter.of(context).go("/orderDisplayBuyer");
          } else {
            GoRouter.of(context).go("/cropManagement");
          }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _getUserRole();

    return Scaffold(
      appBar: AppBarWidget(userRole: _userRole),
      drawer: MenuBarWidget(userRole: _userRole),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Opacity(
              opacity: 0.5,
              child: IgnorePointer(
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 19, vertical: 10
                        ),
                        child: LogoWidget(logo: logos[1]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(15),
              height: 460,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color.fromARGB(255, 246, 246, 246),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Crop Details',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: myColor.tertiary,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Crop Name: ${widget.crop.cropName}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: myColor.primary,
                        ),
                      ),
                      Text(
                        'Crop Type: ${widget.crop.cropType}',
                        style: TextStyle(
                          fontSize: 15,
                          color: myColor.tertiary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Planting Date: ${widget.crop.plantingDate}',
                        style: TextStyle(
                          fontSize: 15,
                          color: myColor.primary,
                        ),
                      ),
                      Text(
                        'Harvesting Date: ${widget.crop.harvestingDate}',
                        style: TextStyle(
                          fontSize: 15,
                          color: myColor.tertiary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Price: \$${widget.crop.price}',
                    style: TextStyle(
                      fontSize: 15,
                      color: myColor.primary,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Order Quantity',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: myColor.tertiary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: _decrementQuantity,
                      ),
                      Text(
                        '$_quantity',
                        style: TextStyle(
                          fontSize: 20,
                          color: myColor.primary,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: _incrementQuantity,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _submitOrder(context, _userRole),
                      child: const Text('Submit Order'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(userRole: _userRole),
    );
  }
}
