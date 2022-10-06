import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:money_app/data/entity/transaction.dart';
import 'package:money_app/presentation/screens/loan/loan_screen.dart';
import 'package:money_app/presentation/screens/pay/pay_screen.dart';

class ActionCards extends StatelessWidget {
  const ActionCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _actionButton(
                icon: SvgPicture.asset("assets/icons/ic_phone.svg"),
                title: 'Pay',
                onPressed: () {
                  Get.to(() => PayScreen(paymentType: TransactionType.payment));
                },
              ),
              _actionButton(
                icon: SvgPicture.asset("assets/icons/ic_wallet.svg"),
                title: 'Top Up',
                onPressed: () {
                  Get.to(() => PayScreen(paymentType: TransactionType.topUp));
                },
              ),
              _actionButton(
                icon: SvgPicture.asset("assets/icons/ic_loan.svg"),
                title: 'Loan',
                onPressed: () {
                  Get.to(() => const LoanScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionButton({
    required Widget icon,
    required String title,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          icon,
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
