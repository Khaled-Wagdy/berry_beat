import 'package:bery_beat/features/auth/ui/sign_up_screen.dart';
import 'package:bery_beat/features/screens/splash_screen.dart';
import 'package:bery_beat/features/auth/ui/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BerryBeatApp extends StatelessWidget {
  const BerryBeatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        routes: {
          '/signIn': (context) => const SignInScreen(),
          '/signUp': (context) => const SignUpScreen(),
        },
      ),
    );
  }
}
