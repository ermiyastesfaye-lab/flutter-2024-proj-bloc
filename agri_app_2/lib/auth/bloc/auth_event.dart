// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agri_app_2/auth/domain/signup_model.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignupEvent extends AuthEvent {
  final String email;
  final String password;
  final Role role;

  const SignupEvent({
    required this.email,
    required this.password,
    required this.role,
  });

  @override
  List<Object> get props => [email, password];
}
