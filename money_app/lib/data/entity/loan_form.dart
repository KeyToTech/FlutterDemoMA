class LoanForm {
  final double monthlySalary;
  final double monthlyExpenses;
  final double amount;
  final double term;

  LoanForm({
    required this.monthlySalary,
    required this.monthlyExpenses,
    required this.amount,
    required this.term,
  });

  static LoanForm initial() {
    return LoanForm(monthlySalary: 0, monthlyExpenses: 0, amount: 0, term: 0);
  }

  LoanForm copyWith({
    double? monthlySalary,
    double? monthlyExpenses,
    double? amount,
    double? term,
  }) {
    return LoanForm(
      monthlySalary: monthlySalary ?? this.monthlySalary,
      monthlyExpenses: monthlyExpenses ?? this.monthlyExpenses,
      amount: amount ?? this.amount,
      term: term ?? this.term,
    );
  }

  bool isValid() {
    return monthlySalary > 0 && monthlyExpenses >= 0 && amount > 0 && term > 0;
  }
}
