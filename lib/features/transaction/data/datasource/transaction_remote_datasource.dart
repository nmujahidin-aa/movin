import 'package:dio/dio.dart';
import 'package:movin/features/transaction/data/models/transaction_model.dart';

class TransactionRemoteDataSource {
  final Dio dio;

  TransactionRemoteDataSource(this.dio);

  Future<TransactionModel> createTransaction(int activityId) async {
    final response = await dio.post(
      "/api/v1/transaction/create",
      data: {
        "activity_id": activityId,
      },
    );

    return TransactionModel.fromJson(response.data['result']);
  }
}