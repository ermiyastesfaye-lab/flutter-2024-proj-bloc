import 'package:agri_app_2/crop/bloc/crop_bloc.dart';
import 'package:agri_app_2/crop/bloc/crop_event.dart';
import 'package:agri_app_2/order/bloc/order_bloc.dart';
import 'package:agri_app_2/order/bloc/order_event.dart';
import 'package:agri_app_2/order/bloc/order_state.dart';
import 'package:agri_app_2/order/domain/order_model.dart';
import 'package:agri_app_2/auth/domain/dummy_data.dart';
import 'package:agri_app_2/auth/presentation/widgets/app_bar.dart';
import 'package:agri_app_2/auth/presentation/widgets/bottom_nav_bar.dart';
import 'package:agri_app_2/auth/presentation/widgets/logo.dart';
import 'package:agri_app_2/auth/presentation/widgets/menu_bar.dart';
import 'package:agri_app_2/order/presentation/widgets/order_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDisplayScreen extends StatefulWidget {
  const OrderDisplayScreen({super.key});

  @override
  _OrderDisplayScreenState createState() => _OrderDisplayScreenState();
}

class _OrderDisplayScreenState extends State<OrderDisplayScreen> {
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
    _getOrders();
    // Add any initialization logic here
    // For example, you might want to fetch data from a server
  }

  Future<void> _getOrders() async {
    _fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    _getUserRole();

    return Scaffold(
      appBar: AppBarWidget(userRole: _userRole),
      drawer: MenuBarWidget(userRole: _userRole),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: LogoWidget(logo: logos[1]),
              ),
              const SizedBox(height: 40),
              BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
                if (state is OrderLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is OrderLoadedState) {
                  final List<Order> orders = state.orders;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: myColor.tertiary,
                        ),
                      ),
                      const SizedBox(height: 20),
                      for (final order in orders)
                        OrderDisplayWidget(order: order)
                    ],
                  );
                }else if (state is OrderErrorState) {
                  return Center(
                    child: Text('Error: $state'),
                  );
                  }else if(state is OrderInitialState){
                    return const Center(
                      child: Text('WTF'),
                    );
                  } else {
                    return Center(
                      child: Text('$state'),
                    );
                  }
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(userRole: _userRole),
    );
  }

  void _fetchOrders() {
    BlocProvider.of<OrderBloc>(context).add(const GetOrdersEvent());
  }
}
