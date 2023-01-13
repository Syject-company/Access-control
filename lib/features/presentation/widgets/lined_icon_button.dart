import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';

class LinedIconButton extends StatelessWidget {
  const LinedIconButton({
    Key? key,
    required this.label,
    required this.onTap,
    required this.icon,
    required this.iconSize,
    required this.width,
    required this.height,
    this.backColor = Colors.white,
    this.iconColor = ColorsRes.settingsIcon,
    this.borderSide,
    this.borderRadius = 0.0,
    this.padding = Dimensions.padding13,
    this.splashFactory = NoSplash.splashFactory,
    required this.textStyle,
  }) : super(key: key);

  final String label;
  final VoidCallback onTap;
  final String icon;
  final double iconSize;
  final double width;
  final double height;
  final Color backColor;
  final Color iconColor;
  final BorderSide? borderSide;
  final double borderRadius;
  final double padding;
  final TextStyle textStyle;
  final InteractiveInkFeatureFactory? splashFactory;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          primary: ColorsRes.borderButton,
          splashFactory: splashFactory,
          backgroundColor: backColor,
          padding: EdgeInsets.symmetric(horizontal: Dimensions.padding12.w),
          fixedSize: Size(
            width,
            height,
          ),
          side: borderSide,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                label.tr(),
                textAlign: TextAlign.center,
                style: textStyle,
              ),
              SvgPicture.asset(
                icon,
                color: iconColor,
                height: iconSize,
                width: iconSize,
                matchTextDirection: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
