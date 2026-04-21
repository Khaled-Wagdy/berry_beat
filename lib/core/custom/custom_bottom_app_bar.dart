import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({super.key, required this.barColor});

  final Color barColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            height: 70.h,
            width: double.infinity,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(color: barColor),
          ),
        ],
      ),
    );
  }
}
