import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invenx_app/common/entities/entities.dart';
import 'package:invenx_app/common/style/style.dart';
import 'package:invenx_app/common/utils/utils.dart';
import 'package:invenx_app/pages/product/controller.dart';

class UpdateCategoryDropdown extends GetView<ProductController> {
  const UpdateCategoryDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Kategori Barang*',
            style: CustomTextStyle.textRegularMedium
                .copyWith(color: AppColor.fgPrimary)),
        const SizedBox(height: 4.0),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Obx(
            () => DropdownButtonHideUnderline(
              child: DropdownButtonFormField<Category>(
                decoration: InputDecoration(
                  constraints: const BoxConstraints(maxWidth: 450.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                        color: AppColor.borderSecondary, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 1.5,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                  filled: true,
                  fillColor: AppColor.bgPrimary,
                ),
                validator: (Category? value) {
                  if (value == null ||
                      value.categoryName.isEmpty ||
                      value.categoryName == "Pilih Kategori Barang") {
                    return '❗Kategori Barang Belum diisi';
                  }
                  return null; // Return null if validation passes
                },
                padding: EdgeInsets.zero,
                dropdownColor: Colors.white,
                isDense: true,
                icon: const Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                    size: 15.0,
                  ),
                ),
                items: controller.state.categories.map((val) {
                  return DropdownMenuItem<Category>(
                    value: val,
                    child: Text("      ${val.categoryName}"),
                  );
                }).toList(),
                hint: Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      controller.state.category!.value,
                      style: CustomTextStyle.textRegular
                          .copyWith(color: AppColor.fgSecondary),
                    ),
                  ),
                ),
                style: CustomTextStyle.textRegularMedium
                    .copyWith(color: AppColor.fgPrimary),
                onChanged: (Category? val) {
                  controller.state.category!.value = val!.categoryName;
                  controller.state.categoryId?.value = val.id;
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
