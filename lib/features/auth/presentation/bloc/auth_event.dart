part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class AuthObserveRequested extends AuthEvent {
  const AuthObserveRequested();
}

class AuthLoginRequested extends AuthEvent {
  const AuthLoginRequested({required this.email, required this.password});
  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

class AuthRegisterRequested extends AuthEvent {
  const AuthRegisterRequested({required this.name, required this.email, required this.password, required this.confirmPassword});
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  @override
  List<Object?> get props => [name, email, password, confirmPassword];
}

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

class AuthResetPasswordRequested extends AuthEvent {
  const AuthResetPasswordRequested({required this.email});
  final String email;

  @override
  List<Object?> get props => [email];
}

class AuthProfileRefreshRequested extends AuthEvent {
  const AuthProfileRefreshRequested();
}