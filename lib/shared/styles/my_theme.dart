import 'package:flutter/material.dart';
import 'package:news/shared/styles/app_colors.dart';
import 'package:news/shared/styles/text_styles.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(

      primaryColor: AppColor.lightColor,
      brightness: Brightness.light,
      textTheme: TextTheme(
          bodyLarge: AppStyles.exo22White(),
          bodyMedium: AppStyles.poppins24Black(),
          bodySmall: AppStyles.poppins14Light()),
      appBarTheme:  AppBarTheme(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          titleTextStyle: AppStyles.exo22White(),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white, size: 30)),
    );
  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColor.lightColor,
    brightness: Brightness.dark,


    appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.lightColor,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white, size: 30)),
    textTheme: TextTheme(
        bodyLarge: AppStyles.exo22White(),
        bodyMedium: AppStyles.poppins24Black().copyWith(color: Colors.white),
        bodySmall: AppStyles.poppins14Light().copyWith(color: Colors.white)
    ),


  );
}
