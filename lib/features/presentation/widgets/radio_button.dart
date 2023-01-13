import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';

class RadioButton extends StatelessWidget {
  const RadioButton({
    Key? key,
    required this.isChecked,
    required this.onPressed,
  }) : super(key: key);

  final bool isChecked;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
          onPressed: onPressed,
          child: isChecked
              ? Container(
                  width: Dimensions.radio.w,
                  height: Dimensions.radio.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorsRes.secondPrimary,
                  ),
                )
              : const SizedBox.shrink(),
          style: OutlinedButton.styleFrom(
            primary: ColorsRes.borderButton,
            backgroundColor: ColorsRes.backGround,
            minimumSize: Size(
              Dimensions.radioBox.w,
              Dimensions.radioBox.h,
            ),
            side: BorderSide(
              width: 2.0.w,
              color: ColorsRes.borderRadio,
            ),
            shape: const CircleBorder(),
            padding: EdgeInsets.zero,
          )),
    );
  }
}
