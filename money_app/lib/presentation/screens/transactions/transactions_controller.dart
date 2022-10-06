import 'package:get/get.dart';
import 'package:money_app/data/entity/transaction.dart';
import 'package:money_app/data/repository/repository.dart';

class TransactionsController extends GetxController {
  final TransactionsRepository transactionsRepository;
  final BalanceRepository balanceRepository;

  TransactionsController(
      {required this.transactionsRepository, required this.balanceRepository});

  var balance = 0.0.obs;
  var transactions = <DateTime, List<Transaction>>{}.obs;
  var isLoading = false.obs;

  String get currentBalance => "${balance.value}";

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    isLoading(true);
    final currentBalance = await balanceRepository.fetchBalance();
    balance(currentBalance);
    final transactionList = await transactionsRepository.transactions();

    transactionList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    // group transactions by date
    final groupedTransactions = <DateTime, List<Transaction>>{};
    for (var transaction in transactionList) {
      final date = DateTime(
        transaction.createdAt.year,
        transaction.createdAt.month,
        transaction.createdAt.day,
      );
      if (groupedTransactions.containsKey(date)) {
        groupedTransactions[date]!.add(transaction);
      } else {
        groupedTransactions[date] = [transaction];
      }
    }

    transactions(groupedTransactions);
    isLoading(false);
  }

  void makePayment(double amount, String toWhom) {
    final newTransaction = Transaction(
      id: generateRandomString(1000),
      name: "Payment to $toWhom",
      amount: amount,
      createdAt: DateTime.now(),
      type: TransactionType.payment,
    );

    updateData(mockUserBalance - amount, newTransaction);
    fetchData();
  }

  void topUp({required double amount}) {
    final newTransaction = Transaction(
      id: generateRandomString(1000),
      name: "Top up",
      amount: amount,
      createdAt: DateTime.now(),
      type: TransactionType.topUp,
    );

    updateData(mockUserBalance + amount, newTransaction);
    fetchData();
  }

  void updateData(double amount, Transaction transaction) {
    // TODO make api call to repeat payment
    mockTransactions.add(transaction);
    mockUserBalance = amount;
  }
}
