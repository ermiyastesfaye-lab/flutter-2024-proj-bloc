import 'package:agri_app_2/auth/bloc/auth_event.dart';
import 'package:agri_app_2/auth/bloc/auth_state.dart';
import 'package:agri_app_2/auth/domain/signup_model.dart';
import 'package:agri_app_2/auth/infrastructure/repository/signup_repo.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AuthRegBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRegRepository _authRepository;

  AuthRegBloc({required AuthRegRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial()) {
    on<SignupEvent>(_onRegisterEvent);
  }

  Future<void> _onRegisterEvent(
    SignupEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      final registeredUser = await _authRepository.register(SignupData(
        email: event.email,
        password: event.password,
        role: event.role
      ));
      emit(AuthAuthenticated(registeredUser));
    } catch (error) {
      emit(AuthError(error.toString()));
    }
  }
}

