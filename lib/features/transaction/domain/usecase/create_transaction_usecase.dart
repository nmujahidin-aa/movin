import 'package:movin/features/transaction/domain/entities/transaction.dart';
import 'package:movin/features/transaction/domain/repository/transaction_repository.dart';

class CreateTransactionUseCase {
  final TransactionRepository repository;

  CreateTransactionUseCase(this.repository);

  Future<Transaction> call(int activityId) {
    return repository.createTransaction(activityId);
  }
}