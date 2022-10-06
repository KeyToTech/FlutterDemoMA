import 'dart:math';

import 'package:money_app/data/entity/transaction.dart';

var mockTransactions = [
  Transaction(
    id: generateRandomString(1000),
    name: 'eBay',
    amount: 100,
    createdAt: DateTime.now(),
    type: TransactionType.payment,
  ),
  Transaction(
    id: generateRandomString(1000),
    name: 'Merton Council',
    amount: 65,
    createdAt: DateTime.now(),
    type: TransactionType.payment,
  ),
  Transaction(
    id: generateRandomString(1000),
    name: 'Top Up',
    amount: 150,
    createdAt: DateTime.now(),
    type: TransactionType.topUp,
  ),
  Transaction(
    id: generateRandomString(1000),
    name: 'Amazon',
    amount: 32,
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    type: TransactionType.payment,
  ),
  Transaction(
    id: generateRandomString(1000),
    name: 'John Snow',
    amount: 1400,
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    type: TransactionType.payment,
  ),
  Transaction(
    id: generateRandomString(1000),
    name: 'Top Up',
    amount: 120,
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    type: TransactionType.topUp,
  ),
];

String generateRandomString(int len) {
  var r = Random();
  return String.fromCharCodes(
      List.generate(len, (index) => r.nextInt(33) + 89));
}

class TransactionsRepository {
  Future<List<Transaction>> transactions() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => mockTransactions,
    );
  }
}
