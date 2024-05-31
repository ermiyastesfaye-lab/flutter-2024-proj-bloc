// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agri_app_2/order/presentation/farmer_order_display.dart';
import 'package:agri_app_2/order/presentation/order_display.dart';
import 'package:agri_app_2/presentation/data/dummy_data.dart';
import 'package:agri_app_2/presentation/widget/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatelessWidget implements PreferredSize {
  final String userRole;
  const AppBarWidget({
    super.key,
    required this.userRole,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget get child => const SizedBox();

  @override
  Widget build(context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return AppBar(
        title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'AgriConnect',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: myColor.tertiary),
        ),
        TextButton.icon(
          onPressed: () {
            if (userRole == "BUYER") {
              GoRouter.of(context).go("/orderDisplayBuyer");
          } else {
            GoRouter.of(context).go("/orderDisplayBuyer");
          }
          },
          icon: Icon(Icons.shopping_cart,
              color: themeProvider.getTheme == darkTheme
                  ? Colors.white
                  : const Color.fromARGB(255, 103, 103, 103)),
          label: const Text(''),
        )
      ],
    ));
  }
}
