import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invenx_app/common/routes/routes.dart';
import 'package:invenx_app/common/style/style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      theme: AppTheme.light,
      getPages: AppPages.routes,
      defaultTransition: Transition.noTransition,
    );
  }
}

