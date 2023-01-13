import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safe_access/core/enums/enums.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/icons_res.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/utils/extension.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.navType,
    this.onLogOut,
    this.onSearch,
    this.onNewSearch,
    this.onEdit,
    this.onDownload,
  }) : super(key: key);

  final BottomNavTypeSelected navType;
  final VoidCallback? onLogOut;
  final VoidCallback? onSearch;
  final VoidCallback? onNewSearch;
  final VoidCallback? onEdit;
  final VoidCallback? onDownload;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Dimensions.navBarHeight.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Visibility(
              visible: navType == BottomNavTypeSelected.newSearchDownload,
              child: Row(
                children: <Widget>[
                  _button(
                    title: StringsRes.download,
                    icon: IconsRes.download,
                    onTap: onDownload,
                  ),
                  SizedBox(
                    width: Dimensions.margin43.w,
                  ),
                ],
              ),
            ),
            IndexedStack(
              index: navType.navIndex,
              alignment: Alignment.center,
              children: <Widget>[
                _button(
                  title: StringsRes.logOut,
                  icon: IconsRes.logout,
                  onTap: onLogOut,
                ),
                _button(
                  title: StringsRes.search,
                  icon: IconsRes.search,
                  onTap: onSearch,
                ),
                _button(
                  title: StringsRes.newSearch,
                  icon: IconsRes.search,
                  onTap: onNewSearch,
                ),
                _button(
                  title: StringsRes.editProfile,
                  icon: IconsRes.edit,
                  onTap: onEdit,
                ),
              ],
            ),
          ],
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: ColorsRes.gry,
              width: 0.1,
            ),
          ),
        ));
  }

  Widget _button({
    required String title,
    required String icon,
    required VoidCallback? onTap,
  }) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              icon,
              matchTextDirection: true,
              color: ColorsRes.navBarActiveIcon,
              width: Dimensions.bottomNavIcon.h,
              height: Dimensions.bottomNavIcon.h,
            ),
            iconSize: Dimensions.appBarIcon.h,
            onPressed: onTap,
          ),
          TextView(
            title: title,
            weight: FontWeight.w600,
            size: TextSizes.sp10.sp,
            color: ColorsRes.navBarTitle,
          ),
          SizedBox(
            height: Dimensions.margin3.h,
          ),
        ],
      );
}
