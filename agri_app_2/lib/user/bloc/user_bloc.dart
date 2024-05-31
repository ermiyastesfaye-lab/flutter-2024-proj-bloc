
import 'package:agri_app_2/user/bloc/user_event.dart';
import 'package:agri_app_2/user/bloc/user_state.dart';
import 'package:agri_app_2/user/domain/update_user_model.dart';
import 'package:agri_app_2/user/infrastructure/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository
      userRepository;

  UserBloc(this.userRepository) : super(UserInitialState()) {
    on<DeleteUserEvent>((event, emit) => _deleteUser(event.userId, emit));
    on<UpdateUserEvent>(
        (event, emit) => _updateUser(event.userId, event.user, emit));
  
  }

  Future<void> _deleteUser(String? userId, Emitter<UserState> emit) async {
    try {
      emit(UserLoadingState());
      await userRepository
          .deleteUser(userId); // Use UserRepository instead of UserDataProvider
      emit(const UserSuccessState("User deleted successfully!"));
    } catch (error) {
      emit(UserErrorState(error.toString()));
    }
  }

  Future<void> _updateUser(
      String userId, UpdateUserDto user, Emitter<UserState> emit) async {
    try {
      emit(UserLoadingState());
      await userRepository.updateUser(
          userId, user);
      emit(const UserSuccessState("User updated successfully!"));
      // emit(UserLoadedState(Users));

    } catch (error) {
      emit(UserErrorState(error.toString()));
    }
  }
}
