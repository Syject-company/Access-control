import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/services/navigation.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';

class ActionBarNoTitleSearchWorker extends StatelessWidget
    with PreferredSizeWidget {
  ActionBarNoTitleSearchWorker({Key? key, required this.onBackPress})
      : super(key: key);

  final VoidCallback onBackPress;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: ColorsRes.backGround,
      leadingWidth: Dimensions.leadingWidth65.w,
      leading: Center(
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: ColorsRes.appBarIcon,
            size: Dimensions.appBarIcon.h,
          ),
          iconSize: Dimensions.appBarIcon.h,
          onPressed:onBackPress,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Dimensions.appBarHeight.h);
}
