import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_app/data/entity/transaction.dart';
import 'package:money_app/presentation/date_ext.dart';
import 'package:money_app/presentation/screens/transactions/details/transaction_details_screen.dart';
import 'package:money_app/presentation/screens/transactions/transactions_controller.dart';
import 'package:money_app/presentation/widgets/amount_label.dart';
import 'package:money_app/presentation/widgets/ma_app_bar.dart';

import 'widgets/action_cards.dart';
import 'widgets/transactions_list.dart';

class TransactionsScreen extends StatefulWidget {
  static const String routeName = '/transactions';

  const TransactionsScreen({super.key});

  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final TransactionsController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MaAppBar().buildAppBarWithTitle('MoneyApp'),
      body: Obx(
        () => _controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: _body(),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _body() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 210.h,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 50.h),
                child: Obx(
                  () => AmountLabel(
                    amount: _controller.currentBalance,
                  ),
                ),
              ),
              const ActionCards(),
              _transactionsList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _transactionsList() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            child: Text(
              "Recent Activity",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _controller.transactions.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              DateTime key = _controller.transactions.keys.elementAt(index);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadingItem(key.toRelativeFormat()),
                  for (Transaction transaction
                      in _controller.transactions[key]!)
                    InkWell(
                      onTap: () {
                        Get.to(() => TransactionDetailsScreen(
                              transactionId: transaction.id,
                            ));
                      },
                      child: TransactionItemView(transaction),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
