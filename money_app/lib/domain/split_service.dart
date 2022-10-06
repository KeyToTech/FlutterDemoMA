import 'package:get/get.dart';
import 'package:money_app/data/entity/transaction.dart';
import 'package:money_app/data/repository/repository.dart';

class SplitService {
  Future<bool> split(String transactionId) {
    final transaction = mockTransactions
        .firstWhereOrNull((element) => element.id == transactionId);
    if (transaction != null) {
      final newTransaction = Transaction(
        id: generateRandomString(1000),
        name: "Split from ${transaction.name}",
        amount: transaction.amount / 2,
        createdAt: DateTime.now(),
        type: TransactionType.topUp,
      );
      mockTransactions.add(newTransaction);
      mockTransactions[mockTransactions
              .indexWhere((element) => element.id == transactionId)] =
          Transaction(
              id: transaction.id,
              name: transaction.name,
              type: transaction.type,
              amount: transaction.amount / 2,
              createdAt: transaction.createdAt);
      return Future.delayed(const Duration(seconds: 1), () => true);
    }
    return Future.delayed(const Duration(seconds: 1), () => true);
  }
}
