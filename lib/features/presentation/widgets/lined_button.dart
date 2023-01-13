import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class LinedButton extends StatelessWidget {
  const LinedButton({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          primary: ColorsRes.borderButton,
          backgroundColor: ColorsRes.backGround,
          fixedSize: Size(
            Dimensions.buttonWidth.w,
            Dimensions.buttonHeight48.h,
          ),
          side: const BorderSide(
            width: 2.0,
            color: ColorsRes.borderButton,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0.r),
          ),
        ),
        child: TextView(
          title: label,
          align: TextAlign.center,
          size: TextSizes.sp16.sp,
          color: ColorsRes.borderButton,
          weight: FontWeight.w700,
        ),
      ),
    );
  }
}
