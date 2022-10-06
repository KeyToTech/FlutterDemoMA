import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_app/data/entity/transaction.dart';

class TransactionAmount extends StatelessWidget {
  final double amount;
  final TransactionType type;
  final double fontSize;

  const TransactionAmount({
    super.key,
    required this.amount,
    required this.type,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      _amount(),
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: _amountColor(context),
      ),
    );
  }

  _amount() {
    return type == TransactionType.payment ? "$amount" : "+$amount";
  }

  _amountColor(BuildContext context) {
    return type == TransactionType.payment
        ? Colors.black
        : Theme.of(context).primaryColor;
  }
}
