import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBottom extends StatelessWidget {
  const AppBottom({
    super.key,
    required this.text,

    this.onTap,
    required this.barColor,
  });

  final String text;
  final Color barColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 300.w,
        padding: EdgeInsets.symmetric(vertical: 15.h),
        decoration: BoxDecoration(
          border: barColor == null
              ? null
              : Border.all(color: Colors.black, width: 1.5),
          color: barColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: barColor == Colors.white ? Colors.black : Colors.white,
              fontSize: 15.sp,
            ),
          ),
        ),
      ),
    );
  }
}
