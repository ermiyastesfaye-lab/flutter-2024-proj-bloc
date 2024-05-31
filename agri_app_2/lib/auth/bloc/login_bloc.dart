import 'package:agri_app_2/auth/bloc/login_event.dart';
import 'package:agri_app_2/auth/bloc/login_state.dart';
import 'package:agri_app_2/auth/model/signin_model.dart';
import 'package:agri_app_2/auth/repository/signin_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(LoginInitial()) {
    on<LoginRequested>((event, emit) async => await _login(event, emit));
    on<FarmerLoginRequested>(
        (event, emit) async => await _Farmerlogin(event, emit));
    on<LoginResponseReceived>((event, emit) => emit(event.success
        ? LoginSuccess(event.data!)
        : LoginError(event.message!)));
  }

  Future<void> _login(LoginRequested event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final loginData =
          await authRepository.login(event.email, event.password, Role.BUYER);
      // Emit appropriate state based on login response:
      emit(LoginSuccess(loginData));
    } catch (error) {
      emit(LoginError(error.toString()));
    }
  }

  Future<void> _Farmerlogin(
      FarmerLoginRequested event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final loginData =
          await authRepository.login(event.email, event.password, Role.FARMER);
      // Emit appropriate state based on login response:
      emit(LoginSuccess(loginData));
    } catch (error) {
      emit(LoginError(error.toString()));
    }
  }
}
