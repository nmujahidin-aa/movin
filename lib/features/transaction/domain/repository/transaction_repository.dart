import 'package:movin/features/transaction/domain/entities/transaction.dart';

abstract class TransactionRepository {
  Future<Transaction> createTransaction(int activityId);
}