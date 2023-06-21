import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/bloc_observer.dart';
import 'package:news/layout/home_layout.dart';
import 'package:news/providers/my_provider.dart';
import 'package:news/screens/news_details.dart';
import 'package:news/screens/settings.dart';
import 'package:news/shared/styles/my_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  Bloc.observer=MyBlocObserver();
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => MyProvider(), builder: (context, child) =>  MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  late MyProvider pro;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    pro = Provider.of<MyProvider>(context);
    getPreferences();
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        locale: Locale(pro.language),
        localizationsDelegates: const [
          AppLocalizations.delegate, // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('ar'), // Spanish
        ],
        debugShowCheckedModeBanner: false,
        routes: {
          HomeLayout.routeName: (context) => const HomeLayout(),
          NewsDetails.routeName: (context) => const NewsDetails(),
          Settings.routeName: (context) => const Settings(),
        },
        initialRoute: HomeLayout.routeName,
        theme: MyThemeData.lightTheme,
        darkTheme: MyThemeData.darkTheme,
        themeMode: pro.themeMode,
      ),
    );
  }

  // initSharedPref() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String language = prefs.getString('lang') ?? 'en';
  //   pro.changeLanguage(language);
  //   String? mode = prefs.getString('mode');
  //   pro.changeTheme(mode == 'light' ? ThemeMode.light : ThemeMode.dark);
  // }
  void getPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('theme') == 'dark') {
      pro.changeTheme(ThemeMode.dark);
    } else if (prefs.getString('theme') == 'system') {
      pro.changeTheme(ThemeMode.system);
    } else {
      pro.changeTheme(ThemeMode.light);
    }
    String lan = prefs.getString('language') ?? 'en';
    pro.changeLanguage(lan);
  }
}
