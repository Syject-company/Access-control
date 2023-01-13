import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/services/navigation.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/icons_res.dart';
import 'package:safe_access/features/presentation/resources/routes/route_name.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    Key? key,
    this.bottomMargin = Dimensions.margin24,
  }) : super(key: key);

  final double bottomMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.floatingButton.w,
      height: Dimensions.floatingButton.h,
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.margin13.w,
        vertical: bottomMargin.r,
      ),
      child: FloatingActionButton(
          elevation: 0.0,
          child: SvgPicture.asset(
            IconsRes.home,
            matchTextDirection: true,
            height: Dimensions.floatingButtonIcon.h,
            width: Dimensions.floatingButtonIcon.w,
          ),
          backgroundColor: ColorsRes.floatingBack,
          onPressed: () => getIt<Navigation>().toRemoveUntil(RouteName.home)),
    );
  }
}
