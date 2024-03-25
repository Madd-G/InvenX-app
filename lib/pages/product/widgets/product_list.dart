import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invenx_app/common/apis/category.dart';
import 'package:invenx_app/common/entities/entities.dart';
import 'package:invenx_app/common/extensions/extensions.dart';
import 'package:invenx_app/common/res/media_res.dart';
import 'package:invenx_app/common/style/style.dart';
import 'package:invenx_app/common/utils/utils.dart';
import 'package:invenx_app/common/widgets/widgets.dart';
import 'package:invenx_app/pages/product/index.dart';
import 'package:invenx_app/pages/product/widgets/widgets.dart';

class ProductList extends GetView<ProductController> {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.state.isLoading && controller.state.products.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      print('length: ${controller.state.foundProducts.length}');
      return Expanded(
        child: ListView.separated(
          controller: controller.scroll,
          itemCount: controller.state.isSearching.value == true
              ? controller.state.foundProducts.length
              : controller.state.products.length +
                  (controller.state.hasMoreData ? 1 : 0),
          itemBuilder: (context, index) {
            return Obx(() {
              if (index < controller.state.products.length) {
                Product product = controller.state.products[index];
                // Product productSearched =  controller.state.foundProducts[index];
                print('product id: ${product.id}');
                print('productSearched id: ${controller.state.foundProducts}');
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                  leading: (controller.state.isEditing.value == true)
                      ? Checkbox(
                          value: controller.state.selectedList[index],
                          onChanged: (value) {
                            controller.toggleProductSelection(index);
                          },
                          side: const BorderSide(
                              color: AppColor.fgSecondary, width: 2.0),
                        )
                      : null,
                  title: Text(
                    controller.state.isSearching.value
                        ? controller.state.foundProducts[index].productName
                        : product.productName,
                    style: CustomTextStyle.textRegularMedium,
                  ),
                  subtitle: Text(
                    'Stok : ${controller.state.isSearching.value ? controller.state.foundProducts[index].stock : product.stock}',
                    style: CustomTextStyle.textSmallRegular,
                  ),
                  trailing: Text(
                    controller.state.isSearching.value
                        ? controller.state.foundProducts[index].price
                            .toCurrencyFormat()
                        : product.price.toCurrencyFormat(),
                    style: CustomTextStyle.textRegularMedium,
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

    Future<String> getCategoryName(int id) async {
      Category category = await CategoryAPI.getCategoryById(id);
      return category.categoryName;
    }

    Future<void> getCurrentCategory(int id) async {
      currentCategory.value = await getCategoryName(product.categoryId);
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
        return Padding(
          padding: EdgeInsets.only(
              left: 16.0,
              top: 16.0,
              right: 16.0,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
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
                  const Center(
                    child: Text('Update Barang',
                        style: CustomTextStyle.textExtraLargeSemiBold),
                  ),
                  const SizedBox(height: 16.0),
                  UpdateProductTextField(
                    controller: controller.updateProductNameController,
                    titleText: "Nama Barang*",
                    hintText: "Masukkan Nama Barang",
                    validationErrorMessage: "Nama Barang Belum diisi",
                    value: product.productName,
                    onChanged: (String value) {},
                  ),
                  const SizedBox(height: 16.0),
                  const UpdateCategoryDropdown(),
                  const SizedBox(height: 16.0),
                  const GroupDropdown(),
                  const SizedBox(height: 16.0),
                  UpdateProductTextField(
                    controller: controller.updateStockController,
                    titleText: "Stok*",
                    hintText: "Masukkan Stok",
                    validationErrorMessage: "Stok Belum diisi",
                    value: product.stock.toString(),
                    onChanged: (String value) {},
                  ),
                  const SizedBox(height: 16.0),
                  UpdateProductTextField(
                    controller: controller.updatePriceController,
                    titleText: "Harga*",
                    hintText: "Masukkan Harga",
                    validationErrorMessage: "Harga Belum diisi",
                    value: product.price.toString(),
                    onChanged: (String value) {},
                  ),
                  const SizedBox(height: 16.0),
                  GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        // Product updatedProduct = Product();
                        // updatedProduct.id = product.id;
                        // updatedProduct.productName = controller.updateProductNameController.text;
                        // updatedProduct.categoryId = controller.state.categoryId!.value;
                        controller.updateProduct(product.id!);
                        // controller.state.category = "".obs;
                        // controller.state.group = "".obs;
                        Navigator.pop(context);
                        controller.fetchAllProducts();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: RoundedContainer(
                        radius: 360.0,
                        containerColor: AppColor.primary,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 111.5),
                          child: Center(
                            child: Text('Update Barang',
                                style: CustomTextStyle.textRegularMedium
                                    .copyWith(color: AppColor.onPrimary)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    // .whenComplete(() {});
  }
}
