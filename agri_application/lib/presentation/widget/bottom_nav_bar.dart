import 'package:agri_app_2/crop/presentation/crop_management.dart';
import 'package:agri_app_2/order/presentation/order_display.dart';
import 'package:agri_app_2/presentation/screens/dash_board.dart';
import 'package:agri_app_2/order/presentation/market_place.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBarWidget extends StatefulWidget {
  final String userRole; // Add a userRole parameter

  const BottomNavBarWidget({super.key, required this.userRole});

  @override
  State<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
        if (index == 0) {
          GoRouter.of(context).go("/dashBoard");
        } else if (index == 1) {
          if (widget.userRole == "BUYER") {
           GoRouter.of(context).go("/orderDisplayBuyer");
          } else {
            GoRouter.of(context).go("/cropManagement");
          }
        } else {
          GoRouter.of(context).go("/marketPlace");
        }
      },
      currentIndex: _selectedIndex, // Set the current index
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_filled,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.agriculture),
          label: 'Crops',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shop_two),
          label: 'Market',
        ),
      ],
      selectedItemColor: Colors.black, // Active color for the selected item
    );
  }
}
