import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:practice_api/view/intro_screen/signIn_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bottom_navigation_bar/bottom_navigation_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startSplashTimer();
  }

  Future<void> startSplashTimer() async {
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('userData');

    if (userData != null && json.decode(userData)['email'] != null) {

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavigationScreen(),));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen(),));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Text(
              "Splash Screen",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 60),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          ],
        ),
      ),
    );
  }
}