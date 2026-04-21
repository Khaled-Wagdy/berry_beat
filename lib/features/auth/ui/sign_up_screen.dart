import 'package:bery_beat/core/custom/app_bottom.dart';
import 'package:bery_beat/core/custom/custom_bottom_app_bar.dart';
import 'package:bery_beat/core/custom/custom_text_form_field.dart';
import 'package:bery_beat/core/custom/row_costom.dart';
import 'package:bery_beat/core/thems/colar_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0E0E0),
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
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 200),
            CustomTextFormField(hintText: 'Username', label: 'Username'),
            SizedBox(height: 20),
            CustomTextFormField(hintText: 'Enter your email', label: 'Email'),
            SizedBox(height: 20),
            CustomTextFormField(
              hintText: 'Enter your password',
              label: 'Password',
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              hintText: 'Confirm your password',
              label: 'Confirm Password',
            ),
            SizedBox(height: 60),
            AppBottom(
              text: 'Sign Up',
              onTap: () {},
              barColor: const Color(0xFF22B387),
            ),
            SizedBox(height: 30),
            RowCoustom(
              text: 'Already have an account?',
              actionText: 'Sign In',
              onTap: () => Navigator.pushNamed(context, '/signIn'),
            ),
          ],
        ),
      ),
    );
  }
}
