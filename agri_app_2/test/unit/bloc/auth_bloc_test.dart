import 'package:agri_app_2/auth/bloc/auth_bloc.dart';
import 'package:agri_app_2/auth/bloc/auth_event.dart';
import 'package:agri_app_2/auth/bloc/auth_state.dart';
import 'package:agri_app_2/auth/domain/signup_model.dart';
import 'package:agri_app_2/auth/infrastructure/repository/signup_repo.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'auth_bloc_test.mocks.dart';

// Generate a MockAuthRegRepository using the mockito package
// Create a file called auth_bloc_test.mocks.dart by running the following command:
// flutter pub run build_runner build

@GenerateMocks([AuthRegRepository])
void main() {
  late MockAuthRegRepository mockAuthRegRepository;

  setUp(() {
    mockAuthRegRepository = MockAuthRegRepository();
  });

  blocTest<AuthRegBloc, AuthState>(
    'emits [AuthLoading, AuthAuthenticated] when SignupEvent is added and registration is successful',
    build: () {
      when(mockAuthRegRepository.register(any)).thenAnswer((_) async => SignupData(
        email: 'test@example.com',
        password: 'password123',
        role: Role.FARMER,
      ));
      return AuthRegBloc(authRepository: mockAuthRegRepository);
    },
    act: (bloc) => bloc.add(const SignupEvent(
      email: 'test@example.com',
      password: 'password123',
      role: Role.FARMER,
    )),
    expect: () => [
      AuthLoading(),
      isA<AuthAuthenticated>(),
    ],
    verify: (bloc) {
      verify(mockAuthRegRepository.register(any)).called(1);
    },
  );

  blocTest<AuthRegBloc, AuthState>(
    'emits [AuthLoading, AuthError] when SignupEvent is added and registration fails',
    build: () {
      when(mockAuthRegRepository.register(any)).thenThrow(Exception('Registration failed'));
      return AuthRegBloc(authRepository: mockAuthRegRepository);
    },
    act: (bloc) => bloc.add(const SignupEvent(
      email: 'test@example.com',
      password: 'password123',
      role: Role.FARMER,
    )),
    expect: () => [
      AuthLoading(),
      isA<AuthError>(),
    ],
    verify: (bloc) {
      verify(mockAuthRegRepository.register(any)).called(1);
    },
  );
}
