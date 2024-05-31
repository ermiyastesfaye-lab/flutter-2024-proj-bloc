import 'dart:convert';
import 'package:agri_app_2/auth/infrastructure/data_provider/signup_data_provider.dart';
import 'package:agri_app_2/auth/domain/signup_model.dart';
import 'package:agri_app_2/constant.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'auth_reg_data_provider_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('AuthRegDataProvider', () {
    late MockClient client;

    setUp(() {
      client = MockClient();
    });

    test('registerUser returns data on successful registration', () async {
      final SignupData user = SignupData(
        email: 'test@example21.com',
        password: 'password123',
        role: Role.FARMER,
      );

      final responsePayload = {
        'access_token': 'sampleAccessToken',
        'userId': 1,
        'role': 'FARMER'
      };
      final response = http.Response(json.encode(responsePayload), 200);

      // Mocking the post request correctly
      when(client.post(
        Uri.parse('$apiBaseUrl/auth/signUp'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => response);

      // Injecting the mock client into the AuthRegDataProvider
      AuthRegDataProvider clientInjectedProvider = AuthRegDataProvider();

      // Use the `registerUser` method
      final result = await clientInjectedProvider.registerUser(user);

      expect(result, allOf(
        containsPair('access_token', isA<String>().having((s) => s.isNotEmpty, 'non-empty', true)),
        containsPair('userId', isA<int>()),
        containsPair('role', responsePayload['role']),
      ));
    });
  });
}
