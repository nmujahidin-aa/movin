import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/features/auth/domain/entities/auth_session.dart';
import 'package:movin/features/auth/domain/usecase/login_usecase.dart';
import 'package:movin/features/auth/domain/usecase/register_usecase.dart';

import '../../domain/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._repo) : super(const AuthState.unknown()) {
    on<AuthObserveRequested>(_onObserve);
    on<AuthLoginRequested>(_onLogin);
    on<AuthRegisterRequested>(_onRegister);
    on<AuthLogoutRequested>(_onLogout);
    // on<AuthResetPasswordRequested>(_onReset);
    // on<AuthProfileRefreshRequested>(_onRefresh);
  }

  final AuthRepository _repo;

  Future<void> _onObserve(AuthObserveRequested event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      final session = await _repo.getSavedSession();
      if (session == null || session.user == null) {
        emit(const AuthState.unauthenticated());
      } else {
        emit(AuthState.authenticated(session));
      }
    } catch (_) {
      emit(const AuthState.unauthenticated());
    }
  }


  Future<void> _onLogin(AuthLoginRequested event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading, message: null));
      final session = await _repo.login(LoginParams(email: event.email, password: event.password));
      emit(AuthState.authenticated(session));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, message: e.toString()));
    }
  }

  Future<void> _onRegister(AuthRegisterRequested event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading, message: null));
      final session = await _repo.register(RegisterParams(name: event.name, email: event.email, password: event.password, confirmPassword: event.confirmPassword));
      emit(AuthState.authenticated(session));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, message: e.toString()));
    }
  }

  Future<void> _onLogout(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    try {
      await _repo.logout();
    } catch (e) {
      print("Logout API failed, forcing local logout");
    }
    emit(const AuthState.unauthenticated());
  }

  // Future<void> _onReset(AuthResetPasswordRequested event, Emitter<AuthState> emit) async {
  //   try {
  //     emit(state.copyWith(status: AuthStatus.loading, message: null));
  //     await _repo.sendPasswordResetEmail(email: event.email);
  //     emit(state.copyWith(status: AuthStatus.resetEmailSent));
  //   } catch (e) {
  //     emit(state.copyWith(status: AuthStatus.failure, message: e.toString()));
  //   }
  // }

  // Future<void> _onRefresh(AuthProfileRefreshRequested event, Emitter<AuthState> emit) async {
  //   final uid = _repo.currentUserId;
  //   if (uid == null) return;
  //   final user = await _repo.getUserProfile(uid);
  //   emit(AuthState.authenticated(user));
  // }
}