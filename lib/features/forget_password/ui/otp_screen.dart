import 'package:bery_beat/core/custom/app_bottom.dart';
import 'package:bery_beat/core/routes/routes.dart';
import 'package:bery_beat/core/thems/app_color.dart';
import 'package:bery_beat/features/forget_password/cubit/forget_password_cubit.dart';
import 'package:bery_beat/features/forget_password/cubit/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:bery_beat/core/localization/app_locale.dart';
import 'package:bery_beat/core/custom/language_toggle_button.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _pinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 48.w, // Slightly smaller to fit 6 digits
      height: 56.h,
      textStyle: TextStyle(
        fontSize: 20.sp,
        color: const Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12.r),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColor.primaryColor),
      borderRadius: BorderRadius.circular(8.r),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

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
          if (state is CodeVerifiedSuccess) {
            Navigator.pushNamed(context, Routes.newPasswordScreen);
          } else if (state is ForgetPasswordError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
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
                  AppLocale.verificationCode.getString(context),
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  AppLocale.otpDesc.getString(context),
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                ),
                SizedBox(height: 60.h),
                Center(
                  child: Pinput(
                    length: 6,
                    controller: _pinController,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    onCompleted: (pin) {
                      context.read<ForgetPasswordCubit>().verifyCode(pin);
                    },
                  ),
                ),
                SizedBox(height: 50.h),
                state is ForgetPasswordLoading
                    ? const Center(child: CircularProgressIndicator())
                    : AppBottom(
                        text: AppLocale.verify.getString(context),
                        onTap: () {
                          if (_pinController.text.length == 6) {
                            context.read<ForgetPasswordCubit>().verifyCode(
                              _pinController.text,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppLocale.pleaseEnterOtp.getString(context),
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
