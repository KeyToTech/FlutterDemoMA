import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:money_app/data/entity/transaction.dart';
import 'package:money_app/presentation/screens/pay/widgets/pay_button.dart';
import 'package:money_app/presentation/screens/transactions/transactions_controller.dart';
import 'package:money_app/presentation/widgets/widgets.dart';

import 'pay_whom_screen.dart';

class PayScreen extends StatefulWidget {
  static const String routeName = '/pay';

  final TransactionType paymentType;

  PayScreen({super.key, required this.paymentType});

  @override
  _PayScreenState createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  String _amount = "0.0";
  String _beforeDot = "0";
  String _afterDot = "0";
  bool _dotPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MaAppBar().buildAppBarWithCloseIcon('MoneyApp'),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).colorScheme.primary,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 50.h),
                child: Text(
                  'How much?',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const Spacer(),
              AmountLabel(
                amount: _amount,
              ),
              const Spacer(),
              _numberKeyboard(),
              const Spacer(),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 50.h),
                child: _nextButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nextButton() {
    String inString = double.parse(_amount).toStringAsFixed(2);
    final amount = double.parse(inString);
    var enabled = amount > 0.0;
    return PayButton(
        text: widget.paymentType == TransactionType.payment ? 'Next' : 'Top-up',
        enabled: enabled,
        onPressed: () {
          final TransactionsController controller = Get.find();
          if (widget.paymentType == TransactionType.payment) {
            Get.to(() => PayWhomScreen(
                  amount: amount,
                ));
          } else {
            controller.topUp(
              amount: double.parse(_amount),
            );
            Get.back();
          }
        });
  }

  Widget _rowSpacer() {
    return SizedBox(height: 32.h);
  }

  Widget _numberKeyboard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _numberButton(1),
              _numberButton(2),
              _numberButton(3),
            ],
          ),
          _rowSpacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _numberButton(4),
              _numberButton(5),
              _numberButton(6),
            ],
          ),
          _rowSpacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _numberButton(7),
              _numberButton(8),
              _numberButton(9),
            ],
          ),
          _rowSpacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _charButton('.', () {
                setState(() {
                  if (!_dotPressed) {
                    _dotPressed = true;
                  }
                });
              }),
              _numberButton(0),
              InkWell(
                onTap: () {
                  if (_dotPressed && _afterDot.isNotEmpty && _afterDot != "0") {
                    _deleteRightChar();
                  } else {
                    setState(() {
                      _dotPressed = false;
                    });
                    _deleteLeftChar();
                  }
                },
                child: SizedBox(
                  width: 40.w,
                  height: 40.h,
                  child: Padding(
                    padding: EdgeInsets.all(10.0.w),
                    child: SvgPicture.asset(
                      "assets/icons/ic_left.svg",
                      width: 11.w,
                      height: 22.h,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _deleteRightChar() {
    setState(() {
      if (_afterDot.length == 1) {
        _afterDot = "0";
      } else {
        _afterDot = _afterDot.substring(0, _afterDot.length - 1);
      }
      _amount = "$_beforeDot.$_afterDot";
    });
  }

  void _deleteLeftChar() {
    setState(() {
      if (_beforeDot.length == 1) {
        _beforeDot = "0";
      } else {
        _beforeDot = _beforeDot.substring(0, _beforeDot.length - 1);
      }
      _amount = "$_beforeDot.$_afterDot";
    });
  }

  void _updateAmount(int number) {
    setState(() {
      // TODO could be covered with tests
      if (_amount == "0.0") {
        _dotPressed = false;
      }
      if (!_dotPressed) {
        _beforeDot = _beforeDot == "0" ? "$number" : "$_beforeDot$number";
      } else {
        if (_afterDot == "0" && number == 0) {
          _afterDot = "$number";
        } else {
          _afterDot = "$_afterDot$number";
        }
      }
      _amount = "$_beforeDot.$_afterDot";
    });
  }

  _numberButton(int number) {
    return InkWell(
      onTap: () {
        _updateAmount(number);
      },
      child: SizedBox(
        width: 40.w,
        height: 40.h,
        child: Text(number.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.sp,
              fontWeight: FontWeight.w600,
            )),
      ),
    );
  }

  _charButton(String s, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 40.w,
        height: 40.h,
        child: Text(s,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.sp,
              fontWeight: FontWeight.w600,
            )),
      ),
    );
  }
}
