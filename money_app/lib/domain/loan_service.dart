import 'dart:convert';

import 'package:http/http.dart';
import 'package:money_app/data/entity/loan_form.dart';
import 'package:money_app/data/entity/transaction.dart';
import 'package:money_app/data/repository/loan_repository.dart';
import 'package:money_app/data/repository/repository.dart';

enum LoanStatus { approved, declined, declinedNotFirstLoan }

// TODO all the logic should be on server!
class LoanService {
  final LoanRepository _loanRepository;
  final BalanceRepository _balanceRepository;

  LoanService(this._loanRepository, this._balanceRepository);

  Future<LoanStatus> applyForLoan(LoanForm form) async {
    try {
      final isFirstLoan = await _loanRepository.isFirstLoan();
      if (!isFirstLoan) {
        return LoanStatus.declinedNotFirstLoan;
      }

      mockLoanData = {"firstLoan": false};

      final currentBalance = await _balanceRepository.fetchBalance();
      final random = await _fetchRandomValue();
      final loanCost = (form.amount / form.term);

      final loanCanBeApproved = random > 50 &&
          currentBalance > 1000 &&
          form.monthlySalary > 1000 &&
          (form.monthlyExpenses < form.monthlySalary / 3) &&
          loanCost < form.monthlySalary / 3;

      if (loanCanBeApproved) {
        mockUserBalance += form.amount;
        mockTransactions.add(
          Transaction(
            id: generateRandomString(1000),
            name: "Loan",
            type: TransactionType.topUp,
            amount: form.amount,
            createdAt: DateTime.now(),
          ),
        );
      }

      return loanCanBeApproved ? LoanStatus.approved : LoanStatus.declined;
    } catch (e) {
      return LoanStatus.declined;
    }
  }

  Future<int> _fetchRandomValue() async {
    final response = await get(
      Uri.parse(
          "https://www.randomnumberapi.com/api/v1.0/random?min=0&max=100&count=1"),
      headers: {
        "accept": "application/json",
      },
    );
    if (response.statusCode == 200) {
      final random = json.decode(response.body)[0];
      return random;
    } else {
      throw Exception("Failed to fetch data");
    }
  }
}
