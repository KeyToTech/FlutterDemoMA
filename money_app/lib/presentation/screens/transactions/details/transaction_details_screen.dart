import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:money_app/data/entity/transaction.dart';
import 'package:money_app/presentation/screens/transactions/details/transaction_details_controller.dart';
import 'package:money_app/presentation/screens/transactions/details/widgets/header_details.dart';
import 'package:money_app/presentation/widgets/widgets.dart';

class TransactionDetailsScreen extends StatefulWidget {
  static const String routeName = '/transaction_details';

  final String transactionId;

  const TransactionDetailsScreen({super.key, required this.transactionId});

  @override
  _TransactionDetailsScreenState createState() =>
      _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen> {
  final _controller = Get.find<TransactionDetailsController>();
  var _subscriptionOn = false;

  @override
  void initState() {
    super.initState();
    _controller.fetchTransactionDetails(widget.transactionId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MaAppBar().buildAppBarWithBackIcon('MoneyApp'),
      body: Obx(
        () => _controller.isLoading.value || _controller.transaction == null
            ? const Center(child: CircularProgressIndicator())
            : _body(_controller.transaction!),
      ),
    );
  }

  _body(Transaction transaction) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0.w),
              child: HeaderDetails(
                transaction: transaction,
              ),
            ),
            _spacer(),
            _addReceipt(),
            _spacer(),
            if (transaction.type == TransactionType.payment)
              _splitThisBill(transaction.id),
            if (transaction.type == TransactionType.payment) _subscription(),
            _spacer(),
            InkWell(
              onTap: () {
                Get.defaultDialog(
                  middleText: "Help is on the way, stay put!",
                  backgroundColor: Colors.white,
                  titleStyle: const TextStyle(color: Colors.black),
                  middleTextStyle: const TextStyle(color: Colors.black),
                );
              },
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
                  child: Text(
                    "Something wrong? Get help",
                    style: TextStyle(
                        color: const Color(0xFFFF0000),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            SizedBox(height: 48.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Center(
                  child: Text(
                // TODO add data here
                "Transaction ID #${transaction.id} ${transaction.name} - Merchant ID #1245",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: const Color(0xFFB0B3B8),
                  fontWeight: FontWeight.w600,
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Padding _title(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Text(text, style: Theme.of(context).textTheme.titleMedium),
    );
  }

  SizedBox _spacer() => SizedBox(height: 31.h);

  Widget _rowButton(Widget icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
          child: Row(
            children: [
              icon,
              SizedBox(width: 8.w),
              Text(
                label,
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _addReceipt() {
    return _rowButton(
        SvgPicture.asset(
          "assets/icons/ic_receipt.svg",
          width: 20.w,
          height: 20.h,
        ),
        "Add receipt",
        () {});
  }

  Widget _splitThisBill(String transactionId) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(context, "SHARE THE COST"),
        SizedBox(
          height: 8.h,
        ),
        _rowButton(
            SvgPicture.asset(
              "assets/icons/ic_split_bill.svg",
              width: 20.w,
              height: 20.h,
            ),
            "Split this bill", () {
          _controller.splitBill(transactionId);
        }),
      ],
    );
  }

  Column _subscription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _spacer(),
        _title(context, "SUBSCRIPTION"),
        SizedBox(
          height: 8.h,
        ),
        SwitchRow(
          title: "Repeating payment",
          value: _subscriptionOn,
          onChanged: (bool value) {
            setState(() {
              _subscriptionOn = value;
            });
            _controller.repeatPayment(widget.transactionId);
          },
        ),
      ],
    );
  }
}
