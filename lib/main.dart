import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:news/layout/home_layout.dart';
import 'package:news/providers/my_provider.dart';
import 'package:news/screens/news_details.dart';
import 'package:news/screens/settings.dart';
import 'package:news/shared/styles/my_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
void main() {
  runApp( ChangeNotifierProvider(create: (BuildContext context) =>MyProvider(),
  child: MyApp()));
}

class MyApp extends StatelessWidget {
   MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   var pro=Provider.of<MyProvider>(context);
    return MaterialApp(
      locale: Locale(pro.language),
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'), // Spanish
      ],

      debugShowCheckedModeBanner: false,
      routes: {
        HomeLayout.routeName: (context) => HomeLayout(),
        NewsDetails.routeName: (context) => NewsDetails(),
        Settings.routeName: (context) => Settings(),
      },
      initialRoute: HomeLayout.routeName,
      theme: MyThemeData.lightTheme,
    );
  }
}
