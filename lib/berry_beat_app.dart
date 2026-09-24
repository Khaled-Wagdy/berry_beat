import 'package:bery_beat/core/routes/app_router.dart';
import 'package:bery_beat/features/screens/welcome_screen.dart';
import 'package:bery_beat/features/home/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:bery_beat/core/localization/app_locale.dart';

class BerryBeatApp extends StatefulWidget {
  final AppRouter appRouter;
  final bool isLoggedIn;

  const BerryBeatApp({
    super.key,
    required this.appRouter,
    required this.isLoggedIn,
  });

  @override
  State<BerryBeatApp> createState() => _BerryBeatAppState();
}

class _BerryBeatAppState extends State<BerryBeatApp> {
  final FlutterLocalization localization = FlutterLocalization.instance;

  @override
  void initState() {
    localization.onTranslatedLanguage = _onTranslatedLanguage;
    _initializeLocalization();
    super.initState();
  }

  void _initializeLocalization() {
    localization.init(
      initLanguageCode: 'en',
      mapLocales: const [
        MapLocale('en', AppLocale.EN),
        MapLocale('ar', AppLocale.AR),
      ],
    );
  }

  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        supportedLocales: localization.supportedLocales,
        localizationsDelegates: localization.localizationsDelegates,
        onGenerateRoute: widget.appRouter.onGenerateRoute,
        home: widget.isLoggedIn ? const HomeScreen() : const WelcomeScreen(),
      ),
    );
  }
}
