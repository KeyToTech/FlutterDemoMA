import 'package:get/get.dart';
import 'package:money_app/data/entity/transaction.dart';
import 'package:money_app/data/repository/repository.dart';
import 'package:money_app/domain/split_service.dart';
import 'package:money_app/presentation/screens/transactions/transactions_controller.dart';

class TransactionDetailsController extends GetxController {
  var isLoading = false.obs;
  late Transaction? transaction;

  void fetchTransactionDetails(String transactionId) {
    isLoading(true);
    final item = _transactionById(transactionId);
    if (item != null) {
      transaction = item;
    }
    isLoading(false);
  }

  void splitBill(String transactionId) async {
    isLoading(true);
    await SplitService().split(transactionId);
    fetchTransactionDetails(transactionId);
    Get.find<TransactionsController>().fetchData();
    isLoading(false);
  }

  void repeatPayment(String transactionId) {
    final item = _transactionById(transactionId);
    if (item != null) {
      final now = DateTime.now();
      var dateTime = DateTime(
        now.year,
        now.month,
        now.day,
        now.hour,
        now.minute,
        now.second,
      );
      final newTransaction = Transaction(
        id: generateRandomString(1000),
        name: item.name,
        amount: item.amount,
        createdAt: dateTime,
        type: item.type,
      );

      final TransactionsController controller = Get.find();
      controller.updateData(
          mockUserBalance + newTransaction.amount, newTransaction);
      controller.fetchData();
    }
  }

  Transaction? _transactionById(String id) {
    // TODO fetch transaction details from service/repository
    return mockTransactions.firstWhereOrNull((element) => element.id == id);
  }
}
