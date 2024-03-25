import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invenx_app/common/entities/entities.dart';
import 'package:invenx_app/common/extensions/extensions.dart';
import 'package:invenx_app/common/style/style.dart';
import 'package:invenx_app/common/utils/utils.dart';
import 'package:invenx_app/pages/product/index.dart';
import 'package:invenx_app/pages/product/refactors/detail_product.dart';

class ProductList extends GetView<ProductController> {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.state.isLoading && controller.state.products.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      return Expanded(
        child: ListView.separated(
          controller: controller.scroll,
          itemCount: controller.state.products.length +
              (controller.state.hasMoreData ? 1 : 0),
          itemBuilder: (context, index) {
            return Obx(() {
              if (index < controller.state.products.length) {
                Product product = controller.state.products[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                  leading: (controller.state.isEditing.value == true)
                      ? Checkbox(
                          value: controller.state.selectedList[index],
                          onChanged: (value) {
                            controller.toggleProductSelection(index);
                          },
                          side:
                              const BorderSide(color: Colors.black, width: 2.0))
                      : null,
                  title: Text(
                    product.productName,
                    style: CustomTextStyle.textRegularMedium
                        .copyWith(color: AppColor.fgPrimary),
                  ),
                  subtitle: Text(
                    'Stok : ${product.stock}',
                    style: CustomTextStyle.textSmallRegular
                        .copyWith(color: AppColor.fgSecondary),
                  ),
                  trailing: Text(
                    product.price.toCurrencyFormat(),
                    style: CustomTextStyle.textRegularMedium
                        .copyWith(color: AppColor.fgPrimary),
                  ),
                  onTap: () {
                    showDetailProduct(context, product);
                  },
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: controller.state.hasMoreData
                        ? const CircularProgressIndicator()
                        : const Text("No more data"),
                  ),
                );
              }
            });
          },
          separatorBuilder: (context, index) =>
              const Divider(color: AppColor.borderSecondary),
        ),
      );
    });
  }

  Future<dynamic> showDetailProduct(BuildContext context, Product product) {
    RxString currentCategory = "".obs;

    Future<void> getCurrentCategory(int id) async {
      currentCategory.value =
          await controller.getCategoryName(product.categoryId);
    }

    return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      backgroundColor: AppColor.bgPrimary,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
      ),
      builder: (context) {
        getCurrentCategory(product.categoryId);
        return DetailProduct(
          product: product,
          currentCategory: currentCategory,
        );
      },
    );
  }
}
