// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agri_app_2/crop/bloc/crop_bloc.dart';
import 'package:agri_app_2/crop/bloc/crop_event.dart';
import 'package:agri_app_2/crop/model/crop_model.dart';
import 'package:agri_app_2/crop/model/update_crop_model.dart';
import 'package:agri_app_2/crop/presentation/crop_management.dart';
import 'package:agri_app_2/presentation/data/dummy_data.dart';
import 'package:agri_app_2/presentation/widget/app_bar.dart';
import 'package:agri_app_2/presentation/widget/bottom_nav_bar.dart';
import 'package:agri_app_2/presentation/widget/logo.dart';
import 'package:agri_app_2/presentation/widget/menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdatePage extends StatefulWidget {
  final String? cropId;
  final Crop crop;

  const UpdatePage({
    super.key,
    required this.cropId,
    required this.crop,
  });
  

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  late TextEditingController _cropNameController;
  late TextEditingController _cropTypeController;
  late TextEditingController _plantingDateController;
  late TextEditingController _harvestingDateController;
  late TextEditingController _priceController;
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
    _cropNameController = TextEditingController(text: widget.crop.cropName);
    _cropTypeController = TextEditingController(text: widget.crop.cropType);
    _plantingDateController = TextEditingController(text: widget.crop.plantingDate);
    _harvestingDateController = TextEditingController(text: widget.crop.harvestingDate);
    _priceController = TextEditingController(text: widget.crop.price);
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
                            backgroundColor: myColor.secondary, // Background color
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
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
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
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Crop Name',
                        style: TextStyle(fontSize: 16, color: myColor.tertiary),
                      ),
                      SizedBox(
                        width: 200,
                        height: 35,
                        child: TextField(
                          controller: _cropNameController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: myColor.primary),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: widget.crop.cropName,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Crop Type',
                        style: TextStyle(fontSize: 16, color: myColor.tertiary),
                      ),
                      SizedBox(
                        width: 200,
                        height: 35,
                        child: TextField(
                          controller: _cropTypeController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: myColor.primary),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: widget.crop.cropType,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Planting Date',
                        style: TextStyle(fontSize: 16, color: myColor.tertiary),
                      ),
                      SizedBox(
                        width: 200,
                        height: 35,
                        child: TextField(
                          controller: _plantingDateController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: myColor.primary),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: widget.crop.plantingDate,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Harvesting Date',
                        style: TextStyle(fontSize: 16, color: myColor.tertiary),
                      ),
                      SizedBox(
                        width: 200,
                        height: 35,
                        child: TextField(
                          controller: _harvestingDateController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: myColor.primary),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: widget.crop.harvestingDate,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Price(ETB)',
                        style: TextStyle(fontSize: 16, color: myColor.tertiary),
                      ),
                      SizedBox(
                        width: 200,
                        height: 35,
                        child: TextField(
                          controller: _priceController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: myColor.primary),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: widget.crop.price,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Center(
                    child: SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        onPressed: (){
                          _updateCrop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myColor.secondary,
                          // Background color
                        ),
                        child: const Text(
                          'Update',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
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
  void _updateCrop(BuildContext context) {
    final updatedCrop = UpdateCropDto(
      cropName: _cropNameController.text,
      cropType: _cropTypeController.text,
      plantingDate: _plantingDateController.text,
      harvestingDate: _harvestingDateController.text,
      price: _priceController.text
    );

    BlocProvider.of<CropBloc>(context).add(
      UpdateCropEvent(cropId: widget.crop.cropId!, crop: updatedCrop), 
    );

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Crop updated Successfully'),
            content: const Text('Your Crop has been updated successfully.'),
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
  @override
  void dispose() {
    _cropNameController.dispose();
    _cropTypeController.dispose();
    _plantingDateController.dispose();
    _harvestingDateController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
