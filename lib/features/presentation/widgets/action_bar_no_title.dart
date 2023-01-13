import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/services/navigation.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';

class ActionBarNoTitle extends StatelessWidget with PreferredSizeWidget {
  ActionBarNoTitle({Key? key}) : super(key: key);

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
          onPressed: () => getIt<Navigation>().pop(),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Dimensions.appBarHeight.h);
}
