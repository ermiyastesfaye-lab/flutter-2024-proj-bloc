import 'package:agri_app_2/auth/domain/signin_model.dart';
import 'package:agri_app_2/constant.dart';
import 'package:dio/dio.dart';

class AuthDataProvider {
  final Dio dio;

  AuthDataProvider(this.dio);

  Future<Map<String, dynamic>> login(
      String email, String password, Role role) async {
    try {
      final response = await dio.post(
        '$apiBaseUrl/auth/signIn',
        data: {
          'email': email,
          'password': password,
          'role': role.toString().split('.').last,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // If the login is successful, return the token and user ID
        final data = response.data;
        final token = data['access_token'];
        final userId = data['userId'];
        final userRole = data['role']; // Extract user ID from response data

        if (userId != null && userId is int) {
          return {
            'token': token,
            'userId': userId,
            'role': userRole.toString()
          };
        } else {
          throw Exception('User ID is invalid or missing');
        }
      } else {
        // If the login fails, throw an exception with the error message
        final errorMessage = response.data['message'];
        throw Exception('Login failed: $errorMessage');
      }
    } catch (error) {
      rethrow;
    }
  }
}