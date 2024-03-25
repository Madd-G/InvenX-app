import 'package:flutter/material.dart';

import 'color.dart';

class AppTheme {
  static const horizontalMargin = 16.0;
  static const radius = 10.0;

  static ThemeData light = ThemeData(
    fontFamily: "Inter",
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColor.bgPrimary,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    primaryColor: AppColor.fgPrimary,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColor.bgPrimary,
      iconTheme: IconThemeData(
        color: AppColor.fgPrimary,
      ),
      titleTextStyle: TextStyle(
        color: AppColor.fgPrimary,
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
      ),
      toolbarTextStyle: TextStyle(
        color: AppColor.fgPrimary,
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColor.bgPrimary,
        modalBackgroundColor: AppColor.bgPrimary),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColor.bgPrimary,
      unselectedLabelStyle: TextStyle(fontSize: 12),
      selectedLabelStyle: TextStyle(fontSize: 12),
      unselectedItemColor: Color(0xffA2A5B9),
      selectedItemColor: AppColor.fgPrimary,
    ),
    tabBarTheme: const TabBarTheme(
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: AppColor.fgPrimary,
      unselectedLabelColor: AppColor.fgSecondary,
    ),
  );
}
