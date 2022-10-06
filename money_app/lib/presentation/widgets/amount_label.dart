import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const currency = '£';

class AmountLabel extends StatelessWidget {
  final String amount;

  const AmountLabel({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    final labels = amount.split('.');
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: currency,
            style: TextStyle(
                color: Colors.white,
                fontSize: 25.sp,
                fontWeight: FontWeight.w600),
          ),
          TextSpan(
            text: "${labels[0]}.",
            style: TextStyle(
                color: Colors.white,
                fontSize: 50.sp,
                fontWeight: FontWeight.w600),
          ),
          TextSpan(
            text: labels[1],
            style: TextStyle(
                color: Colors.white,
                fontSize: 25.sp,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
