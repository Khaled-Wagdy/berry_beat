import 'package:bery_beat/core/routes/routes.dart';
import 'package:bery_beat/features/auth/cubit/auth_cubit.dart';

import 'package:bery_beat/features/auth/ui/sign_in_screen.dart';
import 'package:bery_beat/features/auth/ui/sign_up_screen.dart';
import 'package:bery_beat/features/home/ui/home_screen.dart';
import 'package:bery_beat/features/forget_password/ui/forget_password_screen.dart';
import 'package:bery_beat/features/forget_password/ui/otp_screen.dart';
import 'package:bery_beat/features/forget_password/ui/new_password_screen.dart';
import 'package:bery_beat/features/screens/featuer_screen.dart';
import 'package:bery_beat/features/screens/info_screen.dart';
import 'package:bery_beat/features/screens/welcome_screen.dart';
import 'package:bery_beat/features/forget_password/cubit/forget_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  // Cubit يتعمل جديد كل مرة يبدأ الـ forget password flow
  ForgetPasswordCubit? _forgetPasswordCubit;

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.signInScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const SignInScreen(),
          ),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const SignUpScreen(),
          ),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.forgetPasswordScreen:
        // كل مرة يفتح صفحة forget password يتعمل cubit جديد نظيف
        _forgetPasswordCubit = ForgetPasswordCubit();
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _forgetPasswordCubit!,
            child: const ForgetPasswordScreen(),
          ),
        );
      case Routes.welcomeScreen:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case Routes.infoScreen:
        return MaterialPageRoute(builder: (_) => const InfoScreen());
      case Routes.featureScreen:
        return MaterialPageRoute(builder: (_) => const FeatureScreen());
      case Routes.otpScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _forgetPasswordCubit!,
            child: const OtpScreen(),
          ),
        );
      case Routes.newPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _forgetPasswordCubit!,
            child: const NewPasswordScreen(),
          ),
        );

      default:
        return null;
    }
  }
}
