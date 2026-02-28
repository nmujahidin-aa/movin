import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/domain/usecase/check_auth_status_usecase.dart';

abstract class SplashState {
  const SplashState();
}

class SplashInitial extends SplashState {
  const SplashInitial();
}

class SplashLoading extends SplashState {
  const SplashLoading();
}

class SplashGoAuth extends SplashState {
  const SplashGoAuth();
}

class SplashGoHome extends SplashState {
  const SplashGoHome();
}

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._checkAuthStatusUsecase)
      : super(const SplashInitial());

  final CheckAuthStatusUseCase _checkAuthStatusUsecase;

  Future<void> checkAuth() async {
    emit(const SplashLoading());

    await Future.delayed(const Duration(seconds: 2));

    final session = await _checkAuthStatusUsecase();

    if (session == null) {
      emit(const SplashGoAuth());
    } else {
      emit(const SplashGoHome());
    }
  }
}          