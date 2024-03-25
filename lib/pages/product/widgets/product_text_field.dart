import 'package:flutter/material.dart';
import 'package:invenx_app/common/style/style.dart';
import 'package:invenx_app/common/utils/utils.dart';
import 'package:invenx_app/common/widgets/widgets.dart';

class ProductTextField extends StatelessWidget {
  const ProductTextField({
    super.key,
    required this.titleText,
    required this.hintText,
    required this.controller,
    this.validationErrorMessage,
  });

  final String titleText;
  final String hintText;
  final TextEditingController controller;
  final String? validationErrorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titleText,
            style: CustomTextStyle.textRegularMedium
                .copyWith(color: AppColor.fgPrimary, letterSpacing: -0.01)),
        const SizedBox(height: 4.0),
        CustomTextField(
          validationErrorMessage: '❗$validationErrorMessage',
          controller: controller,
          hintText: hintText,
          keyboardType: TextInputType.name,
          overrideValidator: false,
          hintStyle: CustomTextStyle.textRegular
              .copyWith(color: AppColor.fgSecondary, letterSpacing: -0.01),
          // onChanged: (String value) {},
        ),
      ],
    );
  }
}
