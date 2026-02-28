import 'package:movin/features/transaction/domain/entities/transaction.dart';

abstract class TransactionState {}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionSuccess extends TransactionState {
  final Transaction transaction;

  TransactionSuccess(this.transaction);
}

class TransactionError extends TransactionState {
  final String message;

  TransactionError(this.message);
}