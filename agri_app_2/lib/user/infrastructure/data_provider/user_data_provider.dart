import 'package:agri_app_2/user/domain/update_user_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataProvider {
  final Dio dio;
  final SharedPreferences sharedPreferences;

  UserDataProvider(this.dio, this.sharedPreferences);

  Future<Map<String, String>> _authenticatedHeaders() async {
    final token = sharedPreferences.getString('token');

    if (token == null) {
      throw Exception('Missing token in local storage.');
    }

    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Assuming JSON content type
    };
  }

  Future<void> deleteUser(String? userId) async {
    try {
      final headers = await _authenticatedHeaders();
      final response = await dio.delete('http://localhost:3000/users/$userId',
          options: Options(headers: headers));

      if (response.statusCode != 200) {
        throw Exception('Failed to delete User');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<UpdateUserDto> updateUser(String userId, UpdateUserDto user) async {
    try {
      final headers = await _authenticatedHeaders();
      final response = await dio.patch('http://localhost:3000/Users/$userId',
          data: user.toJson(), options: Options(headers: headers));

      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        return UpdateUserDto.fromJson(data);
      } else {
        print("error");
        throw Exception('Failed to update User');
      }
    } catch (error) {
      rethrow;
    }
  }
}
