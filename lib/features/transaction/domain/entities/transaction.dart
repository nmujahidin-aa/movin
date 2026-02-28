class Transaction {
  final int id;
  final String invoiceid;
  final String status;
  final int totalAmount;

  Transaction({
    required this.id,
    required this.invoiceid,
    required this.status,
    required this.totalAmount,
  });
}