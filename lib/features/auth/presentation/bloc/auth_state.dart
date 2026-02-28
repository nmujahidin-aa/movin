part of 'auth_bloc.dart';

enum AuthStatus { unknown, loading, authenticated, unauthenticated, resetEmailSent, failure }

class AuthState extends Equatable {
  const AuthState({
    required this.status,
    this.session,
    this.message,
  });

  final AuthStatus status;
  final AuthSession? session;
  final String? message;

  const AuthState.unknown() : this(status: AuthStatus.unknown);

  const AuthState.unauthenticated()
      : this(status: AuthStatus.unauthenticated);

  const AuthState.authenticated(AuthSession session)
      : this(status: AuthStatus.authenticated, session: session);

  AuthState copyWith({
    AuthStatus? status,
    AuthSession? session,
    String? message,
  }) {
    return AuthState(
      status: status ?? this.status,
      session: session ?? this.session,
      message: message,
    );
  }

  @override
  List<Object?> get props => [status, session, message];
}
