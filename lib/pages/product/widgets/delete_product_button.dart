import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invenx_app/common/style/style.dart';
import 'package:invenx_app/common/utils/utils.dart';
import 'package:invenx_app/common/widgets/widgets.dart';
import 'package:invenx_app/pages/product/index.dart';

class DeleteProductButton extends GetView<ProductController> {
  const DeleteProductButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                Obx(
                  () => Checkbox(
                    value: controller.isAllSelected(),
                    onChanged: (value) {
                      controller.toggleSelectAll();
                    },
                    side: const BorderSide(
                        color: AppColor.fgSecondary, width: 2.0),
                  ),
                ),
                const Text(
                  'Pilih Semua',
                  style: CustomTextStyle.textSmallMedium,
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: GestureDetector(
            onTap: () {
              controller.deleteMultipleProduct(controller.selectedIds);
              controller.fetchAllProducts();
              // controller.getPaginatedProducts();
            },
            child: RoundedContainer(
              radius: 8.0,
              borderWidth: 1.5,
              borderColor: AppColor.borderPrimary,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 16.0),
                child: Text(
                  'Hapus Barang',
                  style: CustomTextStyle.textRegularMedium
                      .copyWith(color: AppColor.danger),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
