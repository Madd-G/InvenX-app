import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invenx_app/common/style/style.dart';
import 'package:invenx_app/common/utils/utils.dart';
import 'package:invenx_app/pages/product/index.dart';

class BodyHeader extends GetView<ProductController> {
  const BodyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(
          () => controller.state.isSearching.value
              ? Text(
                  '${controller.state.productSearched.length} Data cocok',
                  style: CustomTextStyle.textSmallRegular.copyWith(
                    color: AppColor.fgSecondary,
                  ),
                )
              : Text(
                  '${controller.state.products.length} Data ditampilkan',
                  style: CustomTextStyle.textSmallRegular.copyWith(
                    color: AppColor.fgSecondary,
                  ),
                ),
        ),
        if (!controller.state.isSearching.value)
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
    );
  }
}
