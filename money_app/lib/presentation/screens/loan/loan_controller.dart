import 'package:get/get.dart';
import 'package:money_app/data/entity/loan_form.dart';
import 'package:money_app/domain/loan_service.dart';
import 'package:money_app/presentation/screens/transactions/transactions_controller.dart';

class AlertMessage {
  final String title;
  final String message;
  final bool isError;

  AlertMessage(
      {required this.title, required this.message, required this.isError});

  static AlertMessage empty() {
    return AlertMessage(title: '', message: '', isError: false);
  }
}

class LoanController extends GetxController {
  final LoanService loanService;

  LoanController({required this.loanService});

  var loanForm = LoanForm.initial().obs;

  var acceptedTerms = false.obs;
  var isLoading = false.obs;

  var alertMessage = AlertMessage.empty().obs;

  get isFormValid => acceptedTerms.value == true && loanForm.value.isValid();

  void init() {
    acceptedTerms(false);
    loanForm(LoanForm.initial());
    alertMessage(AlertMessage.empty());
  }

  void toggleAcceptedTerms() {
    acceptedTerms(!acceptedTerms.value);
  }

  void updateMonthlySalary(String value) {
    loanForm.value =
        loanForm.value.copyWith(monthlySalary: _parseDoubleValue(value));
  }

  void updateMonthlyExpenses(String value) {
    loanForm.value =
        loanForm.value.copyWith(monthlyExpenses: _parseDoubleValue(value));
  }

  void updateAmount(String value) {
    loanForm.value = loanForm.value.copyWith(amount: _parseDoubleValue(value));
  }

  void updateTerm(String value) {
    loanForm.value = loanForm.value.copyWith(term: _parseDoubleValue(value));
  }

  double _parseDoubleValue(String value) {
    if (value.isEmpty) {
      return 0.0;
    }
    return double.parse(value);
  }

  void applyForLoan() async {
    isLoading(true);

    final status = await loanService.applyForLoan(loanForm.value);
    if (status == LoanStatus.approved) {
      alertMessage(
        AlertMessage(
          title: 'Yeeeyyy !!',
          message:
              "Congrats. Your application has been approved. Don’t tell your friends you have money!",
          isError: false,
        ),
      );
      final TransactionsController controller = Get.find();
      controller.fetchData();
    } else if (status == LoanStatus.declinedNotFirstLoan) {
      alertMessage(
        AlertMessage(
          title: 'Ooopsss',
          message: 'you applied before. Wait for notification from us.',
          isError: false,
        ),
      );
    } else {
      alertMessage(
        AlertMessage(
          title: 'Ooopsss',
          message:
              'Your application has been declined. It’s not your fault, it’s a financial crisis.',
          isError: true,
        ),
      );
    }
    isLoading(false);
  }
}
