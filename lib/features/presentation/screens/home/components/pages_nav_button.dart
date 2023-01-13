import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class PagesNavButton extends StatelessWidget {
  const PagesNavButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.alertCount = 0,
  }) : super(key: key);

  final String title;
  final String icon;
  final VoidCallback onTap;
  final int alertCount;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
          onPressed: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SvgPicture.asset(
                    icon,
                    height: Dimensions.navButtonIcon.h,
                    width: Dimensions.navButtonIcon.h,
                    alignment: AlignmentDirectional.centerStart,
                  ),
                  Visibility(
                    visible: alertCount != 0,
                    child: Container(
                      child: TextView(
                        title: '$alertCount ${StringsRes.newBadge}',
                        weight: FontWeight.w400,
                        size: TextSizes.sp12.sp,
                        color: ColorsRes.badgeText,
                        align: TextAlign.end,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0.r),
                        color: ColorsRes.badgeBackText.withOpacity(0.3),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.padding8.w,
                        vertical: Dimensions.padding2.h,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Dimensions.margin5.h,
              ),
              TextView(
                title: title,
                weight: alertCount != 0 ? FontWeight.w700 : FontWeight.w600,
                size: TextSizes.sp16.sp,
                color: ColorsRes.navButtonText,
              ),
            ],
          ),
          style: OutlinedButton.styleFrom(
            primary: ColorsRes.borderButton,
            backgroundColor: ColorsRes.appBarBackground,
            alignment: Alignment.centerLeft,
            minimumSize: Size(
              Dimensions.navButtonWidth.w,
              Dimensions.navButtonHeight.h,
            ),
            maximumSize: Size(
              Dimensions.navButtonWidth.w,
              Dimensions.navButtonHeight.h,
            ),
            side: BorderSide(
              width: 1.0.w,
              color: ColorsRes.appBarBackground,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0.r),
            ),
            padding: EdgeInsets.symmetric(
              vertical: Dimensions.padding6.h,
              horizontal: Dimensions.padding16.w,
            ),
          )),
    );
  }
}
