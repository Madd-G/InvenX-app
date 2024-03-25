import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invenx_app/common/entities/entities.dart';
import 'package:invenx_app/common/style/style.dart';
import 'package:invenx_app/common/utils/utils.dart';
import 'package:invenx_app/common/widgets/widgets.dart';
import 'package:invenx_app/pages/product/index.dart';
import 'package:invenx_app/pages/product/widgets/widgets.dart';

class UpdateProductForm extends GetView<ProductController> {
  const UpdateProductForm({
    super.key,
    required this.formKey,
    required this.product,
  });

  final GlobalKey<FormState> formKey;
  final Product product;

  @override
  Widget build(BuildContext context) {
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
                controller: controller.updateNameController,
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
  }
}
