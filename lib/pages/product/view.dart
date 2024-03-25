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
        title: const Text(
          'List Stok Barang',
          style: CustomTextStyle.textExtraLargeMedium,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
                onTap: () {},
                child: const Icon(Icons.search, size: 24.0)),
          ),
        ],
      ),
      body: Obx(
        () {
          return Padding(
          padding: EdgeInsets.only(
              left: 16.0,
              top: 16.0,
              right: 16.0,
              bottom: controller.isEditing.value == true ? 60.0 : 0.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Text(
                      '${controller.state.products.length} Data ditampilkan',
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
                        (controller.isEditing.value == false)
                            ? 'Edit Data'
                            : ' Batalkan',
                        style: CustomTextStyle.textSmallMedium.copyWith(
                          color: controller.isEditing.value == true
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
