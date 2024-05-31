// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agri_app_2/user/domain/update_user_model.dart';

abstract class UserEvent {
  const UserEvent();
}

class LoadUsersEvent extends UserEvent {
  const LoadUsersEvent();
}

class DeleteUserEvent extends UserEvent {
  final String? userId;

  const DeleteUserEvent(
    this.userId,
  );
}

class UpdateUserEvent extends UserEvent {
  final String userId;
  final UpdateUserDto user;

  UpdateUserEvent({required this.userId, required this.user});

  List<Object> get props => [userId, user];
}
