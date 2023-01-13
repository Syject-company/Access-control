import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/core/enums/enums.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/utils/extension.dart'
    show PhotoCaptureTextIndex;
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class WorkerPhotoCaptureText extends StatelessWidget {
  const WorkerPhotoCaptureText({Key? key, required this.textType})
      : super(key: key);

  final WorkerPhotoCaptureTextType textType;

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: textType.textIndex,
      alignment: Alignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.camera_alt_outlined,
              color: ColorsRes.accent,
            ),
            SizedBox(
              width: Dimensions.margin5.w,
            ),
            TextView(
              title: StringsRes.clickCapture,
              size: TextSizes.sp15.sp,
              weight: FontWeight.w400,
              align: TextAlign.center,
              color: ColorsRes.primaryText,
            ),
          ],
        ),
        TextView(
          title: StringsRes.captureSuccessful,
          size: TextSizes.sp15.sp,
          weight: FontWeight.w400,
          align: TextAlign.center,
          color: ColorsRes.clickableTitle,
        ),
      ],
    );
  }
}
