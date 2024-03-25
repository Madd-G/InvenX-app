import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invenx_app/common/style/style.dart';
import 'package:invenx_app/common/utils/utils.dart';
import 'package:invenx_app/pages/product/index.dart';

class MyAppBar extends GetView<ProductController>
    implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(0, 1.0),
          spreadRadius: 1.5,
          blurRadius: 1.0,
        )
      ]),
      child: AppBar(
        centerTitle: true,
        shadowColor: AppColor.fgPrimary,
        backgroundColor: AppColor.bgPrimary,
        elevation: 1.0,
        title: Obx(
          () => controller.state.isSearching.value
              ? Center(
                  child: Align(
                    alignment: Alignment.center,
                    child: TextField(
                      cursorColor: Colors.grey,
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: (value) => controller.searchProduct(value),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(900.0),
                            borderSide:
                                const BorderSide(color: AppColor.bgSecondary)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(900.0),
                            borderSide:
                                const BorderSide(color: AppColor.bgSecondary)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(900.0),
                            borderSide:
                                const BorderSide(color: AppColor.bgSecondary)),
                        filled: true,
                        fillColor: AppColor.bgSecondary,
                        prefixIcon: const Icon(
                          CupertinoIcons.search,
                          color: AppColor.fgSecondary,
                        ),
                        hintText: "Cari data...",
                        hintStyle: CustomTextStyle.textRegular
                            .copyWith(color: AppColor.fgSecondary),
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                      ),
                    ),
                  ),
                )
              : const Text(
                  'List Stok Barang',
                  style: CustomTextStyle.textExtraLargeMedium,
                ),
        ),
        actions: [
          Obx(
            () => controller.state.isSearching.value
                ? Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: GestureDetector(
                        onTap: () => controller.state.isSearching.value = false,
                        child: const Icon(Icons.close, size: 24.0)),
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: GestureDetector(
                        onTap: () => controller.state.isSearching.value = true,
                        child: const Icon(Icons.search, size: 24.0)),
                  ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
