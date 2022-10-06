import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PayButton extends StatelessWidget {
  final String text;
  final bool enabled;
  final VoidCallback onPressed;

  const PayButton({
    super.key,
    required this.text,
    required this.enabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(60.h),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 14.h),
        backgroundColor: const Color(0xFFF7F7F7).withOpacity(0.5),
        disabledBackgroundColor: const Color(0xFFF7F7F7).withOpacity(0.5),
      ),
      onPressed: enabled ? onPressed : null,
      child: Text(
        text,
        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
      ),
    );
  }
}
