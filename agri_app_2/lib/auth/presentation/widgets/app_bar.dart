// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agri_app_2/auth/domain/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
          icon: const Icon(Icons.shopping_cart,
              color: Color.fromARGB(255, 103, 103, 103)),
          label: const Text(''),
        )
      ],
    ));
  }
}
