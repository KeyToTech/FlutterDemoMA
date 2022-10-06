import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_app/presentation/screens/loan/loan_controller.dart';
import 'package:money_app/presentation/widgets/widgets.dart';

class LoanScreen extends StatefulWidget {
  static const String routeName = '/loan';

  const LoanScreen({super.key});

  @override
  _LoanScreenState createState() => _LoanScreenState();
}

class _LoanScreenState extends State<LoanScreen> {
  final LoanController _controller = Get.find();

  @override
  void initState() {
    super.initState();
    if (_controller.initialized) {
      _controller.init();
      ever(
          _controller.alertMessage,
          (alertMessage) => {
                if (Get.isDialogOpen == false &&
                    alertMessage.title.isNotEmpty &&
                    alertMessage.message.isNotEmpty)
                  {
                    Get.defaultDialog(
                      title: alertMessage.title,
                      middleText: alertMessage.message,
                      backgroundColor: Colors.white,
                      titleStyle: alertMessage.isError
                          ? const TextStyle(color: Colors.red)
                          : const TextStyle(color: Colors.black),
                      middleTextStyle: const TextStyle(color: Colors.black),
                    )
                  }
              },
          onDone: () => _controller.alertMessage(AlertMessage.empty()));
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: MaAppBar().buildAppBarWithBackIcon("Loan Application"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: height,
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 17.w, vertical: 11.h),
                  child: _termsAndConditions(),
                ),
                Obx(
                  () => SwitchRow(
                    title: "Accept Terms & Conditions",
                    value: _controller.acceptedTerms.value,
                    onChanged: (bool value) {
                      _controller.toggleAcceptedTerms();
                    },
                  ),
                ),
                _aboutYou(),
                _loan(),
                _applyButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _termsAndConditions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Terms and Conditions',
          style: TextStyle(fontSize: 23.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10.h),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam elementum enim non neque luctus, nec blandit ipsum sagittis. Sed fringilla blandit nibh, sit amet suscipit massa sollicitudin lacinia. Donec cursus, odio sit amet tincidunt sodales, odio nisl hendrerit sem, tempor tincidunt ligula nisl nec ante. Nulla aliquet aliquam justo, ac bibendum orci rhoncus non. Nullam quis ex elementum, pharetra ligula eleifend, convallis nulla. Nulla sit amet nisi viverra, semper nunc eu, posuere dui. Donec at metus ut eros rhoncus vestibulum vitae at lacus. Etiam imperdiet, nulla ac condimentum aliquam, enim lacus fringilla leo, vel hendrerit mi ipsum et ante. Vivamus finibus mauris eget diam sodales, eget efficitur orci laoreet. Sed feugiat odio quis mattis tristique. Mauris sit amet sem mauris.',
          style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400),
        )
      ],
    );
  }

  _form(String label, Form form) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.only(left: 17.w, right: 17.w, top: 15.h, bottom: 5.h),
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        form
      ],
    );
  }

  _aboutYou() {
    return _form(
      "ABOUT YOU",
      Form(
        child: Column(
          children: [
            _numberInput(
                labelText: 'Monthly Salary',
                onChanged: (value) {
                  _controller.updateMonthlySalary(value);
                }),
            _numberInput(
                labelText: 'Monthly Expenses',
                onChanged: (value) {
                  _controller.updateMonthlyExpenses(value);
                }),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      border: InputBorder.none,
    );
  }

  _loan() {
    return _form(
      "LOAN",
      Form(
        child: Column(
          children: [
            _numberInput(
                labelText: 'Amount',
                onChanged: (value) {
                  _controller.updateAmount(value);
                }),
            _numberInput(
                labelText: 'Term',
                onChanged: (value) {
                  _controller.updateTerm(value);
                }),
          ],
        ),
      ),
    );
  }

  TextFormField _numberInput(
      {required String labelText, required Function(String) onChanged}) {
    return TextFormField(
      decoration: _inputDecoration(labelText),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: onChanged,
    );
  }

  Widget _applyButton() {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 80.w),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(60.h),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 14.h),
          ),
          onPressed: _controller.isFormValid
              ? () {
                  _controller.applyForLoan();
                }
              : null,
          child: Text(
            "Apply for loan",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
