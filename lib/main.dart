import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing_app/google_login/google_login_page.dart';
import 'package:testing_app/pie_chart/pie_chart_page.dart';
import 'package:testing_app/testing_ui_pages/home_page.dart';
import 'package:testing_app/testing_ui_pages/onboarding_page.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:testing_app/web_view/web_view_page.dart';

import 'web_view/sample_webview.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  runApp(MyApp(showHome: showHome));
}

Future initialization(BuildContext? context) async {
  await Future.delayed(Duration(seconds: 0));
}

class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp({Key? key, required this.showHome}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: showHome ? HomePage() : const OnBoardingPage(),
      home: WebViewExample(),
    );
  }
}
