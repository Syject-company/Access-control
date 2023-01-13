import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class NotificationBlock extends StatelessWidget {
  const NotificationBlock({
    Key? key,
    required this.msg,
    required this.onTap,
  }) : super(key: key);

  final String msg;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: Dimensions.notificationBlockHeight.h,
                width: Dimensions.notificationMSGBlockWidth.w,
                alignment: Alignment.centerLeft,
                child: TextView(
                  title: msg,
                  weight: FontWeight.w600,
                  size: TextSizes.sp14.sp,
                  color: ColorsRes.steelBlueText,
                  lines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.close,
                color: ColorsRes.appBarIcon,
                size: Dimensions.navIcon.h,
              ),
            ],
          ),
          style: OutlinedButton.styleFrom(
            primary: ColorsRes.borderButton,
            backgroundColor: ColorsRes.notificationBack,
            minimumSize: Size(
              Dimensions.notificationBlockWidth.w,
              Dimensions.notificationBlockHeight.h,
            ),
            maximumSize: Size(
              Dimensions.notificationBlockWidth.w,
              Dimensions.notificationBlockHeight.h,
            ),
            side: BorderSide(
              width: 0.1.w,
              color: ColorsRes.notificationBack,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.all(Dimensions.padding8.h),

          )),
    );
  }
}
