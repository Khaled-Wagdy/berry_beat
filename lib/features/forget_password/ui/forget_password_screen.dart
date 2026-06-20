import 'package:bery_beat/core/custom/app_bottom.dart';
import 'package:bery_beat/core/custom/custom_text_form_field.dart';
import 'package:bery_beat/core/custom/row_costom.dart';
import 'package:bery_beat/core/routes/routes.dart';
import 'package:bery_beat/core/thems/app_color.dart';
import 'package:bery_beat/features/forget_password/cubit/forget_password_cubit.dart';
import 'package:bery_beat/features/forget_password/cubit/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:bery_beat/core/localization/app_locale.dart';
import 'package:bery_beat/core/custom/language_toggle_button.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColor.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(child: LanguageToggleButton()),
          ),
        ],
      ),
      body: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state is CodeSentSuccess) {
            Navigator.pushNamed(context, Routes.otpScreen);
          } else if (state is ForgetPasswordError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text(
                  AppLocale.forgotPasswordTitle.getString(context),
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  AppLocale.forgetPasswordDesc.getString(context),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 80.h),
                CustomTextFormField(
                  controller: _emailController,
                  hintText: AppLocale.emailHint.getString(context),
                  keyboardType: TextInputType.emailAddress,
                  label: AppLocale.email.getString(context),
                ),
                SizedBox(height: 50.h),
                state is ForgetPasswordLoading
                    ? const Center(child: CircularProgressIndicator())
                    : AppBottom(
                        text: AppLocale.resetPassword.getString(context),
                        onTap: () {
                          if (_emailController.text.isNotEmpty) {
                            context
                                .read<ForgetPasswordCubit>()
                                .sendCode(_emailController.text);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppLocale.pleaseEnterEmail.getString(context),
                                ),
                              ),
                            );
                          }
                        },
                        barColor: AppColor.primaryColor,
                      ),
                SizedBox(height: 280.h),
                RowCoustom(
                  text: AppLocale.rememberPassword.getString(context),
                  actionText: AppLocale.login.getString(context),
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, Routes.signInScreen);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
