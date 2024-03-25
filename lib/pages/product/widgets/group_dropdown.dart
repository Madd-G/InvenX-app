import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invenx_app/common/style/style.dart';
import 'package:invenx_app/common/utils/utils.dart';
import 'package:invenx_app/pages/product/index.dart';

class GroupDropdown extends GetView<ProductController> {
  const GroupDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final List<String>? selectedCategoryGroups = controller.state.groups
            .firstWhereOrNull((group) =>
                group.categoryName == controller.state.category!.value)
            ?.groups;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kategori Barang*',
                style: CustomTextStyle.textRegularMedium
                    .copyWith(color: AppColor.fgPrimary)),
            const SizedBox(height: 4.0),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: IgnorePointer(
                ignoring: (selectedCategoryGroups == null) ? true : false,
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<String>(
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
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 0.0),
                      filled: true,
                      fillColor: AppColor.bgPrimary,
                    ),
                    validator: (String? value) {
                      if (value == null ||
                          value.isEmpty ||
                          value == "Pilih Kelompok Barang") {
                        return '❗Kelompok Barang Belum diisi';
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
                    items: selectedCategoryGroups
                        ?.map<DropdownMenuItem<String>>((group) {
                      return DropdownMenuItem<String>(
                        value: group,
                        child: Text("      $group"),
                      );
                    }).toList(),
                    hint: Obx(
                      () => Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          controller.state.group!.value,
                          style: CustomTextStyle.textRegular
                              .copyWith(color: AppColor.fgSecondary),
                        ),
                      ),
                    ),
                    style: CustomTextStyle.textRegularMedium
                        .copyWith(color: AppColor.fgPrimary),
                    onChanged: (String? value) {
                      controller.state.group!.value = value!;
                    },
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
