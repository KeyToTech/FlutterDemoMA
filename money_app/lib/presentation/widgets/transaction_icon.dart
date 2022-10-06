import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:money_app/data/entity/transaction.dart';

class TransactionIcon extends StatelessWidget {
  final TransactionType type;

  const TransactionIcon({required this.type});

  @override
  Widget build(BuildContext context) {
    return type == TransactionType.payment
        ? SvgPicture.asset("assets/icons/transactions/ic_payment.svg")
        : SvgPicture.asset("assets/icons/transactions/ic_top_up.svg");
  }
}
