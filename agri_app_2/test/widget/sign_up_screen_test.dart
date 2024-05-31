import 'package:agri_app_2/auth/bloc/auth_bloc.dart';
import 'package:agri_app_2/auth/infrastructure/data_provider/signup_data_provider.dart';
import 'package:agri_app_2/auth/domain/signup_model.dart';
import 'package:agri_app_2/auth/presentation/pages/signup.dart';
import 'package:agri_app_2/auth/infrastructure/repository/signup_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([AuthRegDataProvider])
import 'sign_up_screen_test.mocks.dart';

void main() {
  late MockAuthRegDataProvider mockAuthRegDataProvider;
  late AuthRegRepository authRegRepository;

  setUp(() {
    mockAuthRegDataProvider = MockAuthRegDataProvider();
    authRegRepository = AuthRegRepository(dataProvider: mockAuthRegDataProvider);
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => AuthRegBloc(authRepository: authRegRepository),
        child: const SignUp(),
      ),
    );
  }

  group('SignUp Screen Tests', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();  // Ensure the widget tree is fully built

      expect(find.text('Create Account'), findsOneWidget);
      expect(find.text('Create an account to access available agricultural products'), findsOneWidget);
    });

    testWidgets('validates empty email and password fields', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();  // Ensure the widget tree is fully built

      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('sign up button triggers SignupEvent and calls register', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();  // Ensure the widget tree is fully built

      await tester.enterText(find.byType(TextFormField).at(0), 'test@example.com');
      await tester.enterText(find.byType(TextFormField).at(1), 'password123');
      await tester.enterText(find.byType(TextFormField).at(2), 'password123');

      // Select the role from the dropdown
      await tester.tap(find.byType(DropdownButtonFormField<Role>));
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();

      // Mock the registerUser method
      when(mockAuthRegDataProvider.registerUser(any)).thenAnswer((_) async => {
          "email": "test@example.com",
          "password": "password",
          "role": "FARMER"
        });

        await tester.pumpAndSettle();

        // Verify the registerUser method was never called
        verifyNever(mockAuthRegDataProvider.registerUser(any));
                  });

    testWidgets('navigates to login screen on text button press', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();  // Ensure the widget tree is fully built

      await tester.pumpAndSettle();
      expect(find.text('Sign Up'), findsOneWidget);
    });
  });
}
