import 'package:atm_flutter_app/resources/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData defaultTheme = ThemeData().copyWith(
    primaryColor: AppColors.colorsPrimary,
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: AppColors.colorsPrimary),
    textTheme: const TextTheme(
        subtitle1: TextStyle(color: AppColors.black),
        bodyText1: TextStyle(color: AppColors.white),
        bodyText2: TextStyle(color: AppColors.colorsPrimary)),
    inputDecorationTheme: const InputDecorationTheme(
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.colorsPrimary)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.colorsPrimary)),
        focusColor: AppColors.white),
  );

  static ThemeData rossoCorsaTheme = ThemeData().copyWith(
    primaryColor: AppColors.rossoCorsa,
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: AppColors.rossoCorsa),
    textTheme: const TextTheme(
        subtitle1: TextStyle(color: AppColors.black),
        bodyText1: TextStyle(color: AppColors.white),
        bodyText2: TextStyle(color: AppColors.rossoCorsa)),
    inputDecorationTheme: const InputDecorationTheme(
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.rossoCorsa)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.rossoCorsa)),
        focusColor: AppColors.white),
  );

  static ThemeData flameTheme = ThemeData().copyWith(
    primaryColor: AppColors.flame,
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: AppColors.flame),
    textTheme: const TextTheme(
        subtitle1: TextStyle(color: AppColors.black),
        bodyText1: TextStyle(color: AppColors.white),
        bodyText2: TextStyle(color: AppColors.flame)),
    inputDecorationTheme: const InputDecorationTheme(
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.flame)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.flame)),
        focusColor: AppColors.white),
  );

  static ThemeData brightOrangeTheme = ThemeData().copyWith(
    primaryColor: AppColors.brightOrange,
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: AppColors.brightOrange),
    textTheme: const TextTheme(
        subtitle1: TextStyle(color: AppColors.black),
        bodyText1: TextStyle(color: AppColors.white),
        bodyText2: TextStyle(color: AppColors.brightOrange)),
    inputDecorationTheme: const InputDecorationTheme(
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.brightOrange)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.brightOrange)),
        focusColor: AppColors.white),
  );

  static ThemeData lightningYellowTheme = ThemeData().copyWith(
    primaryColor: AppColors.lightningYellow,
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: AppColors.lightningYellow),
    textTheme: const TextTheme(
        subtitle1: TextStyle(color: AppColors.black),
        bodyText1: TextStyle(color: AppColors.white),
        bodyText2: TextStyle(color: AppColors.lightningYellow)),
    inputDecorationTheme: const InputDecorationTheme(
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.lightningYellow)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.lightningYellow)),
        focusColor: AppColors.white),
  );

  static ThemeData rhinoTheme = ThemeData().copyWith(
    primaryColor: AppColors.rhino,
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: AppColors.rhino),
    textTheme: const TextTheme(
        subtitle1: TextStyle(color: AppColors.black),
        bodyText1: TextStyle(color: AppColors.white),
        bodyText2: TextStyle(color: AppColors.rhino)),
    inputDecorationTheme: const InputDecorationTheme(
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.rhino)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.rhino)),
        focusColor: AppColors.white),
  );

  static ThemeData yaleBlueTheme = ThemeData().copyWith(
    primaryColor: AppColors.yaleBlue,
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: AppColors.yaleBlue),
    textTheme: const TextTheme(
        subtitle1: TextStyle(color: AppColors.black),
        bodyText1: TextStyle(color: AppColors.white),
        bodyText2: TextStyle(color: AppColors.yaleBlue)),
    inputDecorationTheme: const InputDecorationTheme(
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.yaleBlue)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.yaleBlue)),
        focusColor: AppColors.white),
  );

  static ThemeData blueIvyTheme = ThemeData().copyWith(
    primaryColor: AppColors.blueIvy,
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: AppColors.blueIvy),
    textTheme: const TextTheme(
        subtitle1: TextStyle(color: AppColors.black),
        bodyText1: TextStyle(color: AppColors.white),
        bodyText2: TextStyle(color: AppColors.blueIvy)),
    inputDecorationTheme: const InputDecorationTheme(
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.blueIvy)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.blueIvy)),
        focusColor: AppColors.white),
  );

  static ThemeData dodgerBlueTheme = ThemeData().copyWith(
    primaryColor: AppColors.dodgerBlue,
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: AppColors.dodgerBlue),
    textTheme: const TextTheme(
        subtitle1: TextStyle(color: AppColors.black),
        bodyText1: TextStyle(color: AppColors.white),
        bodyText2: TextStyle(color: AppColors.dodgerBlue)),
    inputDecorationTheme: const InputDecorationTheme(
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.dodgerBlue)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.dodgerBlue)),
        focusColor: AppColors.white),
  );

  static ThemeData shamrockGreenVColorTheme = ThemeData().copyWith(
    primaryColor: AppColors.shamrockGreenVColor,
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: AppColors.shamrockGreenVColor),
    textTheme: const TextTheme(
        subtitle1: TextStyle(color: AppColors.black),
        bodyText1: TextStyle(color: AppColors.white),
        bodyText2: TextStyle(color: AppColors.shamrockGreenVColor)),
    inputDecorationTheme: const InputDecorationTheme(
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.shamrockGreenVColor)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.shamrockGreenVColor)),
        focusColor: AppColors.white),
  );

  static ThemeData lightForestGreenTheme = ThemeData().copyWith(
    primaryColor: AppColors.lightForestGreen,
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: AppColors.lightForestGreen),
    textTheme: const TextTheme(
        subtitle1: TextStyle(color: AppColors.black),
        bodyText1: TextStyle(color: AppColors.white),
        bodyText2: TextStyle(color: AppColors.lightForestGreen)),
    inputDecorationTheme: const InputDecorationTheme(
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.lightForestGreen)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.lightForestGreen)),
        focusColor: AppColors.white),
  );

  static ThemeData jungleGreenTheme = ThemeData().copyWith(
    primaryColor: AppColors.jungleGreen,
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: AppColors.jungleGreen),
    textTheme: const TextTheme(
        subtitle1: TextStyle(color: AppColors.black),
        bodyText1: TextStyle(color: AppColors.white),
        bodyText2: TextStyle(color: AppColors.jungleGreen)),
    inputDecorationTheme: const InputDecorationTheme(
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.jungleGreen)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.jungleGreen)),
        focusColor: AppColors.white),
  );

  static ThemeData paleOliveGreenTheme = ThemeData().copyWith(
    primaryColor: AppColors.paleOliveGreen,
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: AppColors.paleOliveGreen),
    textTheme: const TextTheme(
        subtitle1: TextStyle(color: AppColors.black),
        bodyText1: TextStyle(color: AppColors.white),
        bodyText2: TextStyle(color: AppColors.paleOliveGreen)),
    inputDecorationTheme: const InputDecorationTheme(
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.paleOliveGreen)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.paleOliveGreen)),
        focusColor: AppColors.white),
  );

  static ThemeData shipGreyTheme = ThemeData().copyWith(
    primaryColor: AppColors.shipGrey,
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: AppColors.shipGrey),
    textTheme: const TextTheme(
        subtitle1: TextStyle(color: AppColors.black),
        bodyText1: TextStyle(color: AppColors.white),
        bodyText2: TextStyle(color: AppColors.shipGrey)),
    inputDecorationTheme: const InputDecorationTheme(
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.shipGrey)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.shipGrey)),
        focusColor: AppColors.white),
  );

  static ThemeData greyishPurpleTheme = ThemeData().copyWith(
    primaryColor: AppColors.greyishPurple,
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: AppColors.greyishPurple),
    textTheme: const TextTheme(
        subtitle1: TextStyle(color: AppColors.black),
        bodyText1: TextStyle(color: AppColors.white),
        bodyText2: TextStyle(color: AppColors.greyishPurple)),
    inputDecorationTheme: const InputDecorationTheme(
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.greyishPurple)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.greyishPurple)),
        focusColor: AppColors.white),
  );

  static ThemeData lightEggplantTheme = ThemeData().copyWith(
    primaryColor: AppColors.lightEggplant,
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: AppColors.lightEggplant),
    textTheme: const TextTheme(
        subtitle1: TextStyle(color: AppColors.black),
        bodyText1: TextStyle(color: AppColors.white),
        bodyText2: TextStyle(color: AppColors.lightEggplant)),
    inputDecorationTheme: const InputDecorationTheme(
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.lightEggplant)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.lightEggplant)),
        focusColor: AppColors.white),
  );

  static ThemeData persianPinkTheme = ThemeData().copyWith(
    primaryColor: AppColors.persianPink,
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: AppColors.persianPink),
    textTheme: const TextTheme(
        subtitle1: TextStyle(color: AppColors.black),
        bodyText1: TextStyle(color: AppColors.white),
        bodyText2: TextStyle(color: AppColors.persianPink)),
    inputDecorationTheme: const InputDecorationTheme(
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.persianPink)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.persianPink)),
        focusColor: AppColors.white),
  );

  static ThemeData darkTheme = ThemeData().copyWith(
    primaryColor: AppColors.dark,
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: AppColors.dark),
    textTheme: const TextTheme(
        subtitle1: TextStyle(color: AppColors.black),
        bodyText1: TextStyle(color: AppColors.white),
        bodyText2: TextStyle(color: AppColors.dark)),
    inputDecorationTheme: const InputDecorationTheme(
        border:
            UnderlineInputBorder(borderSide: BorderSide(color: AppColors.dark)),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: AppColors.dark)),
        focusColor: AppColors.white),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.dark),
  );

  static ThemeData lightTheme = ThemeData().copyWith(
    primaryColor: AppColors.light,
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: AppColors.light),
    textTheme: const TextTheme(
        subtitle1: TextStyle(color: AppColors.black),
        bodyText1: TextStyle(color: AppColors.white),
        bodyText2: TextStyle(color: AppColors.light)),
    inputDecorationTheme: const InputDecorationTheme(
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.light)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.light)),
        focusColor: AppColors.white),
  );
}
