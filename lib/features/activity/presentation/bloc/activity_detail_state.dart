abstract class ActivityDetailState {}

class ActivityDetailInitial extends ActivityDetailState {}

class ActivityDetailLoading extends ActivityDetailState {}

class ActivityDetailSuccess extends ActivityDetailState {}

class ActivityDetailError extends ActivityDetailState {
  final String message;

  ActivityDetailError(this.message);
}