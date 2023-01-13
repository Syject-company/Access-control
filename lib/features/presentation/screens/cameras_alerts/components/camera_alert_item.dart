import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class CameraAlertItem extends StatelessWidget {
  const CameraAlertItem({
    Key? key,
    required this.alertStatusTitle,
    required this.alertTime,
    required this.alertCameraId,
    required this.alertLocation,
  }) : super(key: key);

  final String alertStatusTitle;
  final String alertTime;
  final String alertCameraId;
  final String alertLocation;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: Dimensions.accessItemMinHeight.h,
        minWidth: Dimensions.accessItemMinWidth.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextView(
            title: alertStatusTitle,
            weight: FontWeight.w400,
            size: TextSizes.sp16.sp,
          ),
          SizedBox(
            height: Dimensions.margin5.h,
          ),
          TextView(
            title: alertTime,
            weight: FontWeight.w400,
            size: TextSizes.sp13.sp,
            color: ColorsRes.darkGreyText,
          ),
          SizedBox(
            height: Dimensions.margin10.h,
          ),
          Row(
            children: <Widget>[
              TextView(
                title: StringsRes.camera,
                weight: FontWeight.w400,
                size: TextSizes.sp13.sp,
              ),
              TextView(
                title: alertCameraId,
                weight: FontWeight.w700,
                size: TextSizes.sp13.sp,
              ),
            ],
          ),
          SizedBox(
            height: Dimensions.margin5.h,
          ),
          TextView(
            title: alertLocation,
            weight: FontWeight.w400,
            size: TextSizes.sp13.sp,
            color: ColorsRes.darkGreyText,
          ),
          Container(
            width: Dimensions.dividerWidth.w,
            margin: EdgeInsets.symmetric(vertical: Dimensions.margin16.h),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: ColorsRes.divider, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
