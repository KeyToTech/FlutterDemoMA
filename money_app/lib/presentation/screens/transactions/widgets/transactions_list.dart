import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_app/data/entity/transaction.dart';
import 'package:money_app/presentation/screens/transactions/widgets/transaction_amount.dart';
import 'package:money_app/presentation/widgets/transaction_icon.dart';

class HeadingItem extends StatelessWidget {
  final String heading;

  const HeadingItem(this.heading, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
      child: Text(
        heading.toUpperCase(),
        style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFB0B3B8)),
      ),
    );
  }
}

class TransactionItemView extends StatelessWidget {
  final Transaction item;

  const TransactionItemView(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: TransactionIcon(type: item.type),
                ),
                SizedBox(width: 10.w),
                Text(
                  item.name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            TransactionAmount(
              amount: item.amount,
              type: item.type,
              fontSize: 14.sp,
            ),
          ],
        ),
      ),
    );
  }
}
