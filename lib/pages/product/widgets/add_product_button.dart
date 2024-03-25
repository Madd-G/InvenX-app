import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invenx_app/common/style/style.dart';
import 'package:invenx_app/common/utils/utils.dart';
import 'package:invenx_app/common/widgets/widgets.dart';
import 'package:invenx_app/pages/product/index.dart';
import 'package:invenx_app/pages/product/widgets/widgets.dart';

class AddProductButton extends GetView<ProductController> {
  const AddProductButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      foregroundColor: AppColor.onPrimary,
      backgroundColor: AppColor.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(360.0)),
      ),
      onPressed: () {
        showAddProductForm(context);
        controller.fetchCategories();
      },
      label: const Padding(
        padding: EdgeInsets.only(top: 8.0, right: 11.5, bottom: 8.0),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 4.0),
              child: Icon(Icons.add, size: 32),
            ),
            Text("Barang", style: CustomTextStyle.textLargeMedium),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showAddProductForm(BuildContext context) {
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
                  Center(
                    child: Text('Tambah Barang',
                        style: CustomTextStyle.textExtraLargeSemiBold
                            .copyWith(color: AppColor.fgPrimary)),
                  ),
                  const SizedBox(height: 16.0),
                  ProductTextField(
                    controller: controller.nameController,
                    titleText: "Nama Barang*",
                    hintText: "Masukkan Nama Barang",
                    validationErrorMessage: "Nama Barang Belum diisi",
                  ),
                  const SizedBox(height: 16.0),
                  const CategoryDropdown(),
                  const SizedBox(height: 16.0),
                  const GroupDropdown(),
                  const SizedBox(height: 16.0),
                  ProductTextField(
                    controller: controller.stockController,
                    titleText: "Stok*",
                    hintText: "Masukkan Stok",
                    validationErrorMessage: "Stok Belum diisi",
                  ),
                  const SizedBox(height: 16.0),
                  ProductTextField(
                    controller: controller.priceController,
                    titleText: "Harga*",
                    hintText: "Masukkan Harga",
                    validationErrorMessage: "Harga Belum diisi",
                  ),
                  const SizedBox(height: 16.0),
                  GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        controller.addProduct();
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
                            child: Text('Tambah Barang',
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
  }
}
