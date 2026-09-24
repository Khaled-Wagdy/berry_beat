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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
        child: Column(
          children: [
            SizedBox(height: 100.h),
            CustomTextFormField(
              hintText: AppLocale.username.getString(context),
              label: AppLocale.username.getString(context),
              controller: usernameController,
            ),
            SizedBox(height: 20.h),
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
            SizedBox(height: 20.h),
            CustomTextFormField(
              hintText: AppLocale.confirmPasswordHint.getString(context),
              label: AppLocale.confirmPassword.getString(context),
              controller: confirmPasswordController,
              isPassword: true,
            ),
            SizedBox(height: 60.h),
            BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthLoadingState) {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        const Center(child: CircularProgressIndicator()),
                  );
                }
                if (state is AuthErrorState) {
                  Navigator.pop(context); // Close the loading dialog
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(AppLocale.error.getString(context)),
                      content: Text(state.message),
                    ),
                  );
                } else if (state is AuthSuccessState) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.signInScreen,
                    (route) => false,
                  );
                }
              },
              child: const SizedBox.shrink(),
            ),
            AppBottom(
              text: AppLocale.signUp.getString(context),
              onTap: () {
                context.read<AuthCubit>().signUp(
                  fullName: usernameController.text,
                  userName: usernameController.text,
                  email: emailController.text,
                  password: passwordController.text,
                  confirmPassword: confirmPasswordController.text,
                  country: '',
                  phoneNumber: '',
                );
              },
              barColor: AppColor.primaryColor,
            ),
            SizedBox(height: 60.h),

            RowCoustom(
              text: AppLocale.alreadyHaveAccount.getString(context),
              actionText: AppLocale.signIn.getString(context),
              onTap: () => Navigator.pushNamed(context, Routes.signInScreen),
            ),
          ],
        ),
      ),
    );
  }
}
