import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/services/navigation.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class ActionBar extends StatelessWidget with PreferredSizeWidget {
  ActionBar({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextView(
        title: title,
        key: UniqueKey(),
        weight: FontWeight.w600,
        size: TextSizes.sp17.sp,
        align: TextAlign.center,
        color: ColorsRes.secondPrimary,

      ),
      leadingWidth: Dimensions.leadingWidth65.w,
      leading: Center(
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: ColorsRes.appBarIcon,
            size: Dimensions.navIcon.h,
          ),
          iconSize: Dimensions.appBarIcon.h,
          onPressed: () => _backAndClose,
        ),
      ),
    );
  }

  void get _backAndClose => getIt<Navigation>().pop();

  @override
  Size get preferredSize => Size.fromHeight(Dimensions.appBarHeight.h);
}
