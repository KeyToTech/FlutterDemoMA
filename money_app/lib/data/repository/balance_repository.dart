var mockUserBalance = 150.25;

class BalanceRepository {
  Future<double> fetchBalance() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => mockUserBalance,
    );
  }
}
