import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invenx_app/pages/product/index.dart';
import 'package:invenx_app/pages/product/refactors/refactors.dart';
import 'package:invenx_app/pages/product/widgets/widgets.dart';

class ProductView extends GetView<ProductController> {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Obx(
        () {
          return Padding(
            padding: EdgeInsets.only(
              left: 16.0,
              top: 16.0,
              right: 16.0,
              bottom: controller.state.isEditing.value == true ? 60.0 : 0.0,
            ),
            child: Obx(
              () => Column(
                children: [
                  const SizedBox(height: 16.0),
                  const BodyHeader(),
                  const SizedBox(height: 32.0),
                  (controller.state.isSearching.value)
                      ? const SearchedProductList()
                      : const ProductList(),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton:
          (!controller.state.isSearching.value) ? const FloatingButton() : null,
    );
  }
}
