import 'package:agri_app_2/auth/bloc/auth_bloc.dart';
import 'package:agri_app_2/auth/bloc/auth_event.dart';
import 'package:agri_app_2/auth/bloc/auth_state.dart';
import 'package:agri_app_2/auth/model/signup_model.dart';
import 'package:agri_app_2/auth/repository/signup_repo.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRegRepository extends Mock implements AuthRegRepository {}

void main() {
  late AuthRegBloc authRegBloc;
  late MockAuthRegRepository mockAuthRegRepository;

  setUp(() {
    mockAuthRegRepository = MockAuthRegRepository();
    authRegBloc = AuthRegBloc(authRepository: mockAuthRegRepository);
    registerFallbackValue(SignupData(
      email: '',
      password: '',
      role: Role.BUYER,
    ));
  });

  tearDown(() {
    authRegBloc.close();
  });

  group('AuthRegBloc', () {
    blocTest<AuthRegBloc, AuthState>(
      'emits [AuthLoading, AuthAuthenticated] when RegisterEvent is added and registration succeeds',
      build: () {
        when(() => mockAuthRegRepository.register(any()))
            .thenAnswer((_) async => SignupData(
                  password: 'password',
                  email: 'test@example.com',
                  role: Role.BUYER,
                ));
        return authRegBloc;
      },
      act: (bloc) => bloc.add(const SignupEvent(
        email: 'test@example.com',
        password: 'password',
      )),
      expect: () => [
        AuthLoading(),
        isA<AuthAuthenticated>(), // Use matcher instead of concrete instance
      ],
      verify: (_) {
        verify(() => mockAuthRegRepository.register(any())).called(1);
      },
    );

    // Add more bloc tests for other events as needed
  });
}
