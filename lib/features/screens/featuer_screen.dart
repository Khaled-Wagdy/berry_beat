import 'package:bery_beat/core/custom/app_bottom.dart';
import 'package:bery_beat/core/custom/build_featuer_item.dart';
import 'package:bery_beat/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:bery_beat/core/localization/app_locale.dart';
import 'package:bery_beat/core/custom/language_toggle_button.dart';

class FeatureScreen extends StatelessWidget {
  const FeatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9EBEF),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: SizedBox(
                height: 50.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      AppLocale.ourFeatures.getString(context),
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF134E3D),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: LanguageToggleButton(
                        backgroundColor: Colors.white,
                        textColor: const Color(0xFF134E3D),
                        borderColor: const Color(0xFF134E3D).withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Image.asset(
              'assets/image/featuers_image.png',
              width: 100.w,
              height: 100.h,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 30.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FeatureItem(
                      title: AppLocale.earlyDetectionTitle.getString(context),
                      desc: AppLocale.earlyDetectionDesc.getString(context),
                      color: const Color(0xFF8B1A1A),
                    ),
                    FeatureItem(
                      title: AppLocale.aiDiagnosisTitle.getString(context),
                      desc: AppLocale.aiDiagnosisDesc.getString(context),
                      color: const Color(0xFF134E3D),
                    ),
                    FeatureItem(
                      title: AppLocale.readyTreatmentTitle.getString(context),
                      desc: AppLocale.readyTreatmentDesc.getString(context),
                      color: const Color(0xFF8B1A1A),
                    ),
                    Column(
                      children: [
                        AppBottom(
                          text: AppLocale.signIn.getString(context),
                          barColor: const Color(0xFF22B387),
                          onTap: () => Navigator.pushNamed(context, Routes.signInScreen),
                        ),
                        SizedBox(height: 15.h),
                        AppBottom(
                          text: AppLocale.signUp.getString(context),
                          barColor: const Color(0xFF22B387),
                          onTap: () => Navigator.pushNamed(context, Routes.signUpScreen),
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
