import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserErrorState extends UserState {
  final String message;

  const UserErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class UserSuccessState extends UserState {
  final String message;

  const UserSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class UsersLoadingState extends UserState {
  const UsersLoadingState();

  @override
  List<Object?> get props => [];
}