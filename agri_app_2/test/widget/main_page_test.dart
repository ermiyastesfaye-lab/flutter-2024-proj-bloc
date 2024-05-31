import 'package:agri_app_2/auth/bloc/login_bloc.dart';
import 'package:agri_app_2/auth/infrastructure/data_provider/signin_data_provider.dart';
import 'package:agri_app_2/auth/infrastructure/repository/signin_repo.dart';
import 'package:agri_app_2/auth/presentation/pages/login.dart';
import 'package:agri_app_2/auth/presentation/widgets/theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../unit/data_provider/crop_data_provider_test.dart.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final dio = Dio();

  setUpAll(() {
    // Use mock shared preferences
    final mockSharedPreferences = MockSharedPreferences();
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('LoginPage Widget Test', (WidgetTester tester) async {
    // Use mock shared preferences
    final sharedPreferences = await SharedPreferences.getInstance();
    final authRepository = AuthRepository(
      AuthDataProvider(dio),
      sharedPreferences,
    );

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(authRepository),
          ),
        ],
        child: ChangeNotifierProvider(
          create: (context) => ThemeProvider(isDark: false),
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      ),
    );
    await tester.pump();
  });
}
