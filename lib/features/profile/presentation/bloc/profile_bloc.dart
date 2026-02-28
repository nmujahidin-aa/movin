
import 'package:bloc/bloc.dart';
import 'package:movin/features/profile/domain/repository/profile_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  ProfileBloc(this.repository) : super(ProfileState.initial()) {
    on<ProfileRequested>(_onRequested);
    on<ProfileUpdateRequested>(_onUpdate);
  }

  Future<void> _onRequested(
      ProfileRequested event,
      Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      final profile = await repository.getProfile();
      emit(state.copyWith(
        status: ProfileStatus.success,
        profile: profile,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onUpdate(
      ProfileUpdateRequested event,
      Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      final profile = await repository.updateProfile(
        id: event.id,
        name: event.name,
        email: event.email,
        password: event.password,
        confirmPassword: event.confirmPassword,
        phone: event.phone,
      );

      emit(state.copyWith(
        status: ProfileStatus.success,
        profile: profile,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.failure,
        message: e.toString(),
      ));
    }
  }
}