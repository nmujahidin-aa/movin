import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/features/activity/domain/usecase/join_activity_usecase.dart';
import 'package:movin/features/activity/presentation/bloc/activity_detail_event.dart';
import 'package:movin/features/activity/presentation/bloc/activity_detail_state.dart';

class ActivityDetailBloc
    extends Bloc<ActivityDetailEvent, ActivityDetailState> {
  final JoinActivityUseCase joinActivityUseCase;

  ActivityDetailBloc(this.joinActivityUseCase)
      : super(ActivityDetailInitial()) {
    on<JoinActivityEvent>(_onJoinActivity);
  }

  Future<void> _onJoinActivity(
    JoinActivityEvent event,
    Emitter<ActivityDetailState> emit,
  ) async {
    emit(ActivityDetailLoading());

    try {
      await joinActivityUseCase(event.activityId);
      emit(ActivityDetailSuccess());
    } catch (e) {
      emit(ActivityDetailError(e.toString()));
    }
  }
}