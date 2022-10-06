enum TransactionType {
  payment,
  topUp,
}

class Transaction {
  final String id;
  final TransactionType type;
  final String name;
  final double amount;
  final DateTime createdAt;

  Transaction({
    required this.id,
    required this.name,
    required this.type,
    required this.amount,
    required this.createdAt,
  });
}
