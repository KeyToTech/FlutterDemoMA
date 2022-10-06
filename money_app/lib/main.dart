import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_app/data/repository/repository.dart';
import 'package:money_app/presentation/screens/loan/loan_controller.dart';
import 'package:money_app/presentation/screens/pay/pay_screen.dart';
import 'package:money_app/presentation/screens/transactions/details/transaction_details_controller.dart';
import 'package:money_app/presentation/screens/transactions/transactions_screen.dart';
import 'package:get/get.dart';

import 'data/repository/balance_repository.dart';
import 'data/repository/loan_repository.dart';
import 'domain/loan_service.dart';
import 'presentation/screens/transactions/transactions_controller.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );
  } catch (e) {
    print(e.toString());
  }
  runApp(const MoneyApp());
}

class MoneyApp extends StatelessWidget {
  const MoneyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO refactor
    final TransactionsRepository transactionsRepository =
        TransactionsRepository();
    final BalanceRepository balanceRepository = BalanceRepository();

    Get.put(TransactionsController(
        transactionsRepository: transactionsRepository,
        balanceRepository: balanceRepository));
    Get.put(LoanController(
        loanService: LoanService(LoanRepository(), BalanceRepository())));
    Get.put(TransactionDetailsController());

    return ScreenUtilInit(
      designSize: const Size(378, 812),
      builder: (context, child) => GetMaterialApp(
        title: 'MoneyApp',
        theme: _theme(),
        home: const TransactionsScreen(),
      ),
    );
  }

  ThemeData _theme() {
    return ThemeData(
      fontFamily: 'Montserrat',
      primarySwatch: createMaterialColor(const Color(0xFFC0028B)),
      primaryColor: const Color.fromRGBO(192, 2, 139, 1),
      primaryColorLight: const Color(0xFFB0B3B8),
      backgroundColor: const Color(0xFF18191A),
      cardColor: const Color(0xFF242526),
      disabledColor: const Color(0xFFF7F7F7),
      textTheme: TextTheme(
        titleMedium: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
      ),
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        color: Color.fromRGBO(192, 2, 139, 1),
      ),
    );
  }
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
