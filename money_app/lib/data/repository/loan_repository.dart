
var mockLoanData = {"firstLoan": true};

class LoanRepository {
  Future<Map<String, dynamic>> getLoanData() async {
    return mockLoanData;
  }

  Future<bool> isFirstLoan() async {
    final data = await getLoanData();
    return data["firstLoan"];
  }
}
