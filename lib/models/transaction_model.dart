class TransactionModel {
  final double amount;
  final String status;
  final DateTime dateTime;
  final String remarks;

  TransactionModel({
    required this.amount,
    required this.status,
    required this.dateTime,
    required this.remarks,
  });

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'status': status,
    'dateTime': dateTime.toIso8601String(),
    'remarks': remarks,
  };
}
