import 'package:agri_app_2/auth/infrastructure/data_provider/signin_data_provider.dart';
import 'package:agri_app_2/auth/domain/auth_model.dart';
import 'package:agri_app_2/auth/domain/signin_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final AuthDataProvider dataProvider;
  final SharedPreferences sharedPreferences;

  AuthRepository(this.dataProvider, this.sharedPreferences);

  Future<AuthLoginData> login(String email, String password, Role role) async {
    try {
      final data = await dataProvider.login(email, password, role);
      final token = data['token'];
      final userId = data['userId'];
      final userRole = data['role']; // Correctly access 'userId' from data map

      await sharedPreferences.setString('token', token);
      await sharedPreferences.setInt(
          'userId', userId);
      await sharedPreferences.setString(
          'role', userRole);  // Store userId correctly

      return AuthLoginData(
        token: token,
        id: userId,
        role: userRole
      );
    } catch (error) {
      rethrow;
    }
  }
}
