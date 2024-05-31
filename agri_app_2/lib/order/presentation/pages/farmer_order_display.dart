
import 'package:agri_app_2/order/bloc/order_bloc.dart';
import 'package:agri_app_2/order/bloc/order_event.dart';
import 'package:agri_app_2/order/bloc/order_state.dart';
import 'package:agri_app_2/order/domain/order_model.dart';
import 'package:agri_app_2/auth/domain/dummy_data.dart';
import 'package:agri_app_2/auth/presentation/widgets/app_bar.dart';
import 'package:agri_app_2/auth/presentation/widgets/bottom_nav_bar.dart';
import 'package:agri_app_2/auth/presentation/widgets/logo.dart';
import 'package:agri_app_2/auth/presentation/widgets/menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FarmerOrderDisplay extends StatefulWidget {
  const FarmerOrderDisplay({super.key});

  @override
  State<FarmerOrderDisplay> createState() => _FarmerOrderDisplayState();
}

class _FarmerOrderDisplayState extends State<FarmerOrderDisplay> {// Initialize quantities with the correct length
  List<Order> orders = [];
  List<int> quantities = [];
   String _userRole = '';

  Future<void> _getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userRole = prefs.getString('role') ?? 'BUYER'; // Default to 'user' if not found
    });
  }

  @override
  void initState() {
    super.initState();
    _getAllOrders();
  }

  Future<void> _getAllOrders() async {
    await _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    try {
      BlocProvider.of<OrderBloc>(context).add(const GetAllOrdersEvent());

      final ordersState = await BlocProvider.of<OrderBloc>(context).stream.firstWhere(
        (state) => state is OrderLoadedState,
        orElse: () => OrderLoadingState(),
      );

      if (ordersState is OrderLoadedState) {
        setState(() {
          orders = ordersState.orders;
          quantities = List.generate(orders.length, (index) => int.parse(orders[index].quantity) ?? 0); // Initialize quantities with order.quantity
        });
      }
    } catch (e) {
      print('Error fetching orders: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    _getUserRole();
    return Scaffold(
      appBar: AppBarWidget(userRole: _userRole),
      drawer: MenuBarWidget(userRole: _userRole),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        constraints: const BoxConstraints(maxWidth: 700.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: LogoWidget(logo: logos[1]),
            ),
            const SizedBox(height: 16),
            Text(
              'Orders',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: myColor.tertiary),
            ),
            const SizedBox(height: 16), // Add spacing between Orders and list
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: orders.length, // Use the length of the orders list
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final order = orders[index]; // Get the order from the list
                  String itemName = order.cropName!;
                  String imagePath =
                      'assets/fruits.jpg'; // Replace with the actual image path
                  Widget quantity = SizedBox(
                    width: 150,
                    child: QualityListItem(
                      quantity: quantities[index],
                      onIncrement: () => _incrementQuality(index, quantities),
                      onDecrement: () => _decrementQuality(index, quantities),
                    ),
                  );
                  return Row(
                    children: [
                      Image.asset(
                        imagePath,
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  itemName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: myColor.tertiary),
                                ),
                                quantity
                              ],
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                GoRouter.of(context).go("/marketPlace");
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: myColor.secondary,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Sell'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(userRole: _userRole),
    );
  }

  void _incrementQuality(int index, List<int> quantities) {
  int initialQuantity = int.parse(orders[index].quantity) ?? 0;
  setState(() {
    if (quantities[index] < initialQuantity) {
      quantities[index]++;
    }
  });
}

  void _decrementQuality(int index, quantities){
    setState(() {
      if (quantities[index] > 0) {
        quantities[index]--;
      }
    });
  }
}

class QualityListItem extends StatefulWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QualityListItem({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  State<QualityListItem> createState() => _QualityListItemState();
}

class _QualityListItemState extends State<QualityListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          IconButton(
            onPressed: widget.onDecrement,
            icon: const Icon(Icons.remove),
          ),
          Text(
            '${widget.quantity}',
            style: TextStyle(
                fontSize: 20,
                color: myColor.primary,
                fontWeight: FontWeight.bold), 
          ),
          IconButton(
            onPressed: widget.onIncrement,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
