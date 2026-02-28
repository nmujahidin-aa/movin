import 'package:movin/features/transaction/domain/entities/transaction.dart';

class TransactionModel extends Transaction {
  TransactionModel({
    required super.id,
    required super.status,
    required super.totalAmount, required super.invoiceid,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      status: json['status'],
      totalAmount: json['total_amount'], 
      invoiceid: json['invoice_id'],
    );
  }
}