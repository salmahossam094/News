import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:news/layout/home_layout.dart';
import 'package:news/providers/my_provider.dart';
import 'package:news/screens/news_details.dart';
import 'package:news/screens/settings.dart';
import 'package:news/shared/styles/my_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => MyProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  late MyProvider pro;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    pro = Provider.of<MyProvider>(context);
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
      darkTheme: MyThemeData.darkTheme,
      themeMode: pro.mode,
    );
  }

  initShared() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String lan = pref.getString('lan') ?? '';
    pro.changeLanguage(lan);
    String mode = pref.getString('mode') ?? '';
    pro.changeTheme(mode == 'light' ? ThemeMode.light : ThemeMode.dark);
  }
}
