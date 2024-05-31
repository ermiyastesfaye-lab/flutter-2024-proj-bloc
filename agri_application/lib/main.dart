// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agri_app_2/auth/bloc/auth_bloc.dart';
import 'package:agri_app_2/auth/bloc/login_bloc.dart';
import 'package:agri_app_2/auth/data_provider/signin_data_provider.dart';
import 'package:agri_app_2/auth/data_provider/signup_data_provider.dart';
import 'package:agri_app_2/auth/presentation/login.dart';
import 'package:agri_app_2/auth/presentation/signup.dart';
import 'package:agri_app_2/auth/repository/signin_repo.dart';
import 'package:agri_app_2/auth/repository/signup_repo.dart';
import 'package:agri_app_2/crop/bloc/crop_bloc.dart';
import 'package:agri_app_2/crop/data_provider/crop_data_provider.dart';
import 'package:agri_app_2/crop/model/crop_model.dart';
import 'package:agri_app_2/crop/presentation/add_crop.dart';
import 'package:agri_app_2/crop/presentation/crop_management.dart';
import 'package:agri_app_2/crop/presentation/edit.dart';
import 'package:agri_app_2/crop/presentation/update.dart';
import 'package:agri_app_2/crop/repository/crop_repository.dart';
import 'package:agri_app_2/order/bloc/order_bloc.dart';
import 'package:agri_app_2/order/data_provider/order_data_provider.dart';
import 'package:agri_app_2/order/presentation/farmer_order_display.dart';
import 'package:agri_app_2/order/presentation/market_place.dart';
import 'package:agri_app_2/order/presentation/order.dart';
import 'package:agri_app_2/order/presentation/order_display.dart';
import 'package:agri_app_2/order/repository/order_repository.dart';
import 'package:agri_app_2/presentation/screens/dash_board.dart';
import 'package:agri_app_2/presentation/screens/landing_page.dart';
import 'package:agri_app_2/presentation/widget/error.dart';
import 'package:agri_app_2/presentation/widget/theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dio = Dio();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final sharedPreferences = await SharedPreferences.getInstance();
  final authDataProvider = AuthDataProvider(dio);
  final orderDataProvider = OrderDataProvider(dio, sharedPreferences);
  final authRepository = AuthRepository(authDataProvider, sharedPreferences);
  final cropRepository = ConcreteCropRepository(
      CropDataProvider(dio, sharedPreferences));
  final orderRepository = ConcreteOrderRepository(orderDataProvider: orderDataProvider);
  bool themeBool = prefs.getBool("isDark") ?? false;
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CropBloc>(
          create: (context) => CropBloc(cropRepository),
        ),
         BlocProvider<OrderBloc>(
          create: (context) => OrderBloc(orderRepository),
        ),
        BlocProvider<AuthRegBloc>(
            create: (context) => AuthRegBloc(
                authRepository:
                    AuthRegRepository(dataProvider: AuthRegDataProvider())),
          ),
         BlocProvider<LoginBloc>(
                create: (context) => LoginBloc(
                  AuthRepository(
                    AuthDataProvider(Dio()),
                    sharedPreferences,
                  ),
                ),
              ),
      ],
      child: ChangeNotifierProvider(
        create: (BuildContext context) => ThemeProvider(isDark: themeBool),
        child: MainWidget(authRepository: authRepository, cropRepository: cropRepository, orderRepository: orderRepository,),
      ),
    ),
  );
}

class MainWidget extends StatelessWidget {
  
  final AuthRepository authRepository;
  final CropRepository cropRepository;
  final OrderRepository orderRepository;

  MainWidget({
    super.key,
    required this.authRepository,
    required this.cropRepository,
    required this.orderRepository,
  });

  

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return MaterialApp.router(
        title: 'Flutter Theme',
        routerConfig: _router,
        theme: themeProvider.getTheme,
        debugShowCheckedModeBanner: false,
      );
    }
    );
  }

  final GoRouter _router = GoRouter(
    initialLocation: "/",
    routes:[
    GoRoute(path: "/", builder: ((context, state) => const LandingPage())),
    GoRoute(path: "/signUp", builder: ((context, state) => const SignUp())),
    GoRoute(path: "/logIn", builder: ((context, state) => LoginPage())),
    GoRoute(path: "/dashBoard", builder: ((context, state) => const DashBoardScreen())),
    GoRoute(path: "/cropManagement", builder: ((context, state) => const CropMangement())),
    GoRoute(path: "/addCrop", builder: ((context, state) => const AddCrop())),
   GoRoute(path: "/editCrop", builder: (context, state) {
        final crop = state.extra as Crop?;
        if (crop == null) {
          return const ErrorPage(); // Replace with your error handling widget
        }
        return EditPage(crop: crop);
      }),
    GoRoute(path: "/updateCrop", builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        if (extra == null || !extra.containsKey('cropId') || !extra.containsKey('crop')) {
          return const ErrorPage(); // Replace with your error handling widget
        }
        final cropId = extra['cropId'] as String?;
        final crop = extra['crop'] as Crop;
        return UpdatePage(cropId: cropId, crop: crop);
      }),
    GoRoute(path: "/marketPlace", builder: ((context, state) => const MarketPlace())),
    GoRoute(path: "/orderDisplayBuyer", builder: ((context, state) => const OrderDisplayScreen())),
    GoRoute(path: "/order", builder: (context, state) {
        final crop = state.extra as Crop?;
        if (crop == null) {
          return const ErrorPage(); // Replace with your error handling widget
        }
        return OrderPage(crop: crop);
      }),
    GoRoute(path: "/orderDisplayFarmer", builder: ((context, state) => const FarmerOrderDisplay())),

  ]);
}
