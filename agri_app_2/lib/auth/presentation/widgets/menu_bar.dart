import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agri_app_2/auth/presentation/pages/login.dart'; // Ensure this is the correct path
import 'package:agri_app_2/auth/presentation/pages/signup.dart';
import 'package:agri_app_2/order/presentation/pages/farmer_order_display.dart';
import 'package:agri_app_2/order/presentation/pages/market_place.dart';
import 'package:agri_app_2/user/presentation/profile_page.dart';
import 'package:agri_app_2/auth/domain/dummy_data.dart';

class MenuBarWidget extends StatelessWidget {
  final String userRole;
  const MenuBarWidget({
    super.key,
    required this.userRole,
  });

  Future<void> _logout(BuildContext context) async {
    // Clear shared preferences or cookies
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Navigate to login page
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage('assets/fruits.jpg'))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [],
            ),
          ),
          ListTile(
              onTap: () {
                if (userRole == "BUYER") {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const MarketPlace()));
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const FarmerOrderDisplay()));
                }
              },
              leading: Icon(
                Icons.shopping_cart,
                size: 26,
                color: myColor.tertiary,
              ),
              title: const Text(
                'Orders', style: TextStyle(fontSize: 20))),
          ListTile(
              onTap: () {
                _logout(context);
              },
              leading: Icon(
                Icons.logout,
                size: 26,
                color: myColor.tertiary,
              ),
              title: const Text('Log out', style: TextStyle(fontSize: 20))),
          const Divider(
            color: Colors.black,
          ),
          ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProfilePage()));
              },
              leading: Icon(
                Icons.person,
                size: 26,
                color: myColor.tertiary,
              ),
              title: const Text('My profile', style: TextStyle(fontSize: 20))),
        ],
      ),
    );
  }
}
