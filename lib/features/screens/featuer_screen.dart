import 'package:bery_beat/core/custom/app_bottom.dart';
import 'package:bery_beat/core/custom/build_featuer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FeatureScreen extends StatelessWidget {
  const FeatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9EBEF),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Text(
              'our features',
              style: GoogleFonts.playfairDisplay(
                fontSize: 38.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF134E3D),
              ),
            ),
            SizedBox(height: 20.h),
            Image.asset(
              'assets/image/featuers_image.png',
              height: 120.h,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 30.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FeatureItem(
                      title: 'early detection',
                      desc:
                          'We detect strawberry diseases and nutrient deficiencies at an early stage before they spread and cause serious damage.',
                      color: const Color(0xFF8B1A1A),
                    ),
                    FeatureItem(
                      title: 'Accurate AI Diagnosis',
                      desc:
                          'Upload a plant image and our program analyzes the symptoms to identify the exact problem quickly and accurately.',
                      color: const Color(0xFF134E3D),
                    ),
                    FeatureItem(
                      title: 'Ready Treatment',
                      desc:
                          'Once the issue is detected, we provide clear, ready-to-apply treatment recommendations to restore plant health.',
                      color: const Color(0xFF8B1A1A),
                    ),
                    Column(
                      children: [
                        AppBottom(
                          text: 'Sign In',
                          barColor: const Color(0xFF22B387),
                          onTap: () => Navigator.pushNamed(context, '/signIn'),
                        ),
                        SizedBox(height: 15.h),
                        AppBottom(
                          text: 'Sign Up',
                          barColor: const Color(0xFF22B387),
                          onTap: () => Navigator.pushNamed(context, '/signUp'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
