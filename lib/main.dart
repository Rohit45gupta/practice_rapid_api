import 'package:flutter/material.dart';
import 'package:practice_api/view/bottom_navigation_bar/bottom_navigation_screen.dart';
import 'package:practice_api/view/intro_screen/signUp_screen.dart';
import 'package:practice_api/view/intro_screen/splash_screen.dart';
import 'package:practice_api/viewModel/api_provider.dart';
import 'package:practice_api/viewModel/enterainment_api_provider.dart';
import 'package:practice_api/viewModel/news_api_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ApiProvider()),
    ChangeNotifierProvider(create: (_) => EntertainmentApiprovider()),
    ChangeNotifierProvider(create: (_) => NewsApiProvider()),

  ],
  child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:BottomNavigationScreen() ,
    );
  }
}

