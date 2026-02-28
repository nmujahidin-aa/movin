abstract class TransactionEvent {}

class CreateTransactionEvent extends TransactionEvent {
  final int activityId;

  CreateTransactionEvent(this.activityId);
}