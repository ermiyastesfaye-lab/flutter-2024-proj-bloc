import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignupEvent extends AuthEvent {
  final String email;
  final String password;

  const SignupEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
