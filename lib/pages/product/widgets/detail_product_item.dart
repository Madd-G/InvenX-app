import 'package:flutter/material.dart';
import 'package:invenx_app/common/style/style.dart';
import 'package:invenx_app/common/utils/utils.dart';

class DetailProductItem extends StatelessWidget {
  const DetailProductItem({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: CustomTextStyle.textRegularMedium
              .copyWith(color: AppColor.fgPrimary),
        ),
        Text(
          value,
          style: CustomTextStyle.textRegularMedium
              .copyWith(color: AppColor.fgSecondary),
        ),
      ],
    );
  }
}
