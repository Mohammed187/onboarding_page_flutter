import 'package:flutter/material.dart';
import 'package:onboarding_page_flutter/pages/home_page.dart';
import 'package:onboarding_page_flutter/pages/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome');

  runApp(MyApp(showHome: showHome));
}

class MyApp extends StatelessWidget {
  bool? showHome = false;

  MyApp({Key? key, required this.showHome}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OnBoarding Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: showHome! ? const HomePage() : const OnboardingPage(),
    );
  }
}
