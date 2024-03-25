// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invenx_app/pages/product/index.dart';
import 'routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.PRODUCT;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.PRODUCT,
      page: () => const ProductView(),
      binding: ProductBinding(),
    ),
    // GetPage(
    //   name: AppRoutes.ADD_PRODUCT,
    //   page: () => const AddProductView(),
    //   binding: AddProductBinding(),
    // ),
  ];
}
