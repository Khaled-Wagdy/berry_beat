import 'package:bery_beat/core/custom/app_bottom.dart';
import 'package:bery_beat/core/custom/custom_text_form_field.dart';
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

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
          if (state is PasswordResetSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  AppLocale.passwordResetSuccess.getString(context),
                ),
              ),
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.signInScreen,
              (route) => false,
            );
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
                  AppLocale.createNewPassword.getString(context),
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  AppLocale.newPasswordDesc.getString(context),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 60.h),
                CustomTextFormField(
                  controller: _passwordController,
                  hintText: AppLocale.passwordHint.getString(context),
                  keyboardType: TextInputType.visiblePassword,
                  label: AppLocale.password.getString(context),
                  isPassword: true,
                ),
                SizedBox(height: 20.h),
                CustomTextFormField(
                  controller: _confirmPasswordController,
                  hintText: AppLocale.confirmPasswordHint.getString(context),
                  keyboardType: TextInputType.visiblePassword,
                  label: AppLocale.confirmPassword.getString(context),
                  isPassword: true,
                ),
                SizedBox(height: 50.h),
                state is ForgetPasswordLoading
                    ? const Center(child: CircularProgressIndicator())
                    : AppBottom(
                        text: AppLocale.savePassword.getString(context),
                        onTap: () {
                          if (_passwordController.text.isNotEmpty &&
                              _confirmPasswordController.text.isNotEmpty) {
                            if (_passwordController.text ==
                                _confirmPasswordController.text) {
                              context.read<ForgetPasswordCubit>().resetPassword(
                                    newPassword: _passwordController.text,
                                  );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    AppLocale.passwordsDoNotMatch.getString(context),
                                  ),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppLocale.pleaseFillAllFields.getString(context),
                                ),
                              ),
                            );
                          }
                        },
                        barColor: AppColor.primaryColor,
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
