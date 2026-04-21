import 'package:bery_beat/core/custom/app_bottom.dart';
import 'package:bery_beat/core/custom/custom_bottom_app_bar.dart';
import 'package:bery_beat/core/custom/custom_text_form_field.dart';
import 'package:bery_beat/core/custom/row_costom.dart';
import 'package:bery_beat/core/thems/colar_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0E0E0),

      bottomNavigationBar: CustomBottomAppBar(
        barColor: const Color(0xFF115943),
      ),
      appBar: AppBar(
        backgroundColor: ColorApp.backgroundColor,
        elevation: 0,
        title: Center(
          child: Text(
            'BerryBeat',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        // ✅ بيمنع الـ overflow
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 80.h), // ✅ قللنا المسافة
              CustomTextFormField(hintText: 'Enter your email', label: 'Email'),
              SizedBox(height: 20.h),
              CustomTextFormField(
                hintText: 'Enter your password',
                label: 'Password',
              ),
              SizedBox(height: 60.h), // ✅ قللنا المسافة
              AppBottom(
                text: 'Sign In',
                onTap: () {},
                barColor: const Color(0xFF22B387),
              ),
              SizedBox(height: 20.h),
              RowCoustom(
                text: 'Don\'t have an account?',
                actionText: 'Sign Up',
                onTap: () {
                  Navigator.pushNamed(context, '/signUp');
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
