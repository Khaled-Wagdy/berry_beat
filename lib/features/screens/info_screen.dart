import 'package:bery_beat/core/custom/app_bottom.dart';
import 'package:bery_beat/core/thems/app_color.dart';
import 'package:bery_beat/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:bery_beat/core/localization/app_locale.dart';
import 'package:bery_beat/core/custom/language_toggle_button.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 10.h,
              right: 20.w,
              child: const LanguageToggleButton(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  SizedBox(height: 100.h),

                  Text(
                    AppLocale.infoTitle.getString(context),
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
                    AppLocale.infoSubtitle.getString(context),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: 40.h),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(40.r),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D6D4D),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Image.asset(
                      'assets/image/logo_strawberry_image.png',
                      height: 200.h,
                      fit: BoxFit.contain,
                    ),
                  ),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    child: AppBottom(
                      text: AppLocale.getStarted.getString(context),
                      barColor: AppColor.primaryColor,
                      onTap: () {
                        Navigator.pushReplacementNamed(context, Routes.featureScreen);
                      },
                    ),
                  ),

                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
