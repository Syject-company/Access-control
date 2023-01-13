import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/utils/extension.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';
import 'package:safe_access/features/presentation/widgets/title_button.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.allAlertsCount,
    required this.alertsCount,
    required this.filterOnTap,
  }) : super(key: key);

  final int allAlertsCount;
  final int alertsCount;
  final VoidCallback filterOnTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _alertsCount,
        _filterByClassification,
      ],
    );
  }

  Widget get _alertsCount => TextView(
        title: allAlertsCount.showingCount(alertsCount),
        size: TextSizes.sp13.sp,
        weight: FontWeight.w400,
        align: TextAlign.center,
        color: ColorsRes.exceptionsTitle,
      );

  Widget get _filterByClassification => Row(
        children: <Widget>[
          const Icon(
            Icons.filter_alt_outlined,
            color: ColorsRes.secondPrimary,
          ),
          TitleButton(
            title: StringsRes.filterByClassification,
            color: ColorsRes.steelBlueText,
            onTap: filterOnTap,
            titleSize: TextSizes.sp13,
            titleWeight: FontWeight.w600,
          ),
        ],
      );
}
