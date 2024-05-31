import 'package:agri_app_2/auth/infrastructure/data_provider/signin_data_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:agri_app_2/auth/domain/signin_model.dart';
import 'dart:convert';

void main() {
  group('AuthDataProvider', () {
    late Dio dio;
    late AuthDataProvider authDataProvider;

    setUp(() {
      dio = Dio();
      authDataProvider = AuthDataProvider(dio);
    });

    test('should return token and userId when login is successful', () async {
      // Arrange
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          handler.next(options); // Continue with the request
        },
        onResponse: (response, handler) {
          response.data = {
            'access_token': 'mockToken',
            'userId': 20,
            'role': 'FARMER',
          };
          handler.resolve(response); // Continue with the modified response
        },
        onError: (DioError e, handler) {
          handler.next(e); // Continue with the error
        },
      ));

      final email = 'test@example.com';
      final password = 'password123';
      final role = Role.FARMER;

      // Act
      final result = await authDataProvider.login(email, password, role);

      // Assert
      expect(result, {
        'token': 'mockToken',
        'userId': 20,
        'role': 'FARMER',
      });
    });

    test('should throw exception when login fails with error message', () async {
      // Arrange
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          handler.next(options); // Continue with the request
        },
        onResponse: (response, handler) {
          response.statusCode = 401;
          response.data = {'message': 'Invalid credentials'};
          handler.resolve(response); // Continue with the modified response
        },
        onError: (DioError e, handler) {
          handler.next(e); // Continue with the error
        },
      ));

      final email = 'test@example.com';
      final password = 'password123';
      final role = Role.FARMER;

      // Act & Assert
      expect(
        () async => await authDataProvider.login(email, password, role),
        throwsA(isA<Exception>().having(
            (e) => e.toString(), 'message', contains('Login failed: Invalid credentials'))),
      );
    });

    test('should throw exception when userId is missing or invalid', () async {
      // Arrange
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          handler.next(options); // Continue with the request
        },
        onResponse: (response, handler) {
          response.data = {
            'access_token': 'mockToken',
            'role': 'FARMER',
          };
          handler.resolve(response); // Continue with the modified response
        },
        onError: (DioError e, handler) {
          handler.next(e); // Continue with the error
        },
      ));

      final email = 'test@example.com';
      final password = 'password123';
      final role = Role.FARMER;

      // Act & Assert
      expect(
        () async => await authDataProvider.login(email, password, role),
        throwsA(isA<Exception>().having(
            (e) => e.toString(), 'message', contains('User ID is invalid or missing'))),
      );
    });
  });
}
