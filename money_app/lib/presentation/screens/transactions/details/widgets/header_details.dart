import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:money_app/data/entity/transaction.dart';
import 'package:money_app/presentation/date_ext.dart';
import 'package:money_app/presentation/screens/transactions/widgets/transaction_amount.dart';

class HeaderDetails extends StatelessWidget {
  final Transaction transaction;

  const HeaderDetails({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 64.w,
              height: 64.h,
              child: SvgPicture.asset(
                "assets/icons/transactions/ic_payment.svg",
              ),
            ),
            TransactionAmount(
              amount: transaction.amount,
              type: transaction.type,
              fontSize: 27.sp,
            ),
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          transaction.name,
          style: TextStyle(
              fontSize: 23.sp,
              color: Colors.black,
              fontWeight: FontWeight.w600),
        ),
        Text(
          transaction.createdAt.toStandardFormat(),
          style: TextStyle(
              fontSize: 10.sp,
              color: const Color(0xFFB0B3B8),
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
