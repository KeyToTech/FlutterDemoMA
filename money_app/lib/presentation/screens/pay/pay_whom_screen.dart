import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_app/presentation/screens/transactions/transactions_controller.dart';
import 'package:money_app/presentation/screens/transactions/transactions_screen.dart';
import 'package:money_app/presentation/widgets/ma_app_bar.dart';

import 'widgets/pay_button.dart';

class PayWhomScreen extends StatefulWidget {
  static const String routeName = '/pay_whom';

  final double amount;

  const PayWhomScreen({super.key, required this.amount});

  @override
  _PayWhomScreenState createState() => _PayWhomScreenState();
}

class _PayWhomScreenState extends State<PayWhomScreen> {
  final _toWhomController = TextEditingController();
  var _buttonEnabled = false;

  @override
  void initState() {
    super.initState();
    _toWhomController.addListener(() {
      setState(() {
        _buttonEnabled = _toWhomController.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MaAppBar().buildAppBarWithCloseIcon("MoneyApp"),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 50.h),
                child: Text(
                  'To whom?',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48.w),
                  child: TextFormField(
                    controller: _toWhomController,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 50.h),
                child: _payButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _payButton() {
    return PayButton(
        text: 'Pay',
        enabled: _buttonEnabled,
        onPressed: () {
          final TransactionsController controller = Get.find();
          controller.makePayment(widget.amount, _toWhomController.text);
          Get.to(() => const TransactionsScreen());
        });
  }

  @override
  void dispose() {
    _toWhomController.dispose();
    super.dispose();
  }
}
