import 'package:agri_app_2/crop/bloc/crop_bloc.dart';
import 'package:agri_app_2/crop/bloc/crop_event.dart';
import 'package:agri_app_2/crop/bloc/crop_state.dart';
import 'package:agri_app_2/crop/domain/crop_model.dart';
import 'package:agri_app_2/order/bloc/order_bloc.dart';
import 'package:agri_app_2/order/bloc/order_event.dart';
import 'package:agri_app_2/order/bloc/order_state.dart';
import 'package:agri_app_2/order/domain/order_model.dart';
import 'package:agri_app_2/auth/domain/dummy_data.dart';
import 'package:agri_app_2/auth/presentation/widgets/app_bar.dart';
import 'package:agri_app_2/auth/presentation/widgets/bottom_nav_bar.dart';
import 'package:agri_app_2/auth/presentation/widgets/logo.dart';
import 'package:agri_app_2/auth/presentation/widgets/menu_bar.dart';
import 'package:agri_app_2/order/presentation/widgets/order_management_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarketPlace extends StatefulWidget {
  const MarketPlace({super.key});

  @override
  _MarketPlaceState createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {
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
    _getCrops();
  }

  Future<void> _getCrops() async {
   _fetchCrops();
  }

  @override
  Widget build(BuildContext context) {
    _getUserRole();
    return Scaffold(
      appBar: AppBarWidget(userRole: _userRole),
      drawer: MenuBarWidget(userRole: _userRole),
      body: Container(
        padding: const EdgeInsets.all(16.0), // Add some padding around the content
        constraints: const BoxConstraints(maxWidth: 700.0), // Set a maximum width
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: LogoWidget(logo: logos[1]),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Order',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: myColor.tertiary)),
                const SizedBox(height: 30),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: BlocBuilder<CropBloc, CropState>(
                builder: (context, state) {
                  if (state is CropsLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CropLoadedState) {
                      final List<Crop> crops = state.crops;
                       return GridView.count(
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                          children: [
                            for (final crop in crops)
                              OrderListManagement(crop: crop)
                          ],
                        );
                } else if (state is CropErrorState) {
                  return Center(
                    child: Text('Error: ${state.message}'),
                  );
                  }else if(state is CropInitialState){
                    return const Center(
                      child: Text('Initial'),
                    );
                  } else {
                    return Center(
                      child: Text('$state'),
                    );
                  }
                }
              )
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(userRole: _userRole),
    );
  }

  Widget gridItem(String imagePath, String name, int amount) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              imagePath,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            '\$${amount.toStringAsFixed(0)}',
            style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
          ),
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
  void _fetchCrops(){
    BlocProvider.of<CropBloc>(context).add(const GetOrderCropsEvent());
  }
}