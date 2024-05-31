import 'package:agri_app_2/user/domain/update_user_model.dart';
import 'package:agri_app_2/user/infrastructure/data_provider/user_data_provider.dart';

abstract class UserRepository {
  Future<void> deleteUser(String? userId);
  Future<UpdateUserDto> updateUser(String userId, UpdateUserDto user);
}

class ConcreteUserRepository implements UserRepository {
  final UserDataProvider userDataProvider;

  ConcreteUserRepository(this.userDataProvider);

  @override
  Future<void> deleteUser(String? userId) async {
    return await userDataProvider.deleteUser(userId);
  }

  @override
  Future<UpdateUserDto> updateUser(String userId, UpdateUserDto user) async {
    return await userDataProvider.updateUser(userId, user);
  }
}
