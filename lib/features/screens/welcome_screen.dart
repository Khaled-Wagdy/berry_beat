import 'package:bery_beat/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:bery_beat/core/localization/app_locale.dart';
import 'package:bery_beat/core/custom/language_toggle_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/image/strawberry_image.png',
              fit: BoxFit.cover,
            ),
          ),

          // Language Toggle Button
          Positioned(
            top: 50.h,
            right: 20.w,
            child: const LanguageToggleButton(),
          ),

          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 24.w),
              padding: EdgeInsets.all(32.r),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/image/logo_strawberry_image.png',
                        height: 50.h,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'BerryBeat',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFA7F8DF),
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // Main Title
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                        height: 1.2.h,
                      ),
                      children: [
                        TextSpan(text: AppLocale.welcomeSubtitle1.getString(context)),
                        TextSpan(
                          text: AppLocale.welcomeSubtitle2.getString(context),
                          style: const TextStyle(color: Color(0xFFE31E24)),
                        ),
                        TextSpan(text: AppLocale.welcomeSubtitle3.getString(context)),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),

                  // Next Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, Routes.infoScreen);
                      },
                      child: Container(
                        padding: EdgeInsets.all(12.r),
                        decoration: const BoxDecoration(
                          color: Color(0xFFE31E24),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
