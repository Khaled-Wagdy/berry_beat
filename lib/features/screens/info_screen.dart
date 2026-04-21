import 'dart:async';

import 'package:bery_beat/core/thems/colar_app.dart';
import 'package:bery_beat/features/screens/featuer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const FeatureScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 100.h),

              Text(
                'The system that applies artificial intelligence in agriculture',
                textAlign: TextAlign.center,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),

              SizedBox(height: 20.h),

              Text(
                'Through this work, we seek smarter farming practices, improved crop quality, and reduced agricultural losses.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 15.sp,
                  color: Colors.white.withValues(alpha: 0.8),
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),

              SizedBox(height: 40.h),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(40.r),
                decoration: BoxDecoration(
                  color: Color(0xFF0D6D4D),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Image.asset(
                  'assets/image/logo_strawberry_image.png',
                  height: 200.h,
                  fit: BoxFit.contain,
                ),
              ),

              const Spacer(),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
