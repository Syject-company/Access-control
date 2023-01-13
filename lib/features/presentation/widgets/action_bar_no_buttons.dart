import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class ActionBarNoButtons extends StatelessWidget with PreferredSizeWidget {
  const ActionBarNoButtons({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextView(
        title: title,
        weight: FontWeight.w600,
        size: TextSizes.sp17.sp,
        align: TextAlign.center,
        color: ColorsRes.secondPrimary,
      ),
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Dimensions.appBarHeight.h);
}
