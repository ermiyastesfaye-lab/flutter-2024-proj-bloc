import 'package:agri_app_2/crop/bloc/crop_bloc.dart';
import 'package:agri_app_2/crop/bloc/crop_event.dart';
import 'package:agri_app_2/crop/bloc/crop_state.dart';
import 'package:agri_app_2/crop/model/crop_model.dart';
import 'package:agri_app_2/crop/presentation/add_crop.dart';
import 'package:agri_app_2/presentation/data/dummy_data.dart';
import 'package:agri_app_2/presentation/widget/app_bar.dart';
import 'package:agri_app_2/presentation/widget/bottom_nav_bar.dart';
import 'package:agri_app_2/presentation/widget/crop_management_list.dart';
import 'package:agri_app_2/presentation/widget/logo.dart';
import 'package:agri_app_2/presentation/widget/menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CropMangement extends StatefulWidget {
  const CropMangement({super.key});

  @override
  _CropMangementState createState() => _CropMangementState();
}

class _CropMangementState extends State<CropMangement> {
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
        padding: const EdgeInsets.all(16.0),
        constraints: const BoxConstraints(maxWidth: 700.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: LogoWidget(logo: logos[0]),
            ),
            Center(
              child: SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    GoRouter.of(context).go("/addCrop");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: myColor.secondary,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Colors.white, size: 15),
                      Text(
                        'Add',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'List',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: myColor.tertiary,
                  ),
                ),
                const SizedBox(height: 20),
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
                              CropListManagement(crop: crop)
                          ],
                        );
                } else if (state is CropErrorState) {
                  return Center(
                    child: Text('Error: ${state.message}'),
                  );
                  }else if(state is CropInitialState){
                    return const Center(
                      child: Text('WTF'),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10.0),
              Text(
                '${amount.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 12.0),
              ),
            ],
          ),
        ],
      ),
    );
  }

   void _fetchCrops(){
    BlocProvider.of<CropBloc>(context).add(const GetCropsEvent());
  }
}


