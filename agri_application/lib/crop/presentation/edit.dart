import 'package:agri_app_2/crop/bloc/crop_bloc.dart';
import 'package:agri_app_2/crop/bloc/crop_event.dart';
import 'package:agri_app_2/crop/model/crop_model.dart';
import 'package:agri_app_2/crop/presentation/crop_management.dart';
import 'package:agri_app_2/crop/presentation/update.dart';
import 'package:agri_app_2/presentation/data/dummy_data.dart';
import 'package:agri_app_2/presentation/widget/app_bar.dart';
import 'package:agri_app_2/presentation/widget/bottom_nav_bar.dart';
import 'package:agri_app_2/presentation/widget/logo.dart';
import 'package:agri_app_2/presentation/widget/menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPage extends StatefulWidget {
  final Crop crop;

  const EditPage({super.key, required this.crop});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  String _userRole = '';

  Future<void> _getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userRole = prefs.getString('role') ?? 'BUYER'; // Default to 'user' if not found
    });
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
                              horizontal: 19, vertical: 10),
                          child: LogoWidget(logo: logos[0]),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: 300,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  myColor.secondary, // Background color
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add, color: Colors.white, size: 15),
                                Text(
                                  'Add',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                padding: const EdgeInsets.all(15),
                height: 450,
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
                          color: myColor.tertiary),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Crop Name',
                          style:
                              TextStyle(fontSize: 16, color: myColor.tertiary),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Text(
                          widget.crop.cropName,
                          style: TextStyle(
                              fontSize: 20,
                              color: myColor.primary,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Crop Type',
                          style:
                              TextStyle(fontSize: 16, color: myColor.tertiary),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Text(
                          widget.crop.cropType,
                          style: TextStyle(
                              fontSize: 20,
                              color: myColor.primary,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Planting Date',
                          style:
                              TextStyle(fontSize: 16, color: myColor.tertiary),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Text(
                          widget.crop.plantingDate,
                          style: TextStyle(
                              fontSize: 20,
                              color: myColor.primary,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Harvesting Date',
                          style:
                              TextStyle(fontSize: 16, color: myColor.tertiary),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Text(
                          widget.crop.harvestingDate,
                          style: TextStyle(
                              fontSize: 20,
                              color: myColor.primary,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Price(ETB)',
                          style:
                              TextStyle(fontSize: 16, color: myColor.tertiary),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Text(
                          widget.crop.price,
                          style: TextStyle(
                              fontSize: 20,
                              color: myColor.primary,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () {
                              GoRouter.of(context).go("/updateCrop", extra: {'crop': widget.crop, 'cropId': widget.crop.cropId});
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => UpdatePage(crop: widget.crop, cropId: widget.crop.cropId,)));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: myColor.secondary,
                              // Background color
                            ),
                            child: const Text(
                              'Edit',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () {
                              _deleteCrop(context, widget.crop.cropId!);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: myColor.secondary,
                              // Background color
                            ),
                            child: const Text(
                              'Remove',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ], // Removed extra comma here
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBarWidget(userRole: _userRole));
  }

  void _deleteCrop(BuildContext context, cropId) {
    BlocProvider.of<CropBloc>(context).add(DeleteCropEvent(cropId));

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Crop Deleted Successfully'),
          content: const Text('Your Crop has been deleted successfully.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                GoRouter.of(context).go("/cropManagement");
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
