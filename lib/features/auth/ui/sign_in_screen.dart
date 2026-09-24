import 'package:bery_beat/core/custom/app_bottom.dart';
import 'package:bery_beat/core/custom/custom_bottom_app_bar.dart';
import 'package:bery_beat/core/custom/custom_text_form_field.dart';
import 'package:bery_beat/core/custom/row_costom.dart';
import 'package:bery_beat/core/routes/routes.dart';
import 'package:bery_beat/core/thems/app_color.dart';
import 'package:bery_beat/features/auth/cubit/auth_cubit.dart';
import 'package:bery_beat/features/auth/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:bery_beat/core/localization/app_locale.dart';
import 'package:bery_beat/core/custom/language_toggle_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0E0E0),

      bottomNavigationBar: CustomBottomAppBar(
        barColor: const Color(0xFF115943),
      ),
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
        title: Text(
          'BerryBeat',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(child: LanguageToggleButton()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 80.h),
              CustomTextFormField(
                hintText: AppLocale.emailHint.getString(context),
                label: AppLocale.email.getString(context),
                controller: emailController,
              ),
              SizedBox(height: 20.h),
              CustomTextFormField(
                hintText: AppLocale.passwordHint.getString(context),
                label: AppLocale.password.getString(context),
                controller: passwordController,
                isPassword: true,
              ),
              SizedBox(height: 10.h),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.forgetPasswordScreen);
                  },
                  child: Text(
                    AppLocale.forgotPassword.getString(context),
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccessState) {
                    Navigator.pushReplacementNamed(context, Routes.homeScreen);
                  } else if (state is AuthErrorState) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoadingState) {
                    return const CircularProgressIndicator();
                  }
                  return AppBottom(
                    text: AppLocale.signIn.getString(context),
                    onTap: () {
                      context.read<AuthCubit>().signIn(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    },
                    barColor: AppColor.primaryColor,
                  );
                },
              ),
              SizedBox(height: 60.h),

              RowCoustom(
                text: AppLocale.dontHaveAccount.getString(context),
                actionText: AppLocale.signUp.getString(context),
                onTap: () {
                  Navigator.pushNamed(context, Routes.signUpScreen);
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
