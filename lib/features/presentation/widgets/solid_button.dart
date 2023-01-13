import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';

class SolidButton extends StatelessWidget {
  const SolidButton({
    Key? key,
    required this.label,
    required this.onTap,
    required this.controller,
    this.isAnimateOnTap = true,
    this.isClickable = true,
    this.backColor = ColorsRes.solidButton,
  }) : super(key: key);

  final String label;
  final VoidCallback onTap;
  final bool isAnimateOnTap;
  final bool isClickable;
  final Color backColor;
  final RoundedLoadingButtonController controller;

  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      controller: controller,
      onPressed: isClickable ? onTap : null,
      disabledColor: ColorsRes.solidButton,
      color: backColor,
      borderRadius: 4.0.r,
      height: Dimensions.buttonHeight48.h,
      width: Dimensions.buttonWidth.w,
      successColor: backColor,
      animateOnTap: isAnimateOnTap,
      child: Text(
        label.tr(),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: TextSizes.sp16.sp,
          color: ColorsRes.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
