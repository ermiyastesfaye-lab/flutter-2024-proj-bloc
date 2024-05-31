import 'dart:convert';
import 'package:agri_app_2/auth/domain/signup_model.dart';
import 'package:http/http.dart' as http;


class AuthRegDataProvider {
  Future<Map<String, dynamic>> registerUser(SignupData user) async {
    try {
      final response = await http.post(
          Uri.parse('http://localhost:3000/auth/signUp'),
          body: json.encode(user.toJson()),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Registration failed with status: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
