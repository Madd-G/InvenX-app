import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invenx_app/common/style/color.dart';
import 'package:invenx_app/common/utils/custom_text_style.dart';
import 'package:invenx_app/pages/product/index.dart';
import 'package:invenx_app/pages/product/widgets/widgets.dart';

class ProductView extends GetView<ProductController> {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shadowColor: AppColor.fgPrimary,
        backgroundColor: AppColor.bgPrimary,
        elevation: 1.0,
        title: Obx(
          () => controller.state.isSearching.value
              ? TextField(
                  onChanged: (value) => controller.filterProduct(value),
                  decoration: const InputDecoration(
                    labelText: 'Search',
                  ),
                )
              : const Text(
                  'List Stok Barang',
                  style: CustomTextStyle.textExtraLargeMedium,
                ),
        ),
        actions: [
          Obx(
            () => controller.state.isSearching.value
                ? Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: GestureDetector(
                        onTap: () => controller.state.isSearching.value = false,
                        child: const Icon(Icons.close, size: 24.0)),
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: GestureDetector(
                        onTap: () => controller.state.isSearching.value = true,
                        child: const Icon(Icons.search, size: 24.0)),
                  ),
          ),
        ],
      ),
      body: Obx(
        () {
          print('selectedIds: ${controller.state.selectedIds}');
          return Padding(
            padding: EdgeInsets.only(
                left: 16.0,
                top: 16.0,
                right: 16.0,
                bottom: controller.state.isEditing.value == true ? 60.0 : 0.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Text(
                        '${controller.state.isSearching.value ? controller.state.foundProducts.length : controller.state.products.length} Data ditampilkan',
                        style: CustomTextStyle.textSmallRegular.copyWith(
                          color: AppColor.fgSecondary,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.toggleEditing();
                      },
                      child: Obx(
                        () => Text(
                          (controller.state.isEditing.value == false)
                              ? 'Edit Data'
                              : ' Batalkan',
                          style: CustomTextStyle.textSmallMedium.copyWith(
                            color: controller.state.isEditing.value == true
                                ? AppColor.fgSecondary
                                : AppColor.info,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const ProductList(),
              ],
            ),
          );
        },
      ),
      floatingActionButton: const FloatingButton(),
    );
  }
}
