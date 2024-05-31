import 'package:agri_app_2/auth/bloc/login_bloc.dart';
import 'package:agri_app_2/auth/infrastructure/data_provider/signin_data_provider.dart';
import 'package:agri_app_2/auth/presentation/pages/login.dart';
import 'package:agri_app_2/auth/infrastructure/repository/signin_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   runApp(MyApp());
// }

class MyLogin extends StatelessWidget {
  const MyLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          final sharedPreferences = snapshot.data!;
          return MultiBlocProvider(
            providers: [
              BlocProvider<LoginBloc>(
                create: (context) => LoginBloc(
                  AuthRepository(
                    AuthDataProvider(Dio()),
                    sharedPreferences,
                  ),
                ),
              ),
            ],
            child: LoginPage(),
          );
        },
      ),
    );
  }
}
