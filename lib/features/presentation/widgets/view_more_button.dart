import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/widgets/prog_indicator.dart';
import 'package:safe_access/features/presentation/widgets/title_button.dart';

class ViewMoreButton extends StatelessWidget {
  const ViewMoreButton({
    Key? key,
    required this.onTap,
    required this.isLoadingMore,
    required this.isVisible,
  }) : super(key: key);

  final bool isVisible;
  final bool isLoadingMore;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Container(
        height: 52,
        margin: EdgeInsets.only(
          bottom: Dimensions.margin8.h,
          top: Dimensions.margin13.h,
        ),
        child: Center(
          child: isLoadingMore
              ? const ProgIndicator()
              : TitleButton(
                  title: StringsRes.viewMore,
                  color: ColorsRes.steelBlueText,
                  onTap: onTap,
                  titleSize: TextSizes.sp16,
                  titleWeight: FontWeight.w600,
                ),
        ),
      ),
    );
  }
}
