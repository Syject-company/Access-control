import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class CamerasAlertCount extends StatelessWidget {
  const CamerasAlertCount({
    Key? key,
    required this.alertsCount,
  }) : super(key: key);

  final int alertsCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        TextView(
          title: alertsCount.toString(),
          weight: FontWeight.w400,
          size: TextSizes.sp14.sp,
          color: ColorsRes.darkGreyText,
        ),
        SizedBox(
          width: Dimensions.margin3.w,
        ),
        TextView(
          title: StringsRes.alerts,
          weight: FontWeight.w400,
          size: TextSizes.sp14.sp,
          color: ColorsRes.darkGreyText,
        ),
      ],
    );
  }
}
