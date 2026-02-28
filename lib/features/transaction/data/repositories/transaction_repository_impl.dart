import 'package:movin/features/transaction/data/datasource/transaction_remote_datasource.dart';
import 'package:movin/features/transaction/domain/entities/transaction.dart';
import 'package:movin/features/transaction/domain/repository/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource remote;

  TransactionRepositoryImpl(this.remote);

  @override
  Future<Transaction> createTransaction(int activityId) {
    return remote.createTransaction(activityId);
  }
}