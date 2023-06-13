import 'package:flutter/material.dart';
import 'package:news/layout/home_layout.dart';
import 'package:news/screens/news_details.dart';
import 'package:news/shared/styles/my_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeLayout.routeName: (context) => HomeLayout(),
        NewsDetails.routeName: (context) => NewsDetails(),
      },
      initialRoute: HomeLayout.routeName,
      theme: MyThemeData.lightTheme,
    );
  }
}
