import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/icons_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class NavPageFlatButton extends StatelessWidget {
  const NavPageFlatButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isArrowShown = true,
    this.isIgnoringClick = false,
  }) : super(key: key);

  final String title;
  final String icon;
  final VoidCallback onTap;
  final bool isArrowShown;
  final bool isIgnoringClick;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IgnorePointer(
        ignoring: isIgnoringClick,
        child: OutlinedButton(
            onPressed: onTap,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: Dimensions.margin32.w,
                ),
                SvgPicture.asset(
                  icon,
                  height: Dimensions.workerNavButtonFirstIcon.h,
                  width: Dimensions.workerNavButtonFirstIcon.w,
                  matchTextDirection: true,
                ),
                SizedBox(
                  width: Dimensions.margin16.w,
                ),
                TextView(
                  title: title,
                  weight: FontWeight.w600,
                  size: TextSizes.sp16.sp,
                  align: TextAlign.center,
                  color: ColorsRes.primaryText,
                ),
                Visibility(
                  visible: isIgnoringClick && !isArrowShown,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: Dimensions.margin16.w,
                      ),
                      SvgPicture.asset(
                        IconsRes.checkMark,
                        height: Dimensions.checkMarkSize.w,
                        width: Dimensions.checkMarkSize.w,
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Visibility(
                  visible: isArrowShown,
                  child: SvgPicture.asset(
                    IconsRes.arrowRight,
                    height: Dimensions.workerNavButtonIcon.h,
                    width: Dimensions.workerNavButtonIcon.w,
                    fit: BoxFit.fill,
                    matchTextDirection: true,
                  ),
                ),
                SizedBox(
                  width: Dimensions.margin32.w,
                ),
              ],
            ),
            style: OutlinedButton.styleFrom(
              primary: ColorsRes.secondPrimary,
              backgroundColor: ColorsRes.primary,
              minimumSize: Size(
                Dimensions.workerNavButtonWidth.w,
                Dimensions.workerNavButtonHeight.h,
              ),
              maximumSize: Size(
                Dimensions.workerNavButtonWidth.w,
                Dimensions.workerNavButtonHeight.h,
              ),
              side: BorderSide(
                width: 0.2.w,
                color: Colors.black12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0.w),
              ),
              padding: EdgeInsets.zero,
            )),
      ),
    );
  }
}
