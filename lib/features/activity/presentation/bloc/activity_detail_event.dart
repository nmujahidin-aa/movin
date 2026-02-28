abstract class ActivityDetailEvent {}

class JoinActivityEvent extends ActivityDetailEvent {
  final int activityId;

  JoinActivityEvent(this.activityId);
}