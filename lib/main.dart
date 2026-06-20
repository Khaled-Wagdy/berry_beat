import 'package:bery_beat/berry_beat_app.dart';
import 'package:bery_beat/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localization/flutter_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterLocalization.instance.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('token');
  final bool isLoggedIn = token != null && token.isNotEmpty;

  runApp(BerryBeatApp(appRouter: AppRouter(), isLoggedIn: isLoggedIn));
}
