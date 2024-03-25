import 'package:flutter/material.dart';
import 'package:invenx_app/common/style/style.dart';
import 'package:invenx_app/common/utils/utils.dart';
import 'package:invenx_app/common/widgets/widgets.dart';

class UpdateProductTextField extends StatefulWidget {
  const UpdateProductTextField({
    super.key,
    required this.titleText,
    required this.hintText,
    required this.controller,
    this.validationErrorMessage,
    required this.value,
    required this.onChanged,
  });

  final String titleText;
  final String hintText;
  final TextEditingController controller;
  final String? validationErrorMessage;
  final String value;
  final ValueChanged<String> onChanged;

  @override
  State<UpdateProductTextField> createState() => _UpdateProductTextFieldState();
}

class _UpdateProductTextFieldState extends State<UpdateProductTextField> {
  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.value;
  }

  @override
  void dispose() {
    // widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.titleText,
          style: CustomTextStyle.textRegularMedium.copyWith(
            color: AppColor.fgPrimary,
            letterSpacing: -0.01,
          ),
        ),
        const SizedBox(height: 4.0),
        CustomTextField(
          validationErrorMessage: '❗${widget.validationErrorMessage}',
          controller: widget.controller,
          hintText: widget.hintText,
          keyboardType: TextInputType.name,
          onChanged: widget.onChanged,
          // Pass onChanged callback
          hintStyle: CustomTextStyle.textRegular,
        ),
      ],
    );
  }
}
