import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invenx_app/pages/product/controller.dart';
import 'package:invenx_app/pages/product/widgets/widgets.dart';

class FloatingButton extends GetView<ProductController> {
  const FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        child: (controller.state.isEditing.value == false)
            ? const AddProductButton()
            : const DeleteProductButton(),
      ),
    );
  }
}

