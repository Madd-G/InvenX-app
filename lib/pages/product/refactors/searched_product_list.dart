import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invenx_app/common/entities/entities.dart';
import 'package:invenx_app/common/extensions/extensions.dart';
import 'package:invenx_app/common/res/media_res.dart';
import 'package:invenx_app/common/style/style.dart';
import 'package:invenx_app/common/utils/utils.dart';
import 'package:invenx_app/common/widgets/widgets.dart';
import 'package:invenx_app/pages/product/index.dart';
import 'package:invenx_app/pages/product/widgets/widgets.dart';

class SearchedProductList extends GetView<ProductController> {
  const SearchedProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Expanded(
        child: ListView.separated(
          controller: controller.scroll,
          itemCount: controller.state.productSearched.length,
          itemBuilder: (context, index) {
            return Obx(() {
              Product product = controller.state.productSearched[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                title: Text(
                  controller.state.productSearched[index].productName,
                  style: CustomTextStyle.textRegularMedium
                      .copyWith(color: AppColor.fgPrimary),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // '$currentCategory',
                      'Kategori id : ${controller.state.productSearched[index].categoryId}',
                      style: CustomTextStyle.textSmallRegular
                          .copyWith(color: AppColor.fgSecondary),
                    ),
                    Text(
                      controller.state.productSearched[index].productGroup,
                      style: CustomTextStyle.textSmallRegular
                          .copyWith(color: AppColor.fgSecondary),
                    ),
                  ],
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Stok : ${controller.state.productSearched[index].stock}",
                      style: CustomTextStyle.textSmallRegular
                          .copyWith(color: AppColor.fgSecondary),
                    ),
                    Text(
                      controller.state.productSearched[index].price
                          .toCurrencyFormat(),
                      style: CustomTextStyle.textRegularMedium
                          .copyWith(color: AppColor.fgPrimary),
                    ),
                  ],
                ),
                onTap: () => showDetailProduct(context, product),
              );
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
          borderRadius: BorderRadius.vertical(top: Radius.circular(12.0))),
      builder: (context) {
        getCurrentCategory(product.categoryId);
        return Padding(
          padding: EdgeInsets.only(
              left: 16.0,
              top: 16.0,
              right: 16.0,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Center(
                  child: RoundedContainer(
                    radius: 90,
                    height: 6.0,
                    width: 120.0,
                    containerColor: AppColor.borderPrimary,
                  ),
                ),
                const SizedBox(height: 8.0),
                Image.asset(MediaRes.productImage),
                const SizedBox(height: 20.0),
                RoundedContainer(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                    child: Column(
                      children: [
                        DetailProductItem(
                          title: "Nama Barang",
                          value: product.productName,
                        ),
                        const Divider(
                            color: AppColor.borderPrimary, thickness: 1.0),
                        Obx(
                          () => DetailProductItem(
                            title: "Kategori",
                            value: currentCategory.value,
                          ),
                        ),
                        const Divider(
                            color: AppColor.borderPrimary, thickness: 1.0),
                        DetailProductItem(
                          title: "Kelompok",
                          value: product.productGroup,
                        ),
                        const Divider(
                            color: AppColor.borderPrimary, thickness: 1.0),
                        DetailProductItem(
                          title: "Stok",
                          value: product.stock.toString(),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                RoundedContainer(
                  containerColor: AppColor.bgSecondary,
                  radius: 10.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Harga',
                          style: CustomTextStyle.textRegularMedium
                              .copyWith(color: AppColor.fgPrimary),
                        ),
                        Text(
                          product.price.toCurrencyFormat(),
                          style: CustomTextStyle.textRegularMedium
                              .copyWith(color: AppColor.fgPrimary),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.deleteProduct(product.id!);
                          controller.fetchAllProducts();
                          Get.back();
                        },
                        child: RoundedContainer(
                          radius: 8.0,
                          borderWidth: 1.5,
                          borderColor: AppColor.borderPrimary,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Center(
                              child: Text(
                                'Hapus Barang',
                                style: CustomTextStyle.textRegularMedium
                                    .copyWith(color: AppColor.danger),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                          showUpdateProductForm(context, product);
                          controller.fetchCategories();
                        },
                        child: RoundedContainer(
                          radius: 8.0,
                          borderWidth: 1.5,
                          containerColor: AppColor.primary,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Center(
                              child: Text(
                                'Edit Barang',
                                style: CustomTextStyle.textRegularMedium
                                    .copyWith(color: AppColor.onPrimary),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> showUpdateProductForm(BuildContext context, Product product) {
    final formKey = GlobalKey<FormState>();
    return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      backgroundColor: AppColor.bgPrimary,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
      ),
      builder: (context) {
        return UpdateProductForm(formKey: formKey, product: product);
      },
    );
  }
}
