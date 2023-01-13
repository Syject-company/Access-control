import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class WorkerDetailField extends StatelessWidget {
  const WorkerDetailField({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Dimensions.workerDetailsFieldWidth.w,
        height: Dimensions.workerDetailsFieldHeight.h,
        padding: EdgeInsets.symmetric(horizontal: Dimensions.padding16.w),
        margin: EdgeInsets.only(bottom: Dimensions.margin16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: ColorsRes.switchIcon,
            width: Dimensions.padding2,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextView(
              title: title,
              weight: FontWeight.w400,
              size: TextSizes.sp13.sp,
              color: ColorsRes.subText,
            ),
            SizedBox(
              height: Dimensions.margin5.h,
            ),
            TextView(
              title: data,
              weight: FontWeight.w600,
              size: TextSizes.sp16.sp,
              color: ColorsRes.primaryText,
              align: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
